import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobState.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc(JobState initialState) : super(initialState);

  @override
  Stream<JobState> mapEventToState(JobEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
