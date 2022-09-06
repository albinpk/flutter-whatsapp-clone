import 'package:flutter/material.dart';

import '../../../../utils/extensions/platform_type.dart';
import '../../../../utils/themes/custom_colors.dart';

class ChatScreenInputArea extends StatelessWidget {
  const ChatScreenInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _MobileInputArea()
        : const _DesktopInputArea();
  }
}

class _MobileInputArea extends StatelessWidget {
  const _MobileInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: IconTheme(
                    data: IconThemeData(
                      color: CustomColors.of(context).chatsListTileIcon,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions_rounded),
                        ),
                        const Expanded(child: _InputField()),
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
            const SizedBox(width: 4),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipOval(
                child: ColoredBox(
                  color: CustomColors.of(context).chatsListTileBadge!,
                  child: const Icon(Icons.mic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopInputArea extends StatelessWidget {
  const _DesktopInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + 5,
      child: ColoredBox(
        color: const Color(0xFF202C33),
        child: Padding(
          padding: const EdgeInsets.all(8),
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
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const ColoredBox(
                    color: Color(0xFF2A3942),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: _InputField(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      style: textTheme.titleMedium!.copyWith(
        fontSize: isMobile ? 18 : null,
        fontWeight: isMobile ? null : FontWeight.w300,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: isMobile ? 'Message' : ' Type a message',
        border: InputBorder.none,
      ),
      cursorColor:
          isMobile ? CustomColors.of(context).chatsListTileBadge : Colors.white,
    );
  }
}
