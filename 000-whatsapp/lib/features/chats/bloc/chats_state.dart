part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

abstract class ChatsNavigationState extends ChatsState {
  const ChatsNavigationState();
}

abstract class ChatsNavigationPushedState extends ChatsNavigationState {
  const ChatsNavigationPushedState();
}

abstract class ChatsNavigationPoppedState extends ChatsNavigationState {
  const ChatsNavigationPoppedState();
}

class ChatsInitial extends ChatsState {}

class ChatsRoomOpened extends ChatsNavigationPushedState {
  const ChatsRoomOpened({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class ChatsRoomClosed extends ChatsNavigationPoppedState {
  const ChatsRoomClosed();
}

class ChatsContactListOpened extends ChatsNavigationPushedState {
  const ChatsContactListOpened();
}

class ChatsContactListClosed extends ChatsNavigationPoppedState {
  const ChatsContactListClosed();
}
