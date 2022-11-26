import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_input_event.dart';
part 'message_input_state.dart';

class MessageInputBloc extends Bloc<MessageInputEvent, MessageInputState> {
  MessageInputBloc() : super(const MessageInputState()) {
    on<MessageInputTextChange>(_onTextChange);
    on<MessageInputSendButtonPressed>(_onSendButtonPressed);
  }

  void _onTextChange(
    MessageInputTextChange event,
    Emitter<MessageInputState> emit,
  ) {
    emit(state.copyWith(text: event.text));
  }

  void _onSendButtonPressed(
    MessageInputSendButtonPressed event,
    Emitter<MessageInputState> emit,
  ) {
    emit(state.copyWith(isSendPressed: true));
  }
}
