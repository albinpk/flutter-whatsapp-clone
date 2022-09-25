import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../chat.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Align(
      alignment:
          message.author == user ? Alignment.centerRight : Alignment.centerLeft,
      child: MessageBubble(message: message),
    );
  }
}
