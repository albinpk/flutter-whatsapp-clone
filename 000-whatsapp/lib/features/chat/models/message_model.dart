import 'package:equatable/equatable.dart';

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
