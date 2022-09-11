import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/extensions/platform_type.dart';
import '../../../../utils/themes/custom_colors.dart';
import '../../../chats/bloc/chats_bloc.dart';
import '../../../chats/presentation/screens/chat_screen.dart';
import '../../../chats/presentation/screens/new_chat_selection_screen.dart';
import '../../../chats/presentation/views/chats_view.dart';
import '../views/default_chat_view.dart';
import '../widgets/mobile_app_bar.dart';
import '../widgets/both_axis_scroll_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _HomeScreenMobile()
        : const _HomeScreenDesktop();
  }
}

class _HomeScreenMobile extends StatelessWidget {
  const _HomeScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatsBloc, ChatsState>(
      listenWhen: (previous, current) {
        return current is ChatsNavigationState && current != previous;
      },
      listener: (context, state) {
        if (state is ChatsNavigationPoppedState) {
          Navigator.of(context).pop();
        } else if (state is ChatsRoomOpened) {
          final user = context.read<List<User>>().singleWhere(
                (user) => user == state.user,
              );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RepositoryProvider.value(
                value: user,
                child: const ChatScreen(),
              ),
            ),
          );
        } else if (state is ChatsContactListOpened) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NewChatSelectionScreen(),
          ));
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
            onPressed: () {
              context.read<ChatsBloc>().add(const ChatsNewChatButtonPressed());
            },
          ),
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
    final mainView = Center(
      child: BothAxisScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: max(min(screenSize.width, 1600), 750),
            maxHeight: max(screenSize.height, 510),
          ),
          child: Padding(
            padding: screenSize.width > 1440
                ? const EdgeInsets.all(20).copyWith(
                    bottom: screenSize.height > 510 ? 20 : 0,
                  )
                : EdgeInsets.zero,
            child: LayoutBuilder(
              builder: (context, constrains) => Row(
                children: [
                  SizedBox(
                    width: _calculateWidth(constrains.maxWidth),
                    child: BlocBuilder<ChatsBloc, ChatsState>(
                      buildWhen: (previous, current) {
                        return current is ChatsContactListOpened ||
                            current is ChatsContactListClosed;
                      },
                      builder: (context, state) {
                        if (state is ChatsContactListOpened) {
                          return const NewChatSelectionScreen();
                        }
                        return const ChatsView();
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<ChatsBloc, ChatsState>(
                      buildWhen: (previous, current) {
                        return (current is ChatsRoomOpened ||
                                current is ChatsRoomClosed) &&
                            current != previous;
                      },
                      builder: (context, state) {
                        if (state is ChatsRoomOpened) {
                          final user = context.read<List<User>>().singleWhere(
                                (user) => user == state.user,
                              );
                          return RepositoryProvider.value(
                            value: user,
                            child: const ChatScreen(),
                          );
                        }
                        return const DefaultChatView();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (Theme.of(context).brightness == Brightness.light &&
        screenSize.width > 1440) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: kToolbarHeight * 2 + 20,
                child: ColoredBox(
                  color: CustomColors.of(context).primary!,
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          mainView,
        ],
      );
    } else {
      return ColoredBox(
        color: CustomColors.of(context).background!,
        child: mainView,
      );
    }
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
