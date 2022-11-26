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
            unReadMessageCount: e.value.where((m) {
              return m.author != user && m.status == MessageStatus.delivered;
            }).length,
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.lastMessage.time.compareTo(a.lastMessage.time),
      );
  }

  /// Return list of messages with given `user`
  List<Message> getMessages(WhatsAppUser user) {
    return _messageStore[user.id] ?? [];
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
