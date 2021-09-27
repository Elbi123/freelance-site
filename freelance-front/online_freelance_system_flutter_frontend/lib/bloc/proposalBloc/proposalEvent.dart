import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/proposal.dart';

abstract class ProposalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProposalSubmit extends ProposalEvent {
  final Proposal proposal;
  final String jobTitle;
  final String username;
  ProposalSubmit(this.proposal, this.jobTitle, this.username);
  @override
  List<Object> get props => [proposal, username, jobTitle];
}
