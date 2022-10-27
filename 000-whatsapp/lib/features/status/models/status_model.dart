import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/models.dart';

final _random = Random();

/// WhatsApp status model.
class Status extends Equatable {
  /// Status id.
  final String id;

  /// Status content.
  final StatusContent content;

  /// Author of this status.
  final WhatsAppUser author;

  /// Status time.
  final DateTime time;

  /// Whether the status is seen by user.
  final bool isSeen;

  /// Create a WhatsApp status.
  const Status({
    required this.id,
    required this.content,
    required this.author,
    required this.time,
    this.isSeen = false,
  });

  /// Create status from [StatusContent].
  Status.fromContent(this.content, {required this.author, this.isSeen = false})
      : id = const Uuid().v4(),
        time = DateTime.now();

  /// Return same status with `isSeen: true`.
  Status get asSeen => Status(
        isSeen: true,
        id: id,
        content: content,
        author: author,
        time: time,
      );

  @override
  List<Object> get props => [id, content, author, time, isSeen];
}

/// Content of WhatsApp status.
class StatusContent extends Equatable {
  /// Image url, if status contains an image.
  final String? imgUrl;

  /// Status text.
  ///
  /// if [imgUrl] is non-null, then this text
  /// is used as caption for status image.
  /// Otherwise this text is the main status content.
  final String? text;

  /// Create status content.
  ///
  /// [imgUrl] or [text] must not be null.
  const StatusContent({
    this.imgUrl,
    this.text,
  }) : assert(imgUrl != null || text != null);

  /// Create status with random image.
  StatusContent.random()
      : imgUrl = 'https://picsum.photos'
            '/${_random.nextInt(500) + 1000}'
            '/${_random.nextInt(2000) + 1000}',
        text = null;

  @override
  List<Object?> get props => [imgUrl, text];
}
