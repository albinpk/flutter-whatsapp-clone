import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../chat.dart';

class ChatRoomMessagesView extends StatelessWidget {
  const ChatRoomMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedUser = context.select((WhatsAppUser user) => user);
    final messages = context.select(
      (ChatBloc bloc) => bloc.state.getMessages(selectedUser),
    );

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageBox(message: messages[index]);
      },
    );
  }
}
