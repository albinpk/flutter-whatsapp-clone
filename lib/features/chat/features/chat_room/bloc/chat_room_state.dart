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
