import 'package:equatable/equatable.dart';

class Proposal extends Equatable {
  final String paymentForJob;
  final String finishingTime;
  final String coverletter;

  Proposal(
      {required this.paymentForJob,
      required this.finishingTime,
      required this.coverletter});
  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
        paymentForJob: json['paymentForJob'],
        finishingTime: json['finishingTime'],
        coverletter: json['coverLetter']);
  }
  @override
  List<Object> get props => [paymentForJob, finishingTime, coverletter];
}
