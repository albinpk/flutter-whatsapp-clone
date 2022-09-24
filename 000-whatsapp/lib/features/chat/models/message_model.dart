import '../../../core/models/models.dart';

class Message {
  final String id;

  /// Content of the message
  final MessageContent content;

  /// Time of message
  final DateTime time;

  /// User who sent the message
  final WhatsAppUser author;

  const Message({
    required this.id,
    required this.content,
    required this.time,
    required this.author,
  });
}

class MessageContent {
  /// The actual message
  final String text;

  const MessageContent({
    required this.text,
  });
}
