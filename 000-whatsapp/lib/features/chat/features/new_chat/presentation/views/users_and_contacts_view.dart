import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/whats_app_user_model.dart';
import '../../../../../../utils/themes/custom_colors.dart';
import '../widgets/widgets.dart';

class UsersAndContactsView extends StatelessWidget {
  const UsersAndContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final users = context.select((List<WhatsAppUser> users) => users);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 6),
      itemCount: users.length + 2, // +2 for top and bottom button groups
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == 0) return const _TopButtonGroup();
    final users = context.read<List<WhatsAppUser>>();
    if (index == users.length + 1) return const _BottomButtonGroup();
    return UsersAndContactsListTile(user: users[index - 1]);
  }
}

class _TopButtonGroup extends StatelessWidget {
  const _TopButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ButtonListTile(
          iconData: Icons.group,
          title: 'New group',
        ),
        ButtonListTile(
          title: 'New contact',
          iconData: Icons.person_add,
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code),
            color: CustomColors.of(context).iconMuted,
          ),
        ),
        const _ItemCategoryTitle(),
      ],
    );
  }
}

class _ItemCategoryTitle extends StatelessWidget {
  const _ItemCategoryTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8).copyWith(left: 15),
      child: Text(
        'Contacts on WhatsApp',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
      ),
    );
  }
}

class _BottomButtonGroup extends StatelessWidget {
  const _BottomButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ButtonListTile.lite(
          title: 'Share invite link',
          iconData: Icons.share,
        ),
        ButtonListTile.lite(
          title: 'Contact help',
          iconData: Icons.question_mark,
        ),
      ],
    );
  }
}
