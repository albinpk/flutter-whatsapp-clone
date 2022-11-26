part of 'message_input_bloc.dart';

abstract class MessageInputEvent extends Equatable {
  const MessageInputEvent();

  @override
  List<Object> get props => [];
}

class MessageInputTextChange extends MessageInputEvent {
  const MessageInputTextChange({required this.text});

  final String text;

  @override
  List<Object> get props => [text];
}

class MessageInputSendButtonPressed extends MessageInputEvent {
  const MessageInputSendButtonPressed();
}
