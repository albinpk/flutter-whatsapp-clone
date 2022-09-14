import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_chat_event.dart';
part 'new_chat_state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  NewChatBloc() : super(NewChatInitial()) {
    on<NewChatSelectionScreenOpen>(_onNewChatSelectionScreenOpen);
    on<NewChatSelectionScreenClose>(_onNewChatSelectionScreenClose);
  }

  void _onNewChatSelectionScreenOpen(
    NewChatSelectionScreenOpen event,
    Emitter<NewChatState> emit,
  ) {
    emit(const NewChatSelectionScreenOpenState());
  }

  void _onNewChatSelectionScreenClose(
    NewChatSelectionScreenClose event,
    Emitter<NewChatState> emit,
  ) {
    emit(const NewChatSelectionScreenCloseState());
  }
}
