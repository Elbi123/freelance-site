import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/proposal.dart';

class ProposalState extends Equatable {
  final bool isSubmitted;
  final bool isSubmitting;
  final bool isSubmitFailed;
  final Proposal? proposal;
  final String? jobTitle;
  final String? userName;
  ProposalState(
      {this.isSubmitted = false,
      this.isSubmitting = false,
      this.isSubmitFailed = false,
      this.proposal,
      this.jobTitle,
      this.userName});

  factory ProposalState.submitting() {
    return ProposalState(isSubmitted: false, isSubmitting: true);
  }
  factory ProposalState.submitted() {
    return ProposalState(isSubmitted: true, isSubmitting: false);
  }
  factory ProposalState.submitFailed() {
    return ProposalState(isSubmitted: false, isSubmitFailed: true);
  }

  @override
  List<Object> get props => [];
}
