part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object> get props => [];
}

class ChatRoomOpen extends ChatRoomEvent {
  const ChatRoomOpen({required this.user});

  final WhatsAppUser user;

  @override
  List<Object> get props => [user];
}

class ChatRoomClose extends ChatRoomEvent {
  const ChatRoomClose();
}

class ChatRoomTextInputValueChange extends ChatRoomEvent {
  const ChatRoomTextInputValueChange({required this.text});

  final String text;

  @override
  List<Object> get props => [text];
}
