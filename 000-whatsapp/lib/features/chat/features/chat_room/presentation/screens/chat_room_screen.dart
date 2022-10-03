import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
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
        backgroundColor: CustomColors.of(context).chatRoomBackground,
        appBar: const ChatRoomAppBar(),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/chat_room_background_image_dark.png'
                    : 'assets/chat_room_background_image_light.jpg',
                repeat: ImageRepeat.repeat,
              ),
            ),
            Column(
              children: const [
                Expanded(
                  child: ChatRoomMessagesView(),
                ),
                ChatInputArea(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
