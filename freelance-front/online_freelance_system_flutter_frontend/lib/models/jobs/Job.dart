import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Address.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Customer.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Skill.dart';

class Job extends Equatable {
  Job({
    required this.address,
    required this.type,
    required this.status,
    required this.skills,
    required this.experiences,
    required this.languages,
    required this.title,
    required this.description,
    required this.budget,
    required this.customer,
    required this.createdAt,
    required this.slug,
  });

  final Address address;
  final String type;
  final String status;
  final List<Skill> skills;
  final List<dynamic> experiences;
  final List<dynamic> languages;
  final String title;
  final String description;
  final int budget;
  final Customer customer;
  final DateTime createdAt;
  final String slug;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        address: Address.fromJson(json["address"]),
        type: json["type"],
        status: json["status"],
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        experiences: List<dynamic>.from(json["experiences"].map((x) => x)),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        budget: json["budget"],
        customer: Customer.fromJson(json["customer"]),
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "type": type,
        "status": status,
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
        "experiences": List<dynamic>.from(experiences.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "title": title,
        "description": description,
        "budget": budget,
        "customer": customer.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
      };

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
