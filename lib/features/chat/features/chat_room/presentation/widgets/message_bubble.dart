import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../../../../../core/constants.dart';
import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final customColors = CustomColors.of(context);
    final isMobile = theme.platform.isMobile;
    final messageTextStyle = textTheme.bodyMedium!.copyWith(
      fontSize: isMobile ? 16 : null,
    );
    final isUserMessage = message.author == context.watch<User>();
    final timeTextStyle = textTheme.bodySmall!.copyWith(
      fontSize: isMobile ? null : 10,
      color: isUserMessage && theme.brightness == Brightness.dark
          ? const Color(0xFF99BEB7)
          : customColors.onBackgroundMuted,
    );

    final messageText = message.content.text;
    final timeText = DateFormat(DateFormat.HOUR_MINUTE).format(message.time);
    // Read message check mark icon

    // Adding extra white spaces at the end of text to
    // wrap the line before overlapping the time text.
    // And the unicode character at the end is for prevent text trimming.

    // Calculate timeText width
    // eg: width of "1:11" and "12:44" is different or
    // width of "4:44" and "1:11" is different in non-monospace fonts
    final timeTextWidth = textWidth(timeText, timeTextStyle) +
        (isUserMessage ? cMessageStatusIconSize : 0);
    final messageTextWidth = textWidth(messageText, messageTextStyle);
    final whiteSpaceWidth = textWidth(' ', messageTextStyle);
    // More space on desktop (+8)
    final extraSpaceCount =
        ((timeTextWidth / whiteSpaceWidth).round()) + (isMobile ? 2 : 8);
    final extraSpace = '${' ' * extraSpaceCount}\u202f';
    final extraSpaceWidth = textWidth(extraSpace, messageTextStyle);

    // Padding outside message bubble
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
        child: LayoutBuilder(
          builder: (context, constrains) {
            const padding = 8.0; // Padding for the message text
            final maxWidth = constrains.maxWidth - (padding * 2);

            // Deciding the placement of time text.

            //                                      maxWidth
            //                                         |
            // Short message                           v
            // |---------------|
            // | MESSAGE  time |
            // |---------------|

            // text + extraSpace < maxWidth
            // |---------------------------------------|
            // | MESSAGE.MESSAGE.MESSAGE.MESSAGE  time |
            // |---------------------------------------|

            // text < maxWidth
            // |---------------------------------------|
            // | MESSAGE.MESSAGE.MSGS..MESSAGE.MESSAGE |
            // |                                  time |
            // |---------------------------------------|

            // text > maxWidth
            // |---------------------------------------|
            // | MESSAGE.MESSAGE.MSGS..MESSAGE.MESSAGE |
            // | MESSAGE.MESSAGE.MESSAGE          time |
            // |---------------------------------------|
            final isTimeInSameLine =
                messageTextWidth + extraSpaceWidth < maxWidth ||
                    messageTextWidth > maxWidth;

            // Using Stack to show message time in bottom right corner.
            return Stack(
              children: [
                // Message text
                Padding(
                  padding: const EdgeInsets.all(padding).copyWith(
                    bottom: isTimeInSameLine ? padding : 25,
                  ),
                  child: Text(
                    '$messageText'
                    '${isTimeInSameLine ? extraSpace : ''}',
                    style: messageTextStyle,
                  ),
                ),

                // Message time
                Positioned(
                  bottom: 5,
                  right: 7,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        timeText,
                        style: timeTextStyle,
                      ),
                      // Message status icon
                      if (isUserMessage)
                        MessageStatusIcon(
                          status: message.status,
                          color: timeTextStyle.color!,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Returns the width of given `text` using TextPainter
  double textWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}

enum _MessageBubbleArrow { left, right }

/// CustomPainter for draw message bubble
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
    // Message bubble coordinates, for more readability
    const left = 0.0;
    const top = 0.0;
    final right = size.width;
    final bottom = size.height;

    // Message bubble border radius
    const borderRadius = 15.0;
    // Width of bubble arrow
    const arrowSize = 11.0;
    // Bubble arrow border radius
    const arrowBorderRadius = 6.0;

    final paint = Paint()..color = color;
    final path = Path();

    // Top part of message bubble
    switch (bubbleArrow) {
      case _MessageBubbleArrow.left:
        path
          ..moveTo(left, arrowSize)
          ..lineTo((left - arrowSize) + arrowBorderRadius, arrowBorderRadius)
          // Arrow to left
          ..conicTo(
            left - arrowSize,
            top,
            (left - arrowSize) + arrowBorderRadius,
            top,
            0.5,
          )
          ..lineTo(right - borderRadius, top)
          // Top right curve
          ..quadraticBezierTo(right, top, right, borderRadius);
        break;

      case _MessageBubbleArrow.right:
        path
          ..moveTo(left, borderRadius)
          // Top left curve
          ..quadraticBezierTo(left, top, borderRadius, top)
          ..lineTo((right + arrowSize) - arrowBorderRadius, top)
          // Arrow to right
          ..conicTo(
            right + arrowSize,
            top,
            (right + arrowSize) - arrowBorderRadius,
            arrowBorderRadius,
            0.5,
          )
          ..lineTo(right, arrowSize);
        break;

      case null:
        path
          ..moveTo(left, borderRadius)
          // Top left curve
          ..quadraticBezierTo(left, top, borderRadius, top)
          ..lineTo(right - borderRadius, top)
          // Top right curve
          ..quadraticBezierTo(right, top, right, borderRadius);
        break;
    }

    // Bottom part of message bubble
    path
      ..lineTo(right, bottom - borderRadius)
      // Bottom right curve
      ..quadraticBezierTo(right, bottom, right - borderRadius, bottom)
      ..lineTo(borderRadius, bottom)
      // Bottom left curve
      ..quadraticBezierTo(left, bottom, left, bottom - borderRadius);

    // Drawing shadow for message bubble
    canvas.drawShadow(
      path.shift(const Offset(0, -0.5)),
      Colors.black,
      1,
      false, // false, because message bubble is not transparent
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
