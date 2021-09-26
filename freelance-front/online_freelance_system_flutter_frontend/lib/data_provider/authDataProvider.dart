import 'dart:convert';
import 'dart:io';

import 'package:online_freelance_system_flutter_frontend/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:online_freelance_system_flutter_frontend/models/apiResponse.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class AuthDataProvider {
  AuthDataProvider(http.Client client);

  Future<ApiResponse> signIn(String email, String password) async {
    final url = Uri.parse(apiUrl + "/auth/login");

    final credentials = '$email:$password';
    print("Here");
    final basic = 'Basic ${base64Encode(utf8.encode(credentials))}';
    print(basic);
    final body = <String, String>{
      'emailOrUsername': email.toString(),
      'password': password.toString()
    };

    print("email");
    try {
      final response = await http.post(url,
          headers: {HttpHeaders.AUTHORIZATION: basic}, body: body);
      print("Status Code :" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print("Response ${json.decode(response.body)}");
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> signUp(User user) async {
    print("Heareeeeeeeeeeeeeeeeeeeee");
    final url = Uri.parse(apiUrl + '/auth/signup');
    print(url);
    print(user);
    final body = json.encode(<String, String>{
      'firstName': user.firstname,
      'lastName': user.lastname,
      'email': user.email,
      'phoneNumber': user.phonenumber,
      'password': user.password,
      'userType': user.userType,
    });
    try {
      final response = await http.post(url,
          headers: {'Content-type': 'application/json'}, body: body);
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception("User Not Registered Successfully");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
