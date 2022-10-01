import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../../core/models/models.dart';
import '../../../../chat.dart';

class ChatRoomMessagesView extends StatelessWidget {
  const ChatRoomMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedUser = context.watch<WhatsAppUser>();
    // Messages with currently selected user
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

        // The message box
        final messageBox = MessageBox(
          message: message,
          isFirstInSection: isFirstInSection,
        );

        // Wrap the message box with VisibilityDetector if the message
        // is incoming message and its status in delivered.
        // And trigger ChatMarkMessageAsRead event when the message box is fully visible.
        if (message.author == selectedUser &&
            message.status == MessageStatus.delivered) {
          return VisibilityDetector(
            key: Key(message.id),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 1) {
                context.read<ChatBloc>().add(
                      ChatMarkMessageAsRead(
                        user: selectedUser,
                        message: message,
                      ),
                    );
              }
            },
            child: messageBox,
          );
        }

        // No VisibilityDetector if the message is already read.
        return messageBox;
      },
    );
  }
}
