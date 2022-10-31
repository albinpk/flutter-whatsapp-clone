import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../status.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc({
    required List<WhatsAppUser> whatsAppUsers,
  }) : super(StatusState.initial(whatsAppUsers)) {
    // Add a status after 5 seconds.
    _addStatusAfterDelay(whatsAppUsers);

    on<StatusAdd>(_onAdd);
    on<StatusViewed>(_onViewed);
  }

  /// Add a status after 5 seconds.
  void _addStatusAfterDelay(List<WhatsAppUser> whatsAppUsers) {
    Future.delayed(const Duration(seconds: 5), () {
      for (int i = 0; i < 5; i++) {
        add(StatusAdd(
          status: Status.fromContent(
            StatusContent.random(),
            author: whatsAppUsers[i + 1],
          ),
        ));
      }
    });
  }

  void _onAdd(StatusAdd event, Emitter<StatusState> emit) {
    emit(state.copyWith(statuses: [event.status, ...state.statuses]));
  }

  void _onViewed(StatusViewed event, Emitter<StatusState> emit) {
    emit(
      state.copyWith(
        statuses: state.statuses
            .map((s) => s == event.status ? s.asSeen : s)
            .toList(),
      ),
    );
  }
}
