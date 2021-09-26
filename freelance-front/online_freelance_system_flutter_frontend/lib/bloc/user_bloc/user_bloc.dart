import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/user_bloc/user_event.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserState initialState) : super(initialState);

  @override
  Stream<UserState> mapEventToState(UserEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
