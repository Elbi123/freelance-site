import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final String status;
  final String token;

  ApiResponse({required this.status, required this.token});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(status: json['status'], token: json['token']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }

  @override
  List<Object> get props => [status, token];
}
