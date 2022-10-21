part of 'status_bloc.dart';

class StatusState extends Equatable {
  const StatusState({
    required this.statuses,
  });

  const StatusState.initial() : this(statuses: const []);

  /// List of [Status].
  final List<Status> statuses;

  @override
  List<Object> get props => [statuses];

  StatusState copyWith({
    List<Status>? statuses,
  }) {
    return StatusState(
      statuses: statuses ?? this.statuses,
    );
  }
}
