part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    required MessageStore messageStore,
  }) : _messageStore = messageStore;

  /// A Map for store one-to-one chat messages
  final MessageStore _messageStore;

  /// List of chats sorted by last message date
  List<RecentChat> get recentChats {
    return _messageStore.entries
        .map<RecentChat>(
          (e) => RecentChat(
            user: whatsappUsers.singleWhere((u) => u.id == e.key),
            lastMessage: e.value.last,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.lastMessage.time.compareTo(b.lastMessage.time),
      );
  }

  @override
  List<Object> get props => [_messageStore];

  ChatState copyWith({
    MessageStore? messageStore,
  }) {
    return ChatState(
      messageStore: messageStore ?? _messageStore,
    );
  }
}
