import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../chat.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    this.showArrow = false,
  }) : super(key: key);

  final Message message;

  /// Whether to show an arrow in message bubble
  /// that pointing to message author.
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final isUserMessage = message.author == context.watch<User>();
    final customColors = CustomColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1.2),
      child: CustomPaint(
        painter: _MessageBubblePainter(
          color: isUserMessage
              ? customColors.sendMessageBubbleBackground!
              : customColors.receiveMessageBubbleBackground!,
          bubbleArrow: showArrow
              ? isUserMessage
                  ? _MessageBubbleArrow.right
                  : _MessageBubbleArrow.left
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message.content.text),
        ),
      ),
    );
  }
}

enum _MessageBubbleArrow { left, right }

class _MessageBubblePainter extends CustomPainter {
  const _MessageBubblePainter({
    this.bubbleArrow,
    required this.color,
  });

  /// Message bubble arrow side.
  ///
  /// For the first message in a section of messages by same user.
  final _MessageBubbleArrow? bubbleArrow;

  /// Background color for message bubble.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    const bubbleCurve = 15.0;
    const arrowSize = 11.0;
    const arrowCurve = 6.0;

    final paint = Paint()..color = color;
    final path = Path();

    // Top part of message bubble
    switch (bubbleArrow) {
      case _MessageBubbleArrow.left:
        path
          ..moveTo(0, arrowSize)
          ..lineTo((0 - arrowSize) + arrowCurve, arrowCurve)
          // Arrow to left
          ..conicTo(0 - arrowSize, 0, (0 - arrowSize) + arrowCurve, 0, 0.5)
          ..lineTo(w - bubbleCurve, 0)
          ..quadraticBezierTo(w, 0, w, bubbleCurve); // Top right curve
        break;
      case _MessageBubbleArrow.right:
        path
          ..moveTo(0, bubbleCurve)
          ..quadraticBezierTo(0, 0, bubbleCurve, 0) // Top left curve
          ..lineTo((w + arrowSize) - arrowCurve, 0)
          // Arrow to right
          ..conicTo(
              w + arrowSize, 0, (w + arrowSize) - arrowCurve, arrowCurve, 0.5)
          ..lineTo(w, arrowSize);
        break;
      case null:
        path
          ..moveTo(0, bubbleCurve)
          ..quadraticBezierTo(0, 0, bubbleCurve, 0) // Top left curve
          ..lineTo(w - bubbleCurve, 0)
          ..quadraticBezierTo(w, 0, w, bubbleCurve); // Top right curve
        break;
    }

    // Bottom part of message bubble
    path
      ..lineTo(w, h - bubbleCurve)
      ..quadraticBezierTo(w, h, w - bubbleCurve, h) // Bottom right curve
      ..lineTo(bubbleCurve, h)
      ..quadraticBezierTo(0, h, 0, h - bubbleCurve); // Bottom left curve

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
