import 'package:online_freelance_system_flutter_frontend/data_provider/authDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';

class AuthRepo {
  final AuthDataProvider authDataProvider;
  AuthRepo({required this.authDataProvider}) : assert(authDataProvider != null);
  Future<User> signUp(User user) {
    return authDataProvider.signUp(user);
  }

  Future<User> signIn(String email, String password) {
    return authDataProvider.signIn(email, password);
  }
}
