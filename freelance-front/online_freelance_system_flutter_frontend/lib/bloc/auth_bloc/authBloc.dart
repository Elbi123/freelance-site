import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authState.dart';
import 'package:online_freelance_system_flutter_frontend/repository/authRepo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo})
      : assert(authRepo != null),
        super(AuthState.loggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthRegister) {
      yield AuthState.registering();
      try {
        print("Creating User");
        await authRepo.createUser(event.user);
        print("user Created ...........");
        yield AuthState.registered();
        print(event.user);
      } catch (e) {
        AuthState.registerFailed();
        print("Reg Error ፡" + e.toString());
      }
    } else if (event is AuthLogin) {
      yield AuthState.authenticating();
      try {
        print("Loggin In");
        await authRepo.loginUser(event.email, event.password);
        print("userLogged In");

        yield AuthState.authenticated();
      } catch (e) {
        AuthState.authenticationFailed();
      }
    }
  }
}
