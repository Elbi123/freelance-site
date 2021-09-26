import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String country;
  final String city;

  Address({
    required this.country,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
      };

  @override
  // TODO: implement props
  List<Object> get props => [country, city];
}
