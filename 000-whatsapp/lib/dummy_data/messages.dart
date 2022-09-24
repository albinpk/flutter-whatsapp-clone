import 'dart:math';

import 'package:uuid/uuid.dart';

import '../core/types.dart';
import '../features/chat/chat.dart';
import 'dummy_data.dart';

final _friend = whatsappUsers[Random().nextInt(whatsappUsers.length)];
final _friendId = _friend.id;

final MessageStore messages = {
  _friendId: [
    Message(
      id: const Uuid().v4(),
      content: const MessageContent(text: 'Hello'),
      time: DateTime.now(),
      author: _friend,
    ),
  ],
};
