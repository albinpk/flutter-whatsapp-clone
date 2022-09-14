part of 'new_chat_bloc.dart';

abstract class NewChatEvent extends Equatable {
  const NewChatEvent();

  @override
  List<Object> get props => [];
}

class NewChatSelectionScreenOpen extends NewChatEvent {
  const NewChatSelectionScreenOpen();
}

class NewChatSelectionScreenClose extends NewChatEvent {
  const NewChatSelectionScreenClose();
}
