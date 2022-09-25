import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/platform_type.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../chat.dart';

class ChatInputArea extends StatelessWidget {
  const ChatInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageInputBloc(),
      child: Theme.of(context).platform.isMobile
          ? const _ChatInputAreaMobile()
          : const _ChatInputAreaDesktop(),
    );
  }
}

class _ChatInputAreaMobile extends StatelessWidget {
  const _ChatInputAreaMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
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

    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Padding(
        padding: const EdgeInsets.all(5).copyWith(top: 4, bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: boxDecoration,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ColoredBox(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : customColors.secondary!,
                    child: IconTheme(
                      data: IconThemeData(
                        color: customColors.iconMuted,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.emoji_emotions_rounded),
                          ),
                          const Expanded(child: ChatTextField()),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file),
                          ),
                          // TODO: hide on input
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.currency_rupee),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),

            // Send/voice button
            AspectRatio(
              aspectRatio: 1 / 1,
              child: DecoratedBox(
                decoration: boxDecoration,
                child: ClipOval(
                  child: ColoredBox(
                    color: customColors.primary!,
                    child:
                        BlocSelector<MessageInputBloc, MessageInputState, bool>(
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
          ],
        ),
      ),
    );
  }
}

class _ChatInputAreaDesktop extends StatelessWidget {
  const _ChatInputAreaDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + 5,
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.attach_file),
                ),
                const SizedBox(width: 10),

                // input box
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
                  onPressed: () {
                    final messageInputBloc = context.read<MessageInputBloc>();
                    if (messageInputBloc.state.isEmpty) {
                      // voice record
                      return;
                    }
                    context.read<ChatBloc>().add(
                          ChatMessageSend(
                            to: context.read<WhatsAppUser>(),
                            message: Message.fromText(
                              messageInputBloc.state.text,
                              author: context.read<User>(),
                            ),
                          ),
                        );
                  },
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
