import 'package:flutter/material.dart';

import '../widgets/chat_screen_app_bar.dart';
import '../widgets/chat_screen_input_area.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatScreenAppBar(),
      body: Column(
        children: const [
          Expanded(
            child: Center(
              child: Text('Messages'),
            ),
          ),
          ChatScreenInputArea(),
        ],
      ),
    );
  }
}
