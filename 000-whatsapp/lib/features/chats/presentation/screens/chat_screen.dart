import 'package:flutter/material.dart';

import '../widgets/chat_screen_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatScreenAppBar(),
      body: Center(
        child: Text('ChatRoom'),
      ),
    );
  }
}
