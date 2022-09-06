import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/platform_type.dart';
import '../../../chats/bloc/chats_bloc.dart';
import '../../../chats/presentation/views/chats_view.dart';
import '../views/default_chat_view.dart';
import '../widgets/mobile_app_bar.dart';
import '../widgets/both_axis_scroll_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsBloc(),
      child: Theme.of(context).platform.isMobile
          ? const _HomeScreenMobile()
          : const _HomeScreenDesktop(),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  const _HomeScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: const MobileAppBar(),
            ),
          ],
          body: const TabBarView(
            children: [
              ChatsView(),
              Center(child: Text('STATUS')),
              Center(child: Text('CALLS')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  const _HomeScreenDesktop({Key? key}) : super(key: key);

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
                  child: const ChatsView(),
                ),
                const Expanded(
                  child: DefaultChatView(),
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
