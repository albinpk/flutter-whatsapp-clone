import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../profile_settings.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _ProfileSettingsScreenMobile()
        : const _ProfileSettingsScreenDesktop();
  }
}

class _ProfileSettingsScreenMobile extends StatelessWidget {
  const _ProfileSettingsScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.bodyMedium!.copyWith(
      color: customColors.onBackgroundMuted,
    );
    const divider = Divider(indent: 70, height: 0);
    final user = context.watch<User>();

    return WillPopScope(
      onWillPop: () async {
        context.read<ProfileSettingsBloc>().add(const ProfileSettingsClose());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: ListTileTheme(
          minVerticalPadding: 15,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Hero(
                  tag: 'user-profile-dp',
                  child: UserDP(radius: 80, url: user.dpUrl),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.person),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name', style: titleTextStyle),
                              const SizedBox(height: 3),
                              Text(user.name),
                            ],
                          ),
                          const Spacer(),
                          Icon(Icons.edit, color: customColors.primary)
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is not your username or pin. '
                        'This name will be visible to your WhatsApp contacts.',
                        style: textTheme.bodyMedium!.copyWith(
                          color: customColors.onBackgroundMuted,
                        ),
                      )
                    ],
                  ),
                ),
                divider,
                ListTile(
                  leading: const CenterIcon(Icons.info_outline),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: titleTextStyle,
                      ),
                      const SizedBox(height: 3),
                      Text(user.about),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: customColors.primary),
                ),
                divider,
                ListTile(
                  leading: const CenterIcon(Icons.call),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone',
                        style: textTheme.bodyMedium!.copyWith(
                          color: customColors.onBackgroundMuted,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(user.phNumber),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSettingsScreenDesktop extends StatefulWidget {
  const _ProfileSettingsScreenDesktop({Key? key}) : super(key: key);

  @override
  State<_ProfileSettingsScreenDesktop> createState() =>
      _ProfileSettingsScreenDesktopState();
}

class _ProfileSettingsScreenDesktopState
    extends State<_ProfileSettingsScreenDesktop>
    with SingleTickerProviderStateMixin {
  // To animate the user DP (in initState)
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  late final _dpAnimation = Tween<double>(
    begin: 0,
    end: 160,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.bodyMedium!.copyWith(
      color: customColors.primary,
    );
    final user = context.watch<User>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: BackButton(
          onPressed: () {
            context
                .read<ProfileSettingsBloc>()
                .add(const ProfileSettingsClose());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User DP
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _dpAnimation,
              builder: (context, dp) {
                return SizedBox.square(
                  dimension: _dpAnimation.value,
                  child: dp,
                );
              },
              child: UserDP(url: user.dpUrl),
            ),
            const SizedBox(height: 20),

            // Name and about
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // User name
                  Text('Your name', style: titleTextStyle),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(user.name),
                      const Spacer(),
                      Icon(Icons.edit, color: customColors.iconMuted),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'This is not your username or pin. '
                    'This name will be visible to your WhatsApp contacts.',
                    style: textTheme.bodyMedium!.copyWith(
                      color: customColors.onBackgroundMuted,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // About
                  Text('About', style: titleTextStyle),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(user.about),
                      const Spacer(),
                      Icon(Icons.edit, color: customColors.iconMuted),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
