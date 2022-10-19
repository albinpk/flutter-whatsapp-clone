import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../settings.dart';

class ChatsSettingsScreen extends StatelessWidget {
  const ChatsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final subtitleStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
          color: customColors.onBackgroundMuted,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView(
        padding: kMaterialListPadding,
        children: [
          const ListSectionTitle('Display'),
          const _ThemeTile(),
          const ListTile(
            leading: CenterIcon(Icons.wallpaper),
            title: Text('Wallpaper'),
          ),
          const Divider(),

          //
          const ListSectionTitle('Chat settings'),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            secondary: const SizedBox.shrink(),
            title: const Text('Enter is send'),
            isThreeLine: true,
            subtitle: Text(
              'Enter key will send your message',
              style: subtitleStyle,
            ),
          ),
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            secondary: const SizedBox.shrink(),
            title: const Text('Media visibility'),
            isThreeLine: true,
            subtitle: Text(
              "Show newly downloaded media in your device's gallery",
              style: subtitleStyle,
            ),
          ),
          ListTile(
            title: const Text('Font size'),
            leading: const SizedBox.shrink(),
            subtitle: Text('Medium', style: subtitleStyle),
          ),
          const Divider(),

          //
          const ListSectionTitle('Archived chats'),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            secondary: const SizedBox.shrink(),
            title: const Text('Keep chats archived'),
            isThreeLine: true,
            subtitle: Text(
              'Archived chats will remain archived when you receive a new message',
              style: subtitleStyle,
            ),
          ),
          const Divider(),

          //
          const ListTile(
            title: Text('Chat backup'),
            leading: CenterIcon(Icons.cloud_upload),
          ),
          const ListTile(
            title: Text('Chat history'),
            leading: CenterIcon(Icons.history),
          ),
        ],
      ),
    );
  }
}

/// Settings tile for change theme
class _ThemeTile extends StatelessWidget {
  const _ThemeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CenterIcon(Icons.brightness_medium),
      title: const Text('Theme'),
      // Update subtitle when ThemeMode change
      subtitle: Builder(
        builder: (context) {
          final themeMode = context.select(
            (ChatSettingsBloc bloc) => bloc.state.themeMode,
          );
          return Text(
            _getThemModeText(themeMode),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: CustomColors.of(context).onBackgroundMuted,
                ),
          );
        },
      ),
      onTap: () => _onTap(context),
    );
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

  // When theme tile pressed, show dialog to choose a new theme.
  void _onTap(BuildContext context) async {
    final chatSettingsBloc = context.read<ChatSettingsBloc>();
    final currentThemeMode = chatSettingsBloc.state.themeMode;

    final newThemeMode = await showDialog<ThemeMode>(
      context: context,
      builder: (context) {
        final buttonStyle = TextButton.styleFrom(
          foregroundColor: CustomColors.of(context).primary,
        );
        // Initial groupValue for RadioListTile,
        // and it updated by StatefulBuilder below.
        ThemeMode? selectedThemeMode = currentThemeMode;
        return AlertDialog(
          title: const Text('Choose theme'),
          contentPadding: const EdgeInsets.only(top: 20),
          scrollable: true,
          // Using StatefulBuilder to update RadioListTile values on tap
          content: StatefulBuilder(
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
          actions: [
            TextButton(
              style: buttonStyle,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL'),
            ),
            TextButton(
              style: buttonStyle,
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
}
