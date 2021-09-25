import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';

class Message extends Equatable {
  final User sender;
  final String time;
  final String text;
  final String bool;

  Message(
      {required this.sender,
      required this.time,
      required this.text,
      required this.bool});

  @override
  List<Object> get props => [];
}
