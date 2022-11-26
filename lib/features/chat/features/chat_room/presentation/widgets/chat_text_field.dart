import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../chat.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({Key? key}) : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final _textEditingController = TextEditingController();
  late final _messageInputBloc = context.read<MessageInputBloc>();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_chatTextFieldListener);
  }

  void _chatTextFieldListener() {
    _messageInputBloc.add(
      MessageInputTextChange(text: _textEditingController.text),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_messageInputBloc.state.isSendPressed) {
      _textEditingController.clear();
    }
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

    // To clear TextField after send button
    // pressed (in didChangeDependencies)
    context.select((MessageInputBloc bloc) => bloc.state.isSendPressed);

    // Whether the message text is single line or not.
    // Decrease contentPadding of TextField if text is not single line.
    final isSingleLine = context.select(
      (MessageInputBloc bloc) => bloc.state.lineCount == 1,
    );

    return TextField(
      controller: _textEditingController,
      maxLines: 6,
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
        contentPadding: isSingleLine
            ? null // Default padding
            : isMobile
                ? const EdgeInsets.symmetric(vertical: 3)
                : const EdgeInsets.symmetric(vertical: 10),
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
