import 'package:flutter/material.dart';

import '../widgets/chat_screen_app_bar.dart';
import '../widgets/chat_screen_input_area.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatScreenAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Messages with $id'),
            ),
          ),
          const ChatScreenInputArea(),
        ],
      ),
    );
  }
}
