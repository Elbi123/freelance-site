import 'package:equatable/equatable.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Jobs.dart';

class JobsState extends Equatable {
  const JobsState();
  @override
  List<Object> get props => [];
}

class JobsLoading extends JobsState {}

class JobsLoadSuccess extends JobsState {
  final List<Job> job;

  JobsLoadSuccess([this.job = const []]);
  @override
  List<Object> get props => [job];
}

class JobsOperationFailed extends JobsState {}
