import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/whats_app_user_model.dart';
import '../../../../chat.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatRoomBloc>().add(const ChatRoomClose());
        return true;
      },
      child: Scaffold(
        appBar: const ChatRoomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Messages with ${context.select((WhatsAppUser user) => user.name)}',
                ),
              ),
            ),
            const ChatInputArea(),
          ],
        ),
      ),
    );
  }
}
