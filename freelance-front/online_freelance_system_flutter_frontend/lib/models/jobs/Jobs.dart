import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';

class Jobs extends Equatable {
  final int total;
  final List<Job> jobs;

  Jobs({
    required this.total,
    required this.jobs,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        total: json["total"],
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [total, jobs];
}
