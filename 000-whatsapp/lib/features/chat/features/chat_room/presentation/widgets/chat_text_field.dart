import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/platform_type.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({Key? key}) : super(key: key);

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
