import 'package:flutter/material.dart';

import '../../../../utils/themes/custom_colors.dart';

class DefaultChatView extends StatelessWidget {
  const DefaultChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222E35),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const SizedBox(
              width: 300,
              child: FittedBox(
                child: Icon(
                  Icons.laptop_mac,
                  color: Color(0xFFDFF3ED),
                ),
              ),
            ),
            const SizedBox(height: 30),
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
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                    height: 1.4,
                  ),
            ),
            const Spacer(),
            Text(
              ' End-to-end Encrypted',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.withOpacity(0.5),
                  ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 5,
              width: double.infinity,
              child: ColoredBox(
                color: CustomColors.of(context).chatsListTileBadge!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
