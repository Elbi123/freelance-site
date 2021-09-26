import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final User user;
  AuthRegister(this.user);
  @override
  List<Object> get props => [user];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  AuthLogin(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
