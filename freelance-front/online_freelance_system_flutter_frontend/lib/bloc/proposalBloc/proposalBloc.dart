import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/proposalBloc/proposalEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/proposalBloc/proposalState.dart';
import 'package:online_freelance_system_flutter_frontend/repository/proposalRepo.dart';

class ProposalBloc extends Bloc<ProposalEvent, ProposalState> {
  final ProposalRepo proposalRepo;

  ProposalBloc({required this.proposalRepo})
      : super(ProposalState.submitFailed());

  @override
  Stream<ProposalState> mapEventToState(ProposalEvent event) async* {
    if (event is ProposalSubmit) {
      yield ProposalState.submitting();
      try {
        print("Creating Proposal");
        await proposalRepo.submitProposal(
            event.proposal, event.jobTitle, event.username);
        print("Proposal Created ...........");
        yield ProposalState.submitted();
        print(event.proposal);
      } catch (e) {
        ProposalState.submitFailed();
        print("Reg Error ፡" + e.toString());
      }
    }
  }
}
