import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../../core/models/models.dart';
import '../../../../chat.dart';

class ChatRoomMessagesView extends StatefulWidget {
  const ChatRoomMessagesView({super.key});

  @override
  State<ChatRoomMessagesView> createState() => _ChatRoomMessagesViewState();
}

class _ChatRoomMessagesViewState extends State<ChatRoomMessagesView> {
  // GlobalKey for a demo MessageBox widget
  final _demoBoxKey = GlobalKey();
  // The minimum height a MessageBox
  double? _singleMessageHeight;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _singleMessageHeight = _demoBoxKey.currentContext!.size!.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // In a ListView with reverse = true, its start in the bottom even
    // if the list contain only one item. But in WhatsApp it start from the top.
    // To start the reversed ListView from top we can use shrink wrap,
    // but if our list contains more items it will have some performance issues
    // (mentioned in shrinkWrap documentation).
    //
    // To avoid that, calculate the minimum height of a message box
    // then multiply with total messages count.
    // if that value is > the maxHeight (that means the ListView have item to scroll)
    // the set the shrinkWrap to false, otherwise true.
    // We can't use a constant value as message box height, because
    // the it is depends on the device.

    // Initially build a demo MessageBox widget with GlobalKey,
    // to calculate the height in postFrameCallback.
    // After calculate the height, it assign to _singleMessageHeight
    // variable and call setState().
    // Therefore this demo widget only build once.
    if (_singleMessageHeight == null) {
      return Opacity(
        opacity: 0, // Not showing, only for calculate height
        child: ListView(
          children: [
            MessageBox(
              key: _demoBoxKey,
              message: Message.fromText(
                'hello',
                author: context.watch<WhatsAppUser>(),
              ),
            ),
          ],
        ),
      );
    }

    final selectedUser = context.watch<WhatsAppUser>();
    // Messages with currently selected user
    final messages = context
        .select((ChatBloc bloc) => bloc.state.getMessages(selectedUser))
        .reversed
        .toList();
    final length = messages.length;

    // This Align widget make our ListView stay top if it have only few items.
    // This only work when shrinkWrap in true.
    // Otherwise the ListView take the entire space in height.
    return Align(
      alignment: Alignment.topCenter,
      // Using LayoutBuilder to get the maxHeight for ListView.
      child: LayoutBuilder(
        builder: (context, constrains) {
          final isShrinkWrap =
              _singleMessageHeight! * length > constrains.maxHeight
                  ? false
                  : true;

          return ListView.builder(
            shrinkWrap: isShrinkWrap,
            padding: const EdgeInsets.symmetric(vertical: 5),
            physics: const ClampingScrollPhysics(),
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              final Message message = messages[index];
              final bool isFirstInSection = index == length - 1
                  ? true
                  : messages[++index].author != message.author;

              // The message box
              final messageBox = MessageBox(
                message: message,
                isFirstInSection: isFirstInSection,
              );

              // Wrap the message box with VisibilityDetector if the message
              // is incoming message and its status in delivered.
              // And trigger ChatMarkMessageAsRead event when the message box is fully visible.
              if (message.author == selectedUser &&
                  message.status == MessageStatus.delivered) {
                return VisibilityDetector(
                  key: Key(message.id),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction == 1) {
                      context.read<ChatBloc>().add(
                            ChatMarkMessageAsRead(
                              user: selectedUser,
                              message: message,
                            ),
                          );
                    }
                  },
                  child: messageBox,
                );
              }

              // No VisibilityDetector if the message is already read.
              return messageBox;
            },
          );
        },
      ),
    );
  }
}
