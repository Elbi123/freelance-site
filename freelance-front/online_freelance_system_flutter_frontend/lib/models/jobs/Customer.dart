import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Address.dart';

class Customer extends Equatable {
  Customer({
    required this.address,
    required this.customerType,
    required this.moneySpent,
    required this.createdAt,
  });

  final Address address;
  final String customerType;
  final String moneySpent;
  final DateTime createdAt;
  @override
  List<Object> get props => [address, customerType, moneySpent, createdAt];
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        address: Address.fromJson(json["address"]),
        customerType: json["customerType"],
        moneySpent: json["moneySpent"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "customerType": customerType,
        "moneySpent": moneySpent,
        "createdAt": createdAt.toIso8601String(),
      };
}
