part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsRoomOpened extends ChatsState {
  const ChatsRoomOpened({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class ChatsRoomClosed extends ChatsState {
  const ChatsRoomClosed();
}
