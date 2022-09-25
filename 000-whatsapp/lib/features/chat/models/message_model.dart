import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/models.dart';

class Message extends Equatable {
  /// Uuid of the message
  final String id;

  /// Content of the message
  final MessageContent content;

  /// Time of the message
  final DateTime time;

  /// User who sent the message
  final WhatsAppUser author;

  const Message({
    required this.id,
    required this.content,
    required this.time,
    required this.author,
  });

  /// Create [Message] from [MessageContent.text]
  Message.fromText(
    String text, {
    required this.author,
  })  : id = const Uuid().v4(),
        content = MessageContent(text: text),
        time = DateTime.now();

  @override
  List<Object> get props => [id];
}

class MessageContent {
  /// The actual message
  final String text;

  const MessageContent({
    required this.text,
  });
}
