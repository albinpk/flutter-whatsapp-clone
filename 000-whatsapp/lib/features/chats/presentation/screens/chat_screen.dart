import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../widgets/chat_screen_app_bar.dart';
import '../widgets/chat_screen_input_area.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatScreenAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Messages with ${context.select((User user) => user.name)}',
              ),
            ),
          ),
          const ChatScreenInputArea(),
        ],
      ),
    );
  }
}
