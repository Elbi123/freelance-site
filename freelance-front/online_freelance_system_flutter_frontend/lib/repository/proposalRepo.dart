import 'package:online_freelance_system_flutter_frontend/data_provider/proposalDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/models/proposal.dart';

class ProposalRepo {
  final ProposalDataProvider proposalDataProvider;

  ProposalRepo({required this.proposalDataProvider});
  Future<Proposal> submitProposal(
      Proposal proposal, String jobTitle, String username) async {
    return await proposalDataProvider.submitProposal(
        proposal, jobTitle, username);
  }
}
