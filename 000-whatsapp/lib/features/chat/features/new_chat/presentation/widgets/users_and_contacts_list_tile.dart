import 'package:flutter/material.dart';
import 'package:whatsapp/utils/themes/custom_colors.dart';

import '../../../../../../models/models.dart';

class UsersAndContactsListTile extends StatelessWidget {
  const UsersAndContactsListTile({
    super.key,
    required this.user,
  });

  final WhatsAppUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        user.about,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
      ),
      onTap: () {},
    );
  }
}
