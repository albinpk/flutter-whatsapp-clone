import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/platform_type.dart';
import '../../../app/presentation/widgets/sliver_wrap.dart';
import '../../../chats/presentation/widgets/chats_list_tile.dart';
import '../views/whatsapp_web_default_view.dart';
import '../widgets/both_axis_scroll_view.dart';
import '../widgets/desktop_chats_list_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Theme.of(context).platform.isMobile) {
      return const _MobileHomeScreen();
    }

    return const _DesktopHomeScreen();
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
  const _DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: BothAxisScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: max(min(screenSize.width, 1600), 850),
            maxHeight: max(screenSize.height, 600),
          ),
          child: LayoutBuilder(
            builder: (context, constrains) => Row(
              children: [
                SizedBox(
                  width: _calculateWidth(constrains.maxWidth),
                  child: Scaffold(
                    appBar: const DesktopChatsListAppBar(),
                    body: ListView.builder(
                      itemCount: 50,
                      itemExtent: 76,
                      itemBuilder: (context, index) => const ChatsListTile(),
                    ),
                  ),
                ),
                const Expanded(
                  child: WhatsAppWebDefaultView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateWidth(double maxWidth) {
    final double widthFactor;
    if (maxWidth > 1200) {
      widthFactor = 0.3;
    } else if (maxWidth > 1000) {
      widthFactor = 0.35;
    } else {
      widthFactor = 0.4;
    }

    return maxWidth * widthFactor;
  }
}
