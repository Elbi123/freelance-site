import 'package:equatable/equatable.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();
}

class JobsLoad extends JobsEvent {
  const JobsLoad();
  @override
  List<Object> get props => [];
}
