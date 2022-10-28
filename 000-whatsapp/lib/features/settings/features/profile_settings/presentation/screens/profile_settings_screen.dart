import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.bodyMedium!.copyWith(
      color: customColors.onBackgroundMuted,
    );
    const divider = Divider(indent: 70, height: 0);
    final user = context.watch<User>();

    return Scaffold(
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
    );
  }
}
