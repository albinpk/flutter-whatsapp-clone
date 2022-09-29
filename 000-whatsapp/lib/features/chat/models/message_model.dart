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

  /// Status of the message
  final MessageStatus status;

  const Message({
    required this.id,
    required this.content,
    required this.time,
    required this.author,
    this.status = MessageStatus.pending,
  });

  /// Create [Message] from [MessageContent.text]
  Message.fromText(
    String text, {
    required this.author,
  })  : id = const Uuid().v4(),
        content = MessageContent(text: text),
        time = DateTime.now(),
        status = MessageStatus.pending;

  @override
  List<Object> get props => [id];
}

/// Status of a [Message]
enum MessageStatus {
  /// Message not sended to server.
  pending,

  /// Message sended to server.
  sended,

  /// Message delivered to user.
  delivered,

  /// Messaged read by user.
  read;

  /// Return `true` if status is [MessageStatus.pending].
  bool get isPending => this == pending;
}

class MessageContent {
  /// The actual message
  final String text;

  const MessageContent({
    required this.text,
  });
}
