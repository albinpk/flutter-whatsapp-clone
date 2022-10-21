import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../status.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc({
    required List<WhatsAppUser> whatsAppUsers,
  }) : super(const StatusState.initial()) {
    // Add a status after 5 seconds.
    _addStatusAfterDelay(whatsAppUsers);

    on<StatusAdd>(_onAdd);
  }

  /// Add a status after 5 seconds.
  void _addStatusAfterDelay(List<WhatsAppUser> whatsAppUsers) {
    Future.delayed(const Duration(seconds: 5), () {
      add(StatusAdd(
        status: Status.fromContent(
          const StatusContent.random(),
          author: whatsAppUsers.first,
        ),
      ));
    });
  }

  void _onAdd(StatusAdd event, Emitter<StatusState> emit) {
    emit(state.copyWith(statuses: [event.status, ...state.statuses]));
  }
}
