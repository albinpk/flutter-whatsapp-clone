import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../chat.dart';

class ChatInputArea extends StatelessWidget {
  const ChatInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageInputBloc(),
      child: Theme.of(context).platform.isMobile
          ? _ChatInputAreaMobile(onSendPressed: _onSendPressed)
          : _ChatInputAreaDesktop(onSendPressed: _onSendPressed),
    );
  }

  /// Handle send button press
  void _onSendPressed(BuildContext context) {
    final messageInputBloc = context.read<MessageInputBloc>();
    if (messageInputBloc.state.isEmpty) {
      // voice record
      return;
    }

    // Add new message to Bloc
    context.read<ChatBloc>().add(
          ChatMessageSend(
            to: context.read<WhatsAppUser>(),
            message: Message.fromText(
              messageInputBloc.state.text.trim(),
              author: context.read<User>(),
            ),
          ),
        );
    messageInputBloc.add(const MessageInputSendButtonPressed());
  }
}

class _ChatInputAreaMobile extends StatelessWidget {
  const _ChatInputAreaMobile({
    Key? key,
    required this.onSendPressed,
  }) : super(key: key);

  final void Function(BuildContext context) onSendPressed;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    // Decoration (shadow) for TextInput and send button
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 1,
          offset: Offset(0, 0.5),
        )
      ],
    );

    // Total number on lines in message text.
    // Change input area height when number of lines change.
    final lineCount = context.select(
      (MessageInputBloc bloc) =>
          bloc.state.lineCount.clamp(1, 6), // maximum 6 line
    );

    return SizedBox(
      height: lineCount == 1
          ? kBottomNavigationBarHeight // Default height
          // 20 => TextField fontSize + 2,
          // 6 => TextField contentPadding (3+3),
          // 10 => padding below (4+6).
          : (20 * lineCount) + 6 + 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5)
            .copyWith(top: 4, bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text input
            Expanded(
              child: DecoratedBox(
                decoration: boxDecoration, // Shadow
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(kBottomNavigationBarHeight / 2),
                  child: ColoredBox(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : customColors.secondary!,
                    child: IconTheme(
                      data: IconThemeData(
                        color: customColors.iconMuted,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Emoji button
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.emoji_emotions_rounded),
                          ),

                          // TextField
                          const Expanded(child: ChatTextField()),

                          // File attach button
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file),
                          ),

                          // Payment and camera buttons.
                          // Using BlocSelector and AnimatedAlign
                          // to hide these buttons when typing.
                          BlocSelector<MessageInputBloc, MessageInputState,
                              bool>(
                            selector: (state) => state.isEmpty,
                            builder: (context, isEmpty) {
                              return AnimatedAlign(
                                alignment: Alignment.bottomLeft,
                                widthFactor: isEmpty ? 1 : 0,
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeInOut,
                                child: Row(
                                  children: [
                                    // Payment button
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.currency_rupee),
                                    ),

                                    // Camera button
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.camera_alt),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),

            // Send/voice button
            SizedBox(
              height: kBottomNavigationBarHeight - 10, // 10 => padding 5 + 5
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: DecoratedBox(
                  decoration: boxDecoration, // Shadow
                  child: ClipOval(
                    child: GestureDetector(
                      onTap: () => onSendPressed(context),
                      child: ColoredBox(
                        color: customColors.primary!,

                        // Using BlocSelector and AnimatedSwitcher
                        // to switch icons (send/mic) when typing.
                        child: BlocSelector<MessageInputBloc, MessageInputState,
                            bool>(
                          selector: (state) => state.isEmpty,
                          builder: (context, isMessageTextEmpty) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              switchInCurve: Curves.easeInOut,
                              switchOutCurve: Curves.easeInOut,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: isMessageTextEmpty
                                  ? Icon(
                                      Icons.mic,
                                      key: const Key('mic_icon'),
                                      color: customColors.onPrimary,
                                    )
                                  : Icon(
                                      Icons.send,
                                      key: const Key('send_icon'),
                                      color: customColors.onPrimary,
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatInputAreaDesktop extends StatelessWidget {
  const _ChatInputAreaDesktop({
    Key? key,
    required this.onSendPressed,
  }) : super(key: key);

  final void Function(BuildContext context) onSendPressed;

  @override
  Widget build(BuildContext context) {
    // Total number on lines in message text.
    // Change input area height when number of lines change.
    final lineCount = context.select(
      (MessageInputBloc bloc) =>
          bloc.state.lineCount.clamp(1, 6), // maximum 6 line
    );

    return SizedBox(
      height: lineCount == 1
          ? kBottomNavigationBarHeight + 5 // 5 => extra for desktop
          // 18 => TextField fontSize + 2,
          // 16 => padding below (8+8),
          // 20 => TextField contentPadding (10+10).
          : (18 * lineCount) + 16 + 20,
      child: ColoredBox(
        color: CustomColors.of(context).secondary!,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: IconTheme(
            data: IconThemeData(
              color: CustomColors.of(context).onSecondaryMuted,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Emoji button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions_rounded),
                ),

                // File attach button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.attach_file),
                ),
                const SizedBox(width: 10),

                // Text input
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xFF2A3942),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ChatTextField(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // send/voice button
                IconButton(
                  onPressed: () => onSendPressed(context),
                  // Using BlocSelector to switch icons when typing
                  icon: BlocSelector<MessageInputBloc, MessageInputState, bool>(
                    selector: (state) => state.isEmpty,
                    builder: (context, isMessageTextEmpty) {
                      if (isMessageTextEmpty) return const Icon(Icons.mic);
                      return const Icon(Icons.send);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
