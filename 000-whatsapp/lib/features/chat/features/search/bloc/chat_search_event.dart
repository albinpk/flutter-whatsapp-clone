part of 'chat_search_bloc.dart';

abstract class ChatSearchEvent extends Equatable {
  const ChatSearchEvent();

  @override
  List<Object> get props => [];
}

class ChatSearchOpen extends ChatSearchEvent {
  const ChatSearchOpen();
}

class ChatSearchClose extends ChatSearchEvent {
  const ChatSearchClose();
}
