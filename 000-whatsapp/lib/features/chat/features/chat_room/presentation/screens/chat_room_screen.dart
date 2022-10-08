import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../chat.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            // Background image
            Positioned.fill(
              // Wrap with OverflowBox to prevent resizing
              // of background image when keyboard open on mobile.
              child: OverflowBox(
                maxHeight: theme.platform.isMobile
                    ? MediaQuery.of(context).size.height
                    : null,
                alignment: Alignment.topLeft,
                child: Image.asset(
                  theme.brightness == Brightness.dark
                      ? 'assets/images/chat_room_background_image_dark.png'
                      : 'assets/images/chat_room_background_image_light.jpg',
                  repeat: ImageRepeat.repeat,
                  alignment: Alignment.topLeft,
                ),
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
