import 'package:flutter/material.dart';

import '../../../../utils/extensions/platform_type.dart';
import '../../../../utils/themes/custom_colors.dart';

class ChatInputArea extends StatelessWidget {
  const ChatInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _ChatInputAreaMobile()
        : const _ChatInputAreaDesktop();
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
                          const Expanded(child: _ChatTextField()),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file),
                          ),
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
            AspectRatio(
              aspectRatio: 1 / 1,
              child: DecoratedBox(
                decoration: boxDecoration,
                child: ClipOval(
                  child: ColoredBox(
                    color: customColors.primary!,
                    child: Icon(
                      Icons.mic,
                      color: customColors.onPrimary,
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
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xFF2A3942),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: _ChatTextField(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatTextField extends StatelessWidget {
  const _ChatTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      style: textTheme.titleMedium!.copyWith(
        fontSize: isMobile ? 18 : null,
        fontWeight: isMobile
            ? null
            : Theme.of(context).brightness == Brightness.light
                ? null
                : FontWeight.w300,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: isMobile ? 'Message' : ' Type a message',
        border: InputBorder.none,
      ),
      cursorColor: isMobile
          ? CustomColors.of(context).primary
          : CustomColors.of(context).onBackground,
      cursorWidth: isMobile ? 2 : 1,
    );
  }
}
