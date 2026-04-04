import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:dio/dio.dart';

class AuthService {
  final ApiService _apiService;
  final FlutterSecureStorage _secureStorage;

  static const String accessTokenKey = 'auth_atoken';
  static const String refreshTokenKey = 'auth_rtoken';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _userFirstNameKey = 'user_fname';
  static const String _userLastNameKey = 'user_lname';

  AuthService(this._apiService, this._secureStorage);

  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _apiService.login(request);
    await _saveAuthData(response);
    return response;
  }

  Future<AuthResponse> signup(String email, String password, String firstName, String lastName) async {
    final request = RegisterRequest(email: email, password: password, firstName: firstName, lastName: lastName);
    final response = await _apiService.register(request);
    await _saveAuthData(response);
    return response;
  }

  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      // Continue with local logout even if API call fails
    }
    await _clearAuthData();
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: accessTokenKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<User?> restoreSession() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return null;

    try {
      return await _apiService.getProfile();
    } catch (e) {
      // Fall back to locally cached data
      final userId = await _secureStorage.read(key: _userIdKey);
      final email = await _secureStorage.read(key: _userEmailKey);

      if (userId != null && email != null) {
        return User(
          id: userId,
          email: email,
          userMetadata: UserMetadata(
            firstName: await _secureStorage.read(key: _userFirstNameKey),
            lastName: await _secureStorage.read(key: _userLastNameKey),
          ),
        );
      }

      await _clearAuthData();
      return null;
    }
  }

  Future<void> _saveAuthData(AuthResponse response) async {
    await Future.wait([
      _secureStorage.write(key: accessTokenKey, value: response.data.accessToken),
      _secureStorage.write(key: refreshTokenKey, value: response.data.refreshToken),
      _secureStorage.write(key: _userIdKey, value: response.data.user.id),
      _secureStorage.write(key: _userEmailKey, value: response.data.user.email),
      if (response.data.user.userMetadata?.firstName != null)
        _secureStorage.write(key: _userFirstNameKey, value: response.data.user.userMetadata!.firstName!),
      if (response.data.user.userMetadata?.lastName != null)
        _secureStorage.write(key: _userLastNameKey, value: response.data.user.userMetadata!.lastName!),
    ]);
  }

  Future<void> _clearAuthData() async {
    await Future.wait([
      _secureStorage.delete(key: accessTokenKey),
      _secureStorage.delete(key: refreshTokenKey),
      _secureStorage.delete(key: _userIdKey),
      _secureStorage.delete(key: _userEmailKey),
      _secureStorage.delete(key: _userFirstNameKey),
      _secureStorage.delete(key: _userLastNameKey),
    ]);
  }
}

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;

  static const List<String> _publicRoutes = [loginRoute, signupRoute];

  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_publicRoutes.any((r) => options.path.contains(r))) {
      return handler.next(options);
    }

    final token = await _secureStorage.read(key: AuthService.accessTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await Future.wait([
        _secureStorage.delete(key: AuthService.accessTokenKey),
        _secureStorage.delete(key: AuthService.refreshTokenKey),
      ]);
    }

    handler.next(err);
  }
}
