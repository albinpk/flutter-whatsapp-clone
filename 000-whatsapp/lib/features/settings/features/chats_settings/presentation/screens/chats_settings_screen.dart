import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../settings.dart';

class ChatsSettingsScreen extends StatelessWidget {
  const ChatsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      // Using Theme to override color of icon and subtitle in ListTile.
      body: Theme(
        data: Theme.of(context).copyWith(
          // ListTile.leading icon color
          iconTheme: IconThemeData(color: customColors.iconMuted),
          textTheme: TextTheme(
            // ListTile.subtitle color
            caption: TextStyle(color: customColors.iconMuted),
          ),
        ),
        child: ListView(
          padding: kMaterialListPadding,
          children: [
            const _ListTitleItem('Display'),
            const _ThemeTile(),
            const ListTile(
              leading: Icon(Icons.wallpaper),
              title: Text('Wallpaper'),
            ),
            const Divider(),

            //
            const _ListTitleItem('Chat settings'),
            SwitchListTile(
              value: false,
              onChanged: (_) {},
              secondary: const SizedBox.shrink(),
              title: const Text('Enter is send'),
              isThreeLine: true,
              subtitle: const Text('Enter key will send your message'),
            ),
            SwitchListTile(
              value: false,
              onChanged: (_) {},
              secondary: const SizedBox.shrink(),
              title: const Text('Media visibility'),
              isThreeLine: true,
              subtitle: const Text(
                "Show newly downloaded media in your device's gallery",
              ),
            ),
            const ListTile(
              title: Text('Font size'),
              leading: SizedBox.shrink(),
              subtitle: Text('Medium'),
            ),
            const Divider(),

            //
            const _ListTitleItem('Archived chats'),
            SwitchListTile(
              value: false,
              onChanged: (_) {},
              secondary: const SizedBox.shrink(),
              title: const Text('Keep chats archived'),
              isThreeLine: true,
              subtitle: const Text(
                'Archived chats will remain archived when you receive a new message',
              ),
            ),
            const Divider(),

            //
            const ListTile(
              title: Text('Chat backup'),
              leading: Icon(Icons.cloud_upload),
            ),
            const ListTile(
              title: Text('Chat history'),
              leading: Icon(Icons.history),
            ),
          ],
        ),
      ),
    );
  }
}

/// Title for a settings section.
class _ListTitleItem extends StatelessWidget {
  const _ListTitleItem(
    this._text, {
    Key? key,
  }) : super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(bottom: 5),
      child: Text(
        _text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
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
      leading: const Icon(Icons.brightness_medium),
      title: const Text('Theme'),
      // Update subtitle when ThemeMode change
      subtitle: Builder(
        builder: (context) {
          final themeMode = context.select(
            (ChatSettingsBloc bloc) => bloc.state.themeMode,
          );
          return Text(_getThemModeText(themeMode));
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
