import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../chat.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    this.isFirstInSection = false,
  });

  final Message message;

  /// Whether the message is first in a section of messages by same user.
  final bool isFirstInSection;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.author == context.watch<User>()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constrains) {
          final isMobile = Theme.of(context).platform.isMobile;
          final maxWidth = constrains.maxWidth;
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? maxWidth - 50 : maxWidth * 0.75,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: maxWidth > 600 ? maxWidth * 0.1 : 0,
              ).copyWith(top: isFirstInSection ? 5 : 0),
              child: MessageBubble(
                message: message,
                showArrow: isFirstInSection,
              ),
            ),
          );
        },
      ),
    );
  }
}
