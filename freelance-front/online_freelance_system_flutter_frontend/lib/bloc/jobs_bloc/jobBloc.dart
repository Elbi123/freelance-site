import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobState.dart';
import 'package:online_freelance_system_flutter_frontend/repository/jobsRepo.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final JobsRepo jobsRepo;

  JobsBloc({required this.jobsRepo}) : super(JobsLoading());

  @override
  Stream<JobsState> mapEventToState(JobsEvent event) async* {
    if (event is JobsLoad) {
      yield JobsLoading();
      try {
        final jobs = await jobsRepo.getJobs();
        yield JobsLoadSuccess(jobs);
      } catch (_) {
        yield JobsOperationFailed();
      }
    }
  }
}
