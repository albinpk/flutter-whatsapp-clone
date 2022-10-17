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
    return WillPopScope(
      onWillPop: () async {
        context.read<SettingsBloc>().add(const SettingsScreenClose());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SingleChildScrollView(
          // Using Theme to override color of icon and subtitle in ListTile.
          child: Theme(
            data: Theme.of(context).copyWith(
              // ListTile.leading icon color
              iconTheme: IconThemeData(color: customColors.iconMuted),
              textTheme: TextTheme(
                // ListTile.subtitle color
                caption: TextStyle(color: customColors.iconMuted),
              ),
            ),
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
                const Divider(),

                // Settings tiles
                const ListTile(
                  leading: Icon(Icons.key),
                  title: Text('Account'),
                  subtitle: Text('Privacy, security, change number'),
                ),
                ListTile(
                  leading: const Icon(Icons.message),
                  title: const Text('Chats'),
                  subtitle: const Text('Theme, wallpapers, chat history'),
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
                const ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                  subtitle: Text('Messages, group & call tones'),
                ),
                const ListTile(
                  leading: Icon(Icons.data_usage),
                  title: Text('Storage and data'),
                  subtitle: Text('Network usage, auto-download'),
                ),
                const ListTile(
                  leading: Icon(Icons.language),
                  title: Text('App language'),
                  subtitle: Text("English (phone's language)"),
                ),
                const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Help'),
                  subtitle: Text('Help center, contact us, privacy policy'),
                ),
                const ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Invite a friend'),
                ),

                // "from meta"
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Text(
                        'from',
                        style: TextStyle(color: customColors.iconMuted),
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
      ),
    );
  }
}

class _SettingsScreenDesktop extends StatelessWidget {
  const _SettingsScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    const divider = Divider(indent: 68);
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
        // Using Theme to override color of ListTile.leading icon.
        child: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: customColors.iconMuted),
          ),
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
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.lock),
                title: Text('Privacy'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.security),
                title: Text('Security'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.brightness_medium),
                title: Text('Theme'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.wallpaper),
                title: Text('Chat wallpaper'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Request Account Info'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.brightness_auto),
                title: Text('Keyboard shortcuts'),
              ),
              divider,
              const ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
