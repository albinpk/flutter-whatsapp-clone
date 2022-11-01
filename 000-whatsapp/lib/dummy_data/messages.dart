import 'dart:math';

import 'package:uuid/uuid.dart';

import '../core/types.dart';
import '../features/chat/chat.dart';
import 'dummy_data.dart';

final _random = Random();

/// Messages database.
// Inner loops are just for generate random data.
final MessageStore messages = {
  // Generate chat with random users (max 10)
  for (int i = 0, msgLength = 1, chatsLength = _random.nextInt(10) + 1;
      i < chatsLength;
      i++, msgLength = _random.nextInt(5) + 1)
    whatsappUsers[i].id: [
      // Generate messages with a user max(5)                   // max 10 days
      for (int j = 0, r = _random.nextInt(2), t = _random.nextInt(60 * 24 * 10);
          j < msgLength;
          j++, r = r == 0 ? _random.nextInt(2) : 1, t = _random.nextInt(t + 1))
        Message(
          id: const Uuid().v4(),
          content: MessageContent(text: _msgs[_random.nextInt(3)]),
          time: DateTime.now().subtract(Duration(minutes: t)),
          status: r == 0 ? MessageStatus.read : MessageStatus.delivered,
          author: r == 1
              ? whatsappUsers[i]
              : _random.nextBool()
                  ? whatsappUsers[i]
                  : user,
        ),
    ],
};

const _msgs = ['Hi', 'Hello', 'How are you ?'];
