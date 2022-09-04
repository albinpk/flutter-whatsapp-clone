import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/platform_type.dart';
import '../../../app/presentation/widgets/sliver_wrap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Theme.of(context).platform.isMobile) {
      return const _MobileHomeScreen();
    }

    return _DesktopHomeScreen();
  }
}

class _MobileHomeScreen extends StatelessWidget {
  const _MobileHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverWrap();
  }
}

class _DesktopHomeScreen extends StatelessWidget {
  _DesktopHomeScreen({Key? key}) : super(key: key);

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scrollbar(
      controller: _verticalScrollController,
      thumbVisibility: true,
      child: Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: true,
        notificationPredicate: (_) => true,
        child: SingleChildScrollView(
          controller: _verticalScrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: max(screenSize.width, 850),
                maxHeight: max(screenSize.height, 600),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 400,
                    child: Scaffold(
                      appBar: AppBar(title: const Text('ChatList')),
                    ),
                  ),
                  Expanded(
                    child: Scaffold(
                      appBar: AppBar(title: const Text('ChatRoom')),
                      backgroundColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 400,
                              height: 300,
                              child: Placeholder(),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w200,
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                            ),
                            const Text(' End-to-end Encrypted'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
