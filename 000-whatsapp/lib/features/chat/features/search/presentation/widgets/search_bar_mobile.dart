import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../search.dart';

class SearchBarMobile extends StatefulWidget {
  const SearchBarMobile({Key? key}) : super(key: key);

  @override
  State<SearchBarMobile> createState() => _SearchBarMobileState();
}

class _SearchBarMobileState extends State<SearchBarMobile>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  /// Animation for bottom widget height in AppBar
  late final Animation<double> _bottomAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    // Calculating the height of bottom widget
    SchedulerBinding.instance.addPostFrameCallback(_calculateHeight);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Calculate bottom widget height using GlobalKey,
  /// then start the animation.
  void _calculateHeight([_]) {
    setState(() {
      _bottomHeight = _bottomKey.currentContext!.size!.height;
      _controller.forward();
    });
  }

  // To start animation without jumping,
  // set initial height for bottom widget (chips) as same as
  // height of AppBar.bottom (tabs) in home screen,
  // 46.0 => _kTabHeight (default),
  // 3.0 => indicatorWeight (AppBarMobile).

  /// Initial height of bottom widget (chips).
  static const _initialBottomHeight = 46.0 + 3.0;

  /// Bottom widget key.
  /// To calculate height in postFrameCallback.
  final _bottomKey = GlobalKey();

  /// Height of bottom widget.
  // This will update after postFrameCallback.
  double _bottomHeight = _initialBottomHeight;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final customColors = CustomColors.of(context);
    final heightFactorBegin = _initialBottomHeight / _bottomHeight;

    return WillPopScope(
      onWillPop: () async {
        context.read<ChatSearchBloc>().add(const ChatSearchClose());
        return false;
      },
      child: AnimatedBuilder(
        animation: _bottomAnimation,
        builder: (context, child) {
          return SliverAppBar(
            pinned: true,
            elevation: 2,
            shadowColor: Colors.black45,
            forceElevated: true,
            backgroundColor:
                isLight ? customColors.background : customColors.secondary,
            foregroundColor: customColors.onBackgroundMuted!,
            leading: const BackButton(),
            title: const SearchTextField(),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                Tween<double>(
                  begin: _initialBottomHeight,
                  end: _bottomHeight,
                ).evaluate(_bottomAnimation),
              ),
              child: Opacity(
                opacity: _bottomAnimation.value,
                // ClipRect and Align widget used to slide
                // bottom widget content from top (behind appBar)
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: Tween<double>(
                      begin: heightFactorBegin,
                      end: 1,
                    ).evaluate(_bottomAnimation),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },

        // Hide bottom widget content until height calculated.
        child: Offstage(
          offstage: heightFactorBegin == 1,
          child: ChipTheme(
            key: _bottomKey, // To calculate height
            data: Theme.of(context).chipTheme.copyWith(
                  // Set color and fontWeight of chip text
                  labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: isLight
                            ? const Color(0xFF54656F)
                            : customColors.onSecondary,
                      ),
                ),

            // Align chips to left
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 10,
                  children: const [
                    Chip(
                      avatar: Icon(Icons.mark_unread_chat_alt),
                      label: Text('Unread'),
                    ),
                    Chip(
                      avatar: Icon(Icons.photo),
                      label: Text('Photo'),
                    ),
                    Chip(
                      avatar: Icon(Icons.videocam),
                      label: Text('Video'),
                    ),
                    Chip(
                      avatar: Icon(Icons.link),
                      label: Text('Links'),
                    ),
                    Chip(
                      avatar: Icon(Icons.gif),
                      label: Text('GIFs'),
                    ),
                    Chip(
                      avatar: Icon(Icons.headphones),
                      label: Text('Audio'),
                    ),
                    Chip(
                      avatar: Icon(Icons.text_snippet),
                      label: Text('Documents'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
