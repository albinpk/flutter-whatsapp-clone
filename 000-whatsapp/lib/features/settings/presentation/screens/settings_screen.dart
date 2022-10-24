import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/models.dart';
import '../../../../core/utils/extensions/target_platform.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _SettingsScreenMobile()
        : const _SettingsScreenDesktop();
  }
}

class _SettingsScreenMobile extends StatelessWidget {
  const _SettingsScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final subtitleStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
          color: customColors.onBackgroundMuted,
        );

    return WillPopScope(
      onWillPop: () async {
        context.read<SettingsBloc>().add(const SettingsScreenClose());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // User tile
              Builder(
                builder: (context) => ListTile(
                  leading: const UserDP(radius: 30),
                  title: Text(context.select((User user) => user.name)),
                  subtitle: Text(
                    context.select((User user) => user.about),
                    style: subtitleStyle,
                  ),
                  trailing: Icon(Icons.qr_code, color: customColors.primary),
                ),
              ),
              const Divider(),

              // Settings tiles
              ListTile(
                leading: const CenterIcon(Icons.key),
                title: const Text('Account'),
                subtitle: Text(
                  'Privacy, security, change number',
                  style: subtitleStyle,
                ),
              ),
              ListTile(
                leading: const CenterIcon(Icons.message),
                title: const Text('Chats'),
                subtitle: Text(
                  'Theme, wallpapers, chat history',
                  style: subtitleStyle,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const ChatsSettingsScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: const CenterIcon(Icons.notifications),
                title: const Text('Notifications'),
                subtitle: Text(
                  'Messages, group & call tones',
                  style: subtitleStyle,
                ),
              ),
              ListTile(
                leading: const CenterIcon(Icons.data_usage),
                title: const Text('Storage and data'),
                subtitle: Text(
                  'Network usage, auto-download',
                  style: subtitleStyle,
                ),
              ),
              ListTile(
                leading: const CenterIcon(Icons.language),
                title: const Text('App language'),
                subtitle: Text(
                  "English (phone's language)",
                  style: subtitleStyle,
                ),
              ),
              ListTile(
                leading: const CenterIcon(Icons.help_outline),
                title: const Text('Help'),
                subtitle: Text(
                  'Help center, contact us, privacy policy',
                  style: subtitleStyle,
                ),
              ),
              const ListTile(
                leading: CenterIcon(Icons.group),
                title: Text('Invite a friend'),
              ),

              // "from meta"
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Text(
                      'from',
                      style: TextStyle(color: customColors.onBackgroundMuted),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.all_inclusive,
                          size: 20,
                          color: customColors.onBackground,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Meta',
                          style: TextStyle(
                            color: customColors.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsScreenDesktop extends StatelessWidget {
  const _SettingsScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    const divider = Divider(indent: 68, height: 0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: BackButton(
          onPressed: () {
            context.read<SettingsBloc>().add(const SettingsScreenClose());
          },
        ),
      ),
      body: SingleChildScrollView(
        // Using ListTileTheme to override minVerticalPadding
        child: ListTileTheme(
          minVerticalPadding: 20,
          child: Column(
            children: [
              // User tile
              Builder(
                builder: (context) => ListTile(
                  leading: const UserDP(radius: 30),
                  title: Text(context.select((User user) => user.name)),
                  subtitle: Text(context.select((User user) => user.about)),
                  trailing: Icon(Icons.qr_code, color: customColors.primary),
                ),
              ),
              const SizedBox(height: 5),

              // Settings tiles
              const ListTile(
                leading: CenterIcon(Icons.notifications),
                title: Text('Notifications'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.lock),
                title: Text('Privacy'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.security),
                title: Text('Security'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.brightness_medium),
                title: Text('Theme'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.wallpaper),
                title: Text('Chat wallpaper'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.insert_drive_file),
                title: Text('Request Account Info'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.brightness_auto),
                title: Text('Keyboard shortcuts'),
              ),
              divider,
              const ListTile(
                leading: CenterIcon(Icons.help),
                title: Text('Help'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
