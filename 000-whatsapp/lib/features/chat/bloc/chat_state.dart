part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatRoomOpenState extends ChatState {
  const ChatRoomOpenState({required this.user});

  final WhatsAppUser user;

  @override
  List<Object> get props => [user];
}

class ChatRoomCloseState extends ChatState {
  const ChatRoomCloseState();
}
