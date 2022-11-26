part of 'status_bloc.dart';

abstract class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object> get props => [];
}

class StatusAdd extends StatusEvent {
  const StatusAdd({required this.status});

  final Status status;

  @override
  List<Object> get props => [status];
}

class StatusViewed extends StatusEvent {
  const StatusViewed({required this.status});

  final Status status;

  @override
  List<Object> get props => [status];
}
