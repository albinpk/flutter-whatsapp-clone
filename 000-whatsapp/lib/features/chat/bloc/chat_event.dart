part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatRoomOpen extends ChatEvent {
  const ChatRoomOpen({required this.user});

  final WhatsAppUser user;

  @override
  List<Object> get props => [user];
}

class ChatRoomClose extends ChatEvent {
  const ChatRoomClose();
}
