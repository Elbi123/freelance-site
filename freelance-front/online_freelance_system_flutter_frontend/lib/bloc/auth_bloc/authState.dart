import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isFailed;
  final bool isRegistered;
  final bool isRegistering;
  final bool isRegisterFailed;
  final User? user;
  final String? email;
  final String? password;

  AuthState(
      {this.isAuthenticated = false,
      this.isAuthenticating = false,
      this.isFailed = false,
      this.isRegistered = false,
      this.isRegistering = false,
      this.isRegisterFailed = false,
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

  factory AuthState.registering() {
    return AuthState(isRegistered: false, isRegistering: true);
  }
  factory AuthState.registered() {
    return AuthState(isRegistered: true, isRegistering: false);
  }

  factory AuthState.registerFailed() {
    return AuthState(isRegistered: false, isRegisterFailed: true);
  }
}
