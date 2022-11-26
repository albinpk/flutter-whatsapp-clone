part of 'status_bloc.dart';

class StatusState extends Equatable {
  const StatusState({
    required this.statuses,
  });

  StatusState.initial(List<WhatsAppUser> whatsAppUsers)
      : statuses = [
          Status.fromContent(
            StatusContent.random(),
            author: whatsAppUsers.last,
            isSeen: true,
          ),
        ];

  /// List of [Status].
  final List<Status> statuses;

  /// List of recent (unseen) [Status].
  List<Status> get recent => statuses.where((s) => !s.isSeen).toList();

  /// List of viewed [Status].
  List<Status> get viewed => statuses.where((s) => s.isSeen).toList();

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
