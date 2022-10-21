import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc({
    required List<WhatsAppUser> whatsAppUsers,
  }) : super(StatusInitial()) {
    on<StatusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
