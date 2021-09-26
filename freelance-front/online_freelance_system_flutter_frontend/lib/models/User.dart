import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;

  final String firstname;
  final String lastname;
  final String email;
  final String userName;
  final String userType;
  final String phonenumber;
  final String password;

  User(
      {this.id,
      required this.userName,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.userType,
      required this.phonenumber,
      required this.password});
  @override
  List<Object> get props =>
      [email, userType, userName, firstname, lastname, phonenumber, password];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      userName: json['username'],
      email: json['email'],
      userType: json['role'],
      phonenumber: json['phonenumber'],
      password: json['password'],
    );
  }
  @override
  String toString() =>
      'User {id:$id, name : $userName,email:$email,role:$userType,image:$phonenumber}';
}
