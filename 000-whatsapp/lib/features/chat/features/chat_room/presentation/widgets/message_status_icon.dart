import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants.dart';

import '../../../../chat.dart';

/// Show icon based on [Message.status]
class MessageStatusIcon extends StatelessWidget {
  const MessageStatusIcon({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  final MessageStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getStatusIcon(status),
      size: status.isPending
          ? cMessageStatusIconSize - cMessageIconSizeDifference
          : cMessageStatusIconSize,
      color: status == MessageStatus.read ? Colors.blue : color,
    );
  }

  /// Return appropriate icon for message status
  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.pending:
        return Icons.access_time;
      case MessageStatus.sended:
        return Icons.done;
      case MessageStatus.delivered:
      case MessageStatus.read:
        return Icons.done_all;
    }
  }
}
