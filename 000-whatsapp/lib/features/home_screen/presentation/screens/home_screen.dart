import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions/target_platform.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../chat/chat.dart';
import '../../../settings/settings.dart';
import '../../../status/status.dart';
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
        BlocListener<UserProfileBloc, UserProfileState>(
          listener: _userProfileBlocListener,
        ),
        BlocListener<SettingsBloc, SettingsState>(
          listener: _settingsBlocListener,
        ),
        BlocListener<ProfileSettingsBloc, ProfileSettingsState>(
          listener: _profileSettingsBlocListener,
        )
      ],
      child: BlocProvider(
        create: (context) => TabViewBloc(),
        child: const Scaffold(
          body: _MobileNestedScrollView(),
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

  void _userProfileBlocListener(BuildContext context, UserProfileState state) {
    if (state is UserProfileOpenState) {
      Navigator.of(context).push(
        FadePageRoute(
          builder: (_) => RepositoryProvider.value(
            value: state.user,
            child: const UserProfileScreen(),
          ),
        ),
      );
    }
  }

  void _settingsBlocListener(BuildContext context, SettingsState state) {
    if (state is SettingsScreenOpenState) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ),
      );
    }
  }

  void _profileSettingsBlocListener(
    BuildContext context,
    ProfileSettingsState state,
  ) {
    if (state is ProfileSettingsOpenState) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProfileSettingsScreen(),
        ),
      );
    }
  }
}

/// Nested ScrollView on mobile.
/// Contains SliverAppBar and TabBarView.
class _MobileNestedScrollView extends StatefulWidget {
  const _MobileNestedScrollView({Key? key}) : super(key: key);

  @override
  State<_MobileNestedScrollView> createState() =>
      _MobileNestedScrollViewState();
}

class _MobileNestedScrollViewState extends State<_MobileNestedScrollView>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  late final TabViewBloc _tabViewBloc = context.read<TabViewBloc>();
  late final ChatSearchBloc _chatSearchBloc = context.read<ChatSearchBloc>();

  @override
  void initState() {
    super.initState();
    _tabAnimation.addListener(_tabAnimationListenerForFAB);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = _chatSearchBloc.state;
    if (state is ChatSearchOpenState) {
      // If search button pressed while TabBarView changing,
      // then wait to finish animation and add listener.
      if (_swipeValue != 0) {
        _tabAnimation.addListener(_addListenerWhenAnimationEnd);
      } else {
        _tabAnimation.addListener(_tabAnimationListener);
      }
    } else if (state is ChatSearchCloseState) {
      _tabAnimation.removeListener(_addListenerWhenAnimationEnd);
      _tabAnimation.removeListener(_tabAnimationListener);
    }
  }

  /// TabBarView swipe value. From `-1.0` to `1.0`.
  double get _swipeValue {
    return _tabAnimation.value - _tabController.index;
  }

  Animation<double> get _tabAnimation => _tabController.animation!;

  /// Add real listener when animation stops
  void _addListenerWhenAnimationEnd() {
    if (_swipeValue == 0) {
      _tabAnimation.removeListener(_addListenerWhenAnimationEnd);
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
    _tabAnimation.removeListener(_addListenerWhenAnimationEnd);
    _tabAnimation.removeListener(_tabAnimationListener);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select((ChatSearchBloc bloc) => bloc.state is ChatSearchOpenState);

    return WillPopScope(
      onWillPop: () async {
        if (_tabAnimation.value != 0) {
          _tabController.animateTo(0);
          _tabController.indexIsChanging;
          return false;
        }
        return true;
      },
      child: NestedScrollView(
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
            StatusListView(),
            Center(child: Text('CALLS')),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenDesktop extends StatefulWidget {
  const _HomeScreenDesktop({Key? key}) : super(key: key);

  @override
  State<_HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<_HomeScreenDesktop> {
  /// GlobalKey for Navigator on left side of the screen.
  ///
  /// For recent chats, new chat, settings, etc.
  final _leftNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const padding = 20.0;
    final mainView = MultiBlocListener(
      listeners: [
        BlocListener<NewChatBloc, NewChatState>(
          listener: _newChatBlocListener,
        ),
        BlocListener<SettingsBloc, SettingsState>(
          listener: _settingsBlocListener,
        ),
        BlocListener<ProfileSettingsBloc, ProfileSettingsState>(
          listener: _profileSettingsBlocListener,
        ),
        BlocListener<StatusListViewCubit, StatusListViewState>(
          listener: _statusListViewCubitListener,
        ),
      ],
      child: Center(
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
                    // Left side of screen

                    // for recent chats, new chat, settings
                    SizedBox(
                      width: _calculateWidth(constrains.maxWidth),
                      // Using Navigator widget to handle navigation on left side
                      child: Navigator(
                        key: _leftNavigatorKey,
                        initialRoute: 'recentChats',
                        onGenerateRoute: _onGenerateRouteLeft,
                      ),
                    ),

                    // Right side of screen
                    // for chat room and user profile
                    const Expanded(
                      flex: 3,
                      child: _DesktopRightSideView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Add background for main content on large
    // screen if Brightness is light.
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

  /// Calculate width for recent chats view on desktop based on constrains
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

  /// Generate Routes for left side.
  Route<dynamic>? _onGenerateRouteLeft(RouteSettings settings) {
    switch (settings.name) {
      case 'recentChats':
        return SlidePageRoute(
          builder: (context) => const RecentChatsView(),
        );

      case 'settings':
        return SlidePageRoute(
          builder: (context) => const SettingsScreen(),
        );

      case 'profile':
        return SlidePageRoute(
          builder: (context) => const ProfileSettingsScreen(),
        );

      case 'newChat':
        return SlidePageRoute(
          builder: (context) => const NewChatSelectionScreen(),
        );

      default:
        return null;
    }
  }

  /// Listener for [NewChatBloc] to handle navigation.
  void _newChatBlocListener(BuildContext context, NewChatState state) {
    if (state is NewChatSelectionScreenOpenState) {
      _leftNavigatorKey.currentState!.pushNamed('newChat');
    } else if (state is NewChatSelectionScreenCloseState) {
      _leftNavigatorKey.currentState!.pop();
    }
  }

  /// Listener for [SettingsBloc] to handle navigation.
  void _settingsBlocListener(BuildContext context, SettingsState state) {
    if (state is SettingsScreenOpenState) {
      _leftNavigatorKey.currentState!.pushNamed('settings');
    } else if (state is SettingsScreenCloseState) {
      _leftNavigatorKey.currentState!.pop();
    }
  }

  /// Listener for [ProfileSettingsBloc] to handle navigation.
  void _profileSettingsBlocListener(
    BuildContext context,
    ProfileSettingsState state,
  ) {
    if (state is ProfileSettingsOpenState) {
      _leftNavigatorKey.currentState!.pushNamed('profile');
    } else if (state is ProfileSettingsCloseState) {
      _leftNavigatorKey.currentState!.pop();
    }
  }

  void _statusListViewCubitListener(
    BuildContext context,
    StatusListViewState state,
  ) {
    if (state is StatusListViewOpenState) {
      Navigator.of(context).push(
        FadePageRoute(
          builder: (context) => const StatusListView(),
        ),
      );
    } else if (state is StatusListViewCloseState) {
      Navigator.of(context).pop();
    }
  }
}

class _DesktopRightSideView extends StatefulWidget {
  const _DesktopRightSideView({Key? key}) : super(key: key);

  @override
  State<_DesktopRightSideView> createState() => _DesktopRightSideViewState();
}

class _DesktopRightSideViewState extends State<_DesktopRightSideView> {
  final _slideAnimationController = SlideAnimationController();

  /// Whether the UserProfileScreen visible or not.
  bool _showProfile = false;

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserProfileBloc, UserProfileState>(
          listener: _userProfileBlocListener,
        ),
        BlocListener<ChatRoomBloc, ChatRoomState>(
          listener: _chatRoomBlocListener,
        ),
      ],
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, state) {
          if (state is ChatRoomOpenState) {
            final width = MediaQuery.of(context).size.width;
            return RepositoryProvider.value(
              value: state.user,

              // Using only Stack widget with FractionallySizedBox to show
              // ChatRoom and UserProfile, instead of using Row and Stack together
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ChatRoom
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _showProfile && width > 1000 ? 0.55 : 1,
                    child: const ChatRoomScreen(),
                  ),

                  // UserProfile
                  FractionallySizedBox(
                    alignment: Alignment.centerRight,
                    widthFactor: _showProfile
                        ? width > 1000
                            ? 0.45
                            : 1
                        : 0,
                    child: !_showProfile
                        ? null
                        // Using SlideAnimation because the initial route in
                        // Navigator widget would not animate.
                        : SlideAnimation(
                            controller: _slideAnimationController,
                            // Profile navigation goes here (eg: Starred
                            // messages, Disappearing messages, Encryption, etc.)
                            child: Navigator(
                              onGenerateRoute: (settings) {
                                return NoAnimationPageRoute(
                                  builder: (context) {
                                    return const UserProfileScreen();
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            );
          }

          // Default view on desktop
          return const DefaultChatView();
        },
      ),
    );
  }

  /// Listener for [UserProfileBloc].
  void _userProfileBlocListener(BuildContext context, UserProfileState state) {
    if (state is UserProfileOpenState) {
      if (_showProfile) {
        // UserProfile is not disposed.
        // The open event added before the hide animation finished.
        // Therefore call show() method to forward the animation.
        _slideAnimationController.show();
      } else {
        // UserProfile is disposed.
        setState(() => _showProfile = true);
      }
    } else if (state is UserProfileCloseState) {
      // If screen width > 1000, then dispose the UserProfile.
      // Otherwise run hide animation then dispose UserProfile.
      if (MediaQuery.of(context).size.width > 1000) {
        setState(() => _showProfile = false);
      } else {
        _slideAnimationController.hide()?.then((value) {
          setState(() => _showProfile = false);
        });
      }
    }
  }

  /// Listener for [ChatRoomBloc].
  void _chatRoomBlocListener(BuildContext context, ChatRoomState state) {
    if (state is ChatRoomOpenState) {
      final profileBloc = context.read<UserProfileBloc>();
      if (profileBloc.state is UserProfileOpenState) {
        // Closing UserProfile (if open) when another ChatRoom open.
        setState(() => _showProfile = false); // Closing without animation.
        profileBloc.add(const UserProfileClose());
      }
    }
  }
}
