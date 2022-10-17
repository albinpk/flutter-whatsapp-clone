import 'package:flutter/material.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';

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
            const ListTile(
              leading: Icon(Icons.brightness_medium),
              title: Text('Theme'),
              subtitle: Text('System default'),
            ),
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
