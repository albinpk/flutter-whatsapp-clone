part of 'new_chat_bloc.dart';

abstract class NewChatState extends Equatable {
  const NewChatState();

  @override
  List<Object> get props => [];
}

class NewChatInitial extends NewChatState {}

class NewChatSelectionScreenOpenState extends NewChatState {
  const NewChatSelectionScreenOpenState();
}

class NewChatSelectionScreenCloseState extends NewChatState {
  const NewChatSelectionScreenCloseState();
}
