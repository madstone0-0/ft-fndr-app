import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:dio/dio.dart';

class AuthService {
  final ApiService _apiService;
  final FlutterSecureStorage _secureStorage;

  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';

  AuthService(this._apiService, this._secureStorage);

  // Login
  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _apiService.login(request);
    await _saveAuthData(response);
    return response;
  }

  // Signup
  Future<AuthResponse> signup(String email, String password, String? name) async {
    final request = SignupRequest(email: email, password: password, name: name);
    final response = await _apiService.signup(request);
    await _saveAuthData(response);
    return response;
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      // Continue with local logout even if API call fails
    }
    await _clearAuthData();
  }

  // Get current auth token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Restore session from storage
  Future<User?> restoreSession() async {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      // Try to get user profile from API
      final user = await _apiService.getProfile();
      return user;
    } catch (e) {
      // If API call fails, try to restore from local storage
      final userId = await _secureStorage.read(key: _userIdKey);
      final email = await _secureStorage.read(key: _userEmailKey);
      final name = await _secureStorage.read(key: _userNameKey);

      if (userId != null && email != null) {
        return User(id: userId, email: email, name: name);
      }

      // Session is invalid, clear auth data
      await _clearAuthData();
      return null;
    }
  }

  // Private helper to save auth data
  Future<void> _saveAuthData(AuthResponse response) async {
    await _secureStorage.write(key: _tokenKey, value: response.token);
    await _secureStorage.write(key: _userIdKey, value: response.user.id);
    await _secureStorage.write(key: _userEmailKey, value: response.user.email);
    if (response.user.name != null) {
      await _secureStorage.write(key: _userNameKey, value: response.user.name!);
    }
  }

  // Private helper to clear auth data
  Future<void> _clearAuthData() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _userIdKey);
    await _secureStorage.delete(key: _userEmailKey);
    await _secureStorage.delete(key: _userNameKey);
  }
}

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if ([loginRoute, signupRoute].any((r) => options.path.contains(r))) {
      return handler.next(options);
    }

    final token = await _secureStorage.read(key: AuthService._tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _secureStorage.delete(key: AuthService._tokenKey);
    }

    handler.next(err);
  }
}
