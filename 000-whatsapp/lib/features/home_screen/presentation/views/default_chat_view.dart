import 'package:flutter/material.dart';

import '../../../../core/utils/themes/custom_colors.dart';

/// Initial view on desktop (in ChatRoom side).
/// Also shows when ChatRoom closed.
class DefaultChatView extends StatelessWidget {
  const DefaultChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);

    return Scaffold(
      backgroundColor: customColors.secondary,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: 300,
              child: FittedBox(
                child: Icon(
                  Icons.laptop_mac,
                  color: customColors.onBackgroundMuted,
                ),
              ),
            ),
            Text(
              'WhatsApp Web',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            Text(
              'Send and receive messages without '
              'keeping your phone online.\n'
              'Use WhatsApp on up to 4 linked devices '
              'and 1 phone at the same time.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: customColors.onBackgroundMuted,
                    height: 1.4,
                  ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock,
                  size: 16,
                  color: customColors.onBackgroundMuted,
                ),
                Text(
                  'End-to-end Encrypted',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: customColors.onBackgroundMuted,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 5,
              width: double.infinity,
              child: ColoredBox(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF25D366)
                    : customColors.primary!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
