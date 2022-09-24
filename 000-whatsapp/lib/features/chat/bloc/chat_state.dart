part of 'chat_bloc.dart';

class ChatState extends Equatable {
  /// A Map for store one-to-one chat messages
  final MessageStore _messageStore;

  const ChatState.initial(this._messageStore);

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
}
