import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authState.dart';
import 'package:online_freelance_system_flutter_frontend/repository/authRepository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo})
      : assert(authRepo != null),
        super(AuthState.loggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthRegister) {
      yield AuthState.authenticating();
      try {
        print("Creating User");
        await authRepo.signUp(event.user);
        print("user Created ...........");
        yield AuthState.authenticated();
        print(event.user);
      } catch (e) {
        AuthState.authenticationFailed();
        print("Reg Error ፡" + e.toString());
      }
    } else if (event is AuthLogin) {
      yield AuthState.authenticating();
      try {
        print("Loggin In");
        await authRepo.signIn(event.email, event.password);
        print("userLogged In");
      } catch (e) {
        AuthState.authenticationFailed();
      }
    }
  }
}
