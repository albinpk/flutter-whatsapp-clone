import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/platform_type.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../chat.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({Key? key}) : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final _textEditingController = TextEditingController();
  late final _chatRoomBloc = context.read<ChatRoomBloc>();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_chatTextFieldListener);
  }

  void _chatTextFieldListener() {
    _chatRoomBloc.add(
      ChatRoomTextInputValueChange(text: _textEditingController.text),
    );
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_chatTextFieldListener);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: _textEditingController,
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
