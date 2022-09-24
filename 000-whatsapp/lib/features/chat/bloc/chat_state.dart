part of 'chat_bloc.dart';

class ChatState extends Equatable {
  /// A Map for store one-to-one chat messages
  final MessageStore _messageStore;

  const ChatState.initial(this._messageStore);

  @override
  List<Object> get props => [_messageStore];
}
