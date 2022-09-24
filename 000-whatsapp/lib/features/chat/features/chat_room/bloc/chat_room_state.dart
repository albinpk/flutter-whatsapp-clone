part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomOpenState extends ChatRoomState {
  const ChatRoomOpenState({required this.user});

  final WhatsAppUser user;

  @override
  List<Object> get props => [user];
}

class ChatRoomCloseState extends ChatRoomState {
  const ChatRoomCloseState();
}

class ChatRoomTextInputValueChangeState extends ChatRoomState {
  const ChatRoomTextInputValueChangeState({required this.text});

  final String text;

  /// Returns `text.trim().isEmpty`
  bool get isEmpty => text.trim().isEmpty;

  @override
  List<Object> get props => [text];
}
