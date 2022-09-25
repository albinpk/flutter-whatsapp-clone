import 'package:flutter/material.dart';

import '../../../../chat.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Text(message.content.text);
  }
}
