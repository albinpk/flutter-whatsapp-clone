import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_chat_event.dart';
part 'new_chat_state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  NewChatBloc() : super(NewChatInitial()) {
    on<NewChatSelectionScreenOpen>(_onNewChatSelectionScreenOpen);
  }

  void _onNewChatSelectionScreenOpen(
    NewChatSelectionScreenOpen event,
    Emitter<NewChatState> emit,
  ) {
    emit(const NewChatSelectionScreenOpenState());
  }
}
