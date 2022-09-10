part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsRoomOpened extends ChatsState {
  const ChatsRoomOpened({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class ChatsRoomClosed extends ChatsState {
  const ChatsRoomClosed();
}

class ChatsContactListOpened extends ChatsState {
  const ChatsContactListOpened();
}

class ChatsContactListClosed extends ChatsState {
  const ChatsContactListClosed();
}
