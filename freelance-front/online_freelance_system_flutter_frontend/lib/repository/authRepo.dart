import 'package:online_freelance_system_flutter_frontend/data_provider/authDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';
import 'package:online_freelance_system_flutter_frontend/models/apiResponse.dart';

class AuthRepo {
  final AuthDataProvider authDataProvider;

  AuthRepo({required this.authDataProvider});

  Future<User> createUser(User user) async {
    print("Repo user creating");
    return authDataProvider.signUp(user);
  }

  Future<ApiResponse> loginUser(
    String email,
    String password,
  ) async {
    print("Repo user Loginin");
    return authDataProvider.signIn(email, password);
  }

  // Future<User> getUserInfo(String email, String token) async {
  //   print("Getting User Profile .......");
  //   return await userDataProvider.getUserProfile(email, token);
  // }

  // Future<User> logOut() async {
  //   print("Repo user Loginin");
  //   return await userDataProvider.signout();

  //   print("Repo user oaggedIn");
  // }
}
