part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatMessageSend extends ChatEvent {
  const ChatMessageSend({
    required this.to,
    required this.message,
  });

  final WhatsAppUser to;
  final Message message;

  @override
  List<Object> get props => [message, to];
}
