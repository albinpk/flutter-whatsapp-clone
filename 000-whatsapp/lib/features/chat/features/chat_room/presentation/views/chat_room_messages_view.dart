import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../chat.dart';

class ChatRoomMessagesView extends StatelessWidget {
  const ChatRoomMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedUser = context.select((WhatsAppUser user) => user);
    final messages = context
        .select((ChatBloc bloc) => bloc.state.getMessages(selectedUser))
        .reversed
        .toList();
    final length = messages.length;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isFirstInSection = index == length - 1
            ? true
            : messages[++index].author != message.author;
        return MessageBox(
          message: message,
          isFirstInSection: isFirstInSection,
        );
      },
    );
  }
}
