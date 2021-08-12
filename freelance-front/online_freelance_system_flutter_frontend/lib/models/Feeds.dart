import 'package:equatable/equatable.dart';

class Feeds extends Equatable {
  final String title,
      description,
      jobType,
      proposals,
      location,
      professionality,
      numOfFreelanceNeeded;

  Feeds(
      {required this.title,
      required this.description,
      required this.jobType,
      required this.proposals,
      required this.location,
      required this.professionality,
      required this.numOfFreelanceNeeded});

  @override
  List<Object> get props => [
        title,
        description,
        jobType,
        proposals,
        location,
        professionality,
        numOfFreelanceNeeded
      ];
  factory Feeds.fromJson(Map<String, dynamic> json) {
    return Feeds(
        // id: json['id'],
        title: json['title'],
        description: json['description'],
        jobType: json['jobType'],
        proposals: json['proposals'],
        location: json['location'],
        professionality: json['professionality'],
        numOfFreelanceNeeded: json['numOfFreelanceNeeded']);
  }
  @override
  String toString() => "Feeds id  $title $jobType";
}
