import 'package:equatable/equatable.dart';

/// WhatsApp status model.
class Status extends Equatable {
  /// Status id.
  final String id;

  /// Status content.
  final StatusContent content;

  /// Status time.
  final DateTime time;

  /// Create a WhatsApp status.
  const Status({
    required this.id,
    required this.content,
    required this.time,
  });

  @override
  List<Object> get props => [id, content, time];
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

  @override
  List<Object?> get props => [imgUrl, text];
}
