import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:ft_fndr_app/providers/AuthNotifier.dart';
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
  final AuthNotifier _authNotifier;

  static const List<String> _publicRoutes = [
    loginRoute,
    signupRoute,
  ];

  bool _isHandlingUnauthorized = false;

  AuthInterceptor(this._secureStorage, this._authNotifier);

  bool _isPublicRoute(String path) {
    return _publicRoutes.any((r) => path.contains(r));
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublicRoute(options.path)) {
      return handler.next(options);
    }

    final token = await _secureStorage.read(
      key: AuthService.accessTokenKey,
    );

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isHandlingUnauthorized) {
      _isHandlingUnauthorized = true;

      try {
        await Future.wait([
          _secureStorage.delete(key: AuthService.accessTokenKey),
          _secureStorage.delete(key: AuthService.refreshTokenKey),
        ]);

        _authNotifier.handleSessionExpired();
      } finally {
        _isHandlingUnauthorized = false;
      }
    }

    return handler.next(err);
  }
}
