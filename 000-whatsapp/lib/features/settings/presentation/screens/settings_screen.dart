import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions/target_platform.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../settings.dart';
import '../widgets/widgets.dart';

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
              const UserProfileTile(),
              const Divider(height: 0),

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
              const UserProfileTile(),
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
              ListTile(
                leading: const CenterIcon(Icons.brightness_medium),
                title: const Text('Theme'),
                onTap: () => _onTapTheme(context),
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

  /// Show dialog to select theme.
  void _onTapTheme(BuildContext context) async {
    final chatSettingsBloc = context.read<ChatSettingsBloc>();
    final currentThemeMode = chatSettingsBloc.state.themeMode;

    final newThemeMode = await showDialog<ThemeMode>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final buttonStyle = TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: CustomColors.of(context).onBackgroundMuted!,
              width: 0.1,
            ),
          ),
        );
        // Initial groupValue for RadioListTile,
        // and it updated by StatefulBuilder below.
        ThemeMode? selectedThemeMode = currentThemeMode;
        return AlertDialog(
          title: const Text('Choose theme'),
          contentPadding: const EdgeInsets.only(top: 20),
          actionsPadding: const EdgeInsets.all(20),
          scrollable: true,
          content: SizedBox(
            width: 500,
            // Using StatefulBuilder to update RadioListTile values on tap
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                mainAxisSize: MainAxisSize.min,
                children: ThemeMode.values
                    .map((t) => RadioListTile<ThemeMode>(
                          value: t,
                          title: Text(_getThemModeText(t)),
                          groupValue: selectedThemeMode,
                          onChanged: (value) {
                            setState(() => selectedThemeMode = value);
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              style: buttonStyle.copyWith(
                foregroundColor: MaterialStatePropertyAll(
                  CustomColors.of(context).primary,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL'),
            ),
            TextButton(
              style: buttonStyle.copyWith(
                backgroundColor: MaterialStatePropertyAll(
                  CustomColors.of(context).primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop<ThemeMode>(selectedThemeMode);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // Update Bloc if theme changed
    if (newThemeMode != null && newThemeMode != currentThemeMode) {
      chatSettingsBloc.add(
        ChatSettingsThemeModeChange(themeMode: newThemeMode),
      );
    }
  }

  /// Convert [ThemeMode] to string.
  String _getThemModeText(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
