import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/platform_type.dart';
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
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile
                  ? constrains.maxWidth - 50
                  : constrains.maxWidth * 0.75,
            ),
            child: MessageBubble(
              message: message,
              showArrow: isFirstInSection,
            ),
          );
        },
      ),
    );
  }
}
