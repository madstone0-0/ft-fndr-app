import 'package:flutter/foundation.dart';
import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:ft_fndr_app/services/AuthService.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthNotifier extends ChangeNotifier {
  final AuthService _authService;

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;

  AuthNotifier(this._authService);

  // Getters
  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // Initialize auth state (restore session)
  Future<void> initialize() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final user = await _authService.restoreSession();
      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = 'Failed to restore session';
    }

    notifyListeners();
  }

  // Login
  Future<bool> login(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(email, password);
      _user = response.user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = _extractErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  // Signup
  Future<bool> signup(String email, String password, String? name) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.signup(email, password, name);
      _user = response.user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = _extractErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    _errorMessage = null;
    notifyListeners();
  }

  // Helper to extract error message from exception
  String _extractErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'No internet connection';
    } else if (error.toString().contains('401')) {
      return 'Invalid email or password';
    } else if (error.toString().contains('409')) {
      return 'Email already exists';
    } else if (error.toString().contains('400')) {
      return 'Invalid request. Please check your input.';
    }
    return 'An error occurred. Please try again.';
  }
}
