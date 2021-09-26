import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

class ResponseMessage extends Equatable {
  final String status;
  final String message;

  ResponseMessage({required this.status, required this.message});
  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(status: json['status'], message: json['message']);
  }
  @override
  List<Object> get props => [];
}
