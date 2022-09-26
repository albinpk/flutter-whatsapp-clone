import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
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
      child: MessageBubble(
        message: message,
        showArrow: isFirstInSection,
      ),
    );
  }
}
