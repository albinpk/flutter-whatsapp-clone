import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/whats_app_user_model.dart';
import '../../../../core/utils/extensions/platform_type.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../chat/chat.dart';
import '../../home_screen.dart';

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
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatRoomBloc, ChatRoomState>(
          listener: _chatRoomBlocListener,
        ),
        BlocListener<NewChatBloc, NewChatState>(
          listener: _newChatBlocListener,
        ),
      ],
      child: BlocProvider(
        create: (context) => TabViewBloc(),
        child: const Scaffold(
          body: _NestedScrollView(),
          floatingActionButton: FAB(),
        ),
      ),
    );
  }

  void _chatRoomBlocListener(BuildContext context, ChatRoomState state) {
    if (state is ChatRoomOpenState) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RepositoryProvider.value(
            value: state.user,
            child: const ChatRoomScreen(),
          ),
        ),
      );
    }
  }

  void _newChatBlocListener(BuildContext context, NewChatState state) {
    if (state is NewChatSelectionScreenOpenState) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const NewChatSelectionScreen(),
        ),
      );
    }
  }
}

class _NestedScrollView extends StatefulWidget {
  const _NestedScrollView({Key? key}) : super(key: key);

  @override
  State<_NestedScrollView> createState() => _NestedScrollViewState();
}

class _NestedScrollViewState extends State<_NestedScrollView>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabAnimation.addListener(_tabAnimationListenerForFAB);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<ChatSearchBloc>().state;
    if (state is ChatSearchOpenState) {
      // If search button pressed while TabBarView changing,
      // then wait to finish animation and add listener.
      if (_swipeValue != 0) {
        _tabAnimation.addListener(_tempListener);
      } else {
        _tabAnimation.addListener(_tabAnimationListener);
      }
    } else if (state is ChatSearchCloseState) {
      _tabAnimation.removeListener(_tempListener);
      _tabAnimation.removeListener(_tabAnimationListener);
    }
  }

  /// TabBarView swipe value. From `-1.0` to `1.0`.
  double get _swipeValue {
    return _tabAnimation.value - _tabController.index;
  }

  Animation<double> get _tabAnimation => _tabController.animation!;

  /// Add real listener when animation stops
  void _tempListener() {
    if (_swipeValue == 0) {
      // TODO: recheck index
      _tabAnimation.removeListener(_tempListener);
      _tabAnimation.addListener(_tabAnimationListener);
    }
  }

  /// Trigger search bar close event, when TabBarView swiped more than 10%
  void _tabAnimationListener() {
    if (_swipeValue.abs() > 0.1) {
      context.read<ChatSearchBloc>().add(const ChatSearchClose());
      _tabAnimation.removeListener(_tabAnimationListener);
    }
  }

  late final TabViewBloc _tabViewBloc = context.read<TabViewBloc>();

  void _tabAnimationListenerForFAB() {
    final TabView tab = _tabViewBloc.state.tabView;
    if (_tabAnimation.value < 0.5) {
      if (tab != TabView.chats) {
        _tabViewBloc.add(const TabViewChange(tabView: TabView.chats));
      }
    } else if (_tabAnimation.value < 1.5) {
      if (tab != TabView.status) {
        _tabViewBloc.add(const TabViewChange(tabView: TabView.status));
      }
    } else {
      if (tab != TabView.calls) {
        _tabViewBloc.add(const TabViewChange(tabView: TabView.calls));
      }
    }
  }

  @override
  void dispose() {
    _tabAnimation.removeListener(_tabAnimationListenerForFAB);
    _tabAnimation.removeListener(_tempListener);
    _tabAnimation.removeListener(_tabAnimationListener);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select((ChatSearchBloc bloc) => bloc.state is ChatSearchOpenState);

    return NestedScrollView(
      headerSliverBuilder: (context, _) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: AppBarMobile(tabController: _tabController),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: const [
          RecentChatsView(),
          Center(child: Text('STATUS')),
          Center(child: Text('CALLS')),
        ],
      ),
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  const _HomeScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const padding = 20.0;
    final mainView = Center(
      child: BothAxisScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: max(min(screenSize.width, 1600), 750),
            maxHeight: max(screenSize.height, 510),
          ),
          child: Padding(
            padding: screenSize.width > 1440
                ? const EdgeInsets.all(padding).copyWith(
                    bottom: screenSize.height > 510 ? padding : 0,
                  )
                : EdgeInsets.zero,
            child: LayoutBuilder(
              builder: (context, constrains) => Row(
                children: [
                  SizedBox(
                    width: _calculateWidth(constrains.maxWidth),
                    child: BlocBuilder<NewChatBloc, NewChatState>(
                      builder: (context, state) {
                        if (state is NewChatSelectionScreenOpenState) {
                          return const NewChatSelectionScreen();
                        }
                        return const RecentChatsView();
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
                      // buildWhen: (previous, current) {
                      //   return (current is ChatsRoomOpened ||
                      //           current is ChatsRoomClosed) &&
                      //       current != previous;
                      // },
                      builder: (context, state) {
                        if (state is ChatRoomOpenState) {
                          final user =
                              context.read<List<WhatsAppUser>>().singleWhere(
                                    (user) => user == state.user,
                                  );
                          return RepositoryProvider.value(
                            value: user,
                            child: const ChatRoomScreen(),
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
                height: min(screenSize.height, kToolbarHeight * 2 + padding),
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
