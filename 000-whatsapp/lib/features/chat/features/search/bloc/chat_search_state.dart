part of 'chat_search_bloc.dart';

abstract class ChatSearchState extends Equatable {
  const ChatSearchState();

  @override
  List<Object> get props => [];
}

class ChatSearchInitial extends ChatSearchState {}

class ChatSearchOpenState extends ChatSearchState {
  const ChatSearchOpenState();
}

class ChatSearchCloseState extends ChatSearchState {
  const ChatSearchCloseState();
}
