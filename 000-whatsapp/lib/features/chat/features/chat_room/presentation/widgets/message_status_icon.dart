import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
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
    const padding = 2.0;
    // Size difference between done icon and access_time icon.
    const iconSizeDifference = 4.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: status.isPending
            ? padding + 2 // 2 -> iconSizeDifference / 2
            : padding,
      ),
      child: Icon(
        _getStatusIcon(status),
        size: status.isPending
            ? cMessageStatusIconSize - iconSizeDifference
            : cMessageStatusIconSize,
        color: status == MessageStatus.read
            ? CustomColors.of(context).readMessageCheckIcon
            : color,
      ),
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
