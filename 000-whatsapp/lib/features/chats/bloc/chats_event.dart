part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatsTilePressed extends ChatsEvent {
  const ChatsTilePressed({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class ChatsScreenCloseButtonPressed extends ChatsEvent {
  const ChatsScreenCloseButtonPressed();
}
