import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  Skill({
    required this.name,
  });

  final String name;
  @override
  List<Object> get props => [name];
  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
