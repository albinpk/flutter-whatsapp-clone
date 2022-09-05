import 'package:flutter/material.dart';

import '../../../../utils/themes/custom_colors.dart';

class ChatScreenInputArea extends StatelessWidget {
  const ChatScreenInputArea({super.key});

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

class _InputField extends StatelessWidget {
  const _InputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        hintText: 'Message',
        border: InputBorder.none,
      ),
      cursorColor: CustomColors.of(context).chatsListTileBadge,
    );
  }
}
