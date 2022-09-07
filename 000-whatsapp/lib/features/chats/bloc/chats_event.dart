part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatsTilePressed extends ChatsEvent {
  const ChatsTilePressed({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class ChatsScreenCloseButtonPressed extends ChatsEvent {
  const ChatsScreenCloseButtonPressed();
}
