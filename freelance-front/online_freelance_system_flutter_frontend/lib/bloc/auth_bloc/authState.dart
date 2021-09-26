import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isFailed;
  final User? user;
  final String? email;
  final String? password;

  AuthState(
      {required this.isAuthenticated,
      this.isAuthenticating = false,
      this.isFailed = false,
      this.user,
      this.email,
      this.password});

  factory AuthState.loggedOut() {
    return AuthState(isAuthenticated: false);
  }

  factory AuthState.authenticating() {
    return AuthState(isAuthenticated: false, isAuthenticating: true);
  }
  factory AuthState.authenticated() {
    return AuthState(isAuthenticated: true, isAuthenticating: false);
  }

  factory AuthState.authenticationFailed() {
    return AuthState(isAuthenticated: false, isFailed: true);
  }
}
