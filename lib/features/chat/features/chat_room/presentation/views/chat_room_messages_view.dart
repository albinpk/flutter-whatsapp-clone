import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/date_time.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
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

  final _scrollController = ScrollController();

  // Whether to show the goto bottom button.
  final _gotoBottomButtonNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _singleMessageHeight = _demoBoxKey.currentContext!.size!.height;
      });
    });
    _scrollController.addListener(_scrollListener);
  }

  // Show goto bottom button if scroll offset > message box height.
  void _scrollListener() {
    // + 5 is ListView vertical padding
    if (_scrollController.offset > _singleMessageHeight! + 5) {
      _gotoBottomButtonNotifier.value = true;
    } else {
      _gotoBottomButtonNotifier.value = false;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _gotoBottomButtonNotifier.dispose();
    super.dispose();
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
    // it is depends on the device.

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
    } // Demo message box widget end

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
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          // Using LayoutBuilder to get the maxHeight for ListView.
          child: LayoutBuilder(
            builder: (context, constrains) {
              final isShrinkWrap =
                  _singleMessageHeight! * length > constrains.maxHeight
                      ? false
                      : true;

              return ListView.builder(
                controller: _scrollController,
                shrinkWrap: isShrinkWrap,
                padding: const EdgeInsets.symmetric(vertical: 5),
                physics: const ClampingScrollPhysics(),
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isFirstInSection = index == length - 1
                      ? true
                      : message.author != messages[index + 1].author;
                  final isFirstInDate = index == length - 1
                      ? true
                      : !message.time.isSameDate(messages[index + 1].time);

                  // Wrap the message box with VisibilityDetector and enable
                  // it (by passing callback function to onVisibilityChanged)
                  // if the message is incoming message and its status in delivered.
                  // And trigger ChatMarkMessageAsRead event when
                  // the message box is fully visible.

                  final detectVisibilityChange =
                      (message.author == selectedUser &&
                          message.status == MessageStatus.delivered);

                  return VisibilityDetector(
                    key: Key(message.id),
                    onVisibilityChanged: detectVisibilityChange
                        ? (info) {
                            if (info.visibleFraction == 1) {
                              context.read<ChatBloc>().add(
                                    ChatMarkMessageAsRead(
                                      user: selectedUser,
                                      message: message,
                                    ),
                                  );
                            }
                          }
                        : null,
                    child: Column(
                      children: [
                        // Message date
                        if (isFirstInDate) _DateTimeItem(date: message.time),
                        MessageBox(
                          message: message,
                          isFirstInSection: isFirstInSection || isFirstInDate,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Goto bottom button. Placed in bottom right corner.
        // show/hide button using AnimatedSwitcher.
        ValueListenableBuilder<bool>(
          valueListenable: _gotoBottomButtonNotifier,
          builder: (context, showButton, button) {
            return Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: Theme.of(context).platform.isMobile
                    ? const EdgeInsets.only(right: 10, bottom: 3)
                    : const EdgeInsets.all(15),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: showButton ? button! : null,
                ),
              ),
            );
          },
          child: _GotoBottomButton(
            onTap: () => _scrollController.jumpTo(0),
          ),
        ),
      ],
    );
  }
}

class _GotoBottomButton extends StatelessWidget {
  const _GotoBottomButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final isMobile = Theme.of(context).platform.isMobile;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0, 0.5),
          ),
        ],
      ),
      child: ClipOval(
        child: GestureDetector(
          onTap: onTap,
          child: ColoredBox(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : customColors.secondary!,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                isMobile
                    ? Icons.keyboard_double_arrow_down
                    : Icons.keyboard_arrow_down,
                size: isMobile ? 22 : 30,
                color: customColors.iconMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DateTimeItem extends StatelessWidget {
  const _DateTimeItem({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ColoredBox(
          color: customColors.receiveMessageBubbleBackground!.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Text(
              _formatDate(date),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: customColors.onBackgroundMuted,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  /// Format DateTime to readable text.
  /// eg: `Today`, `Friday`, `June 1, 2022`.
  String _formatDate(DateTime date) {
    // Subtracting hours from date.
    // Otherwise this method return "Today" even if the
    // time is before "12:00 AM" (depends on DateTime.now).
    date = date.subtract(Duration(hours: date.hour));
    final difference = DateTime.now().difference(date).inDays;
    if (difference < 1) return 'Today';
    if (difference < 2) return 'Yesterday';
    if (difference < 7) return DateFormat(DateFormat.WEEKDAY).format(date);
    return DateFormat(DateFormat.YEAR_MONTH_DAY).format(date);
  }
}
