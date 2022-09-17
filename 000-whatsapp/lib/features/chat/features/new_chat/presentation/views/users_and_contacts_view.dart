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
      // itemExtent: 68,
      itemBuilder: (_, index) {
        if (index == 0) {
          return const _TopButtonGroup();
        } else if (index == users.length + 1) {
          return const _BottomButtonGroup();
        }

        final user = users[index - 1];
        return UsersAndContactsListTile(user: user);
      },
    );
  }
}

class _TopButtonGroup extends StatelessWidget {
  const _TopButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ExtraButton(
          iconData: Icons.group,
          title: 'New group',
        ),
        _ExtraButton(
          title: 'New contact',
          iconData: Icons.person_add,
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code),
            color: CustomColors.of(context).iconMuted,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8).copyWith(left: 15),
          child: Text(
            'Contacts on WhatsApp',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: CustomColors.of(context).onBackgroundMuted,
                ),
          ),
        ),
      ],
    );
  }
}

class _BottomButtonGroup extends StatelessWidget {
  const _BottomButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ExtraButton.lite(
          title: 'Share invite link',
          iconData: Icons.share,
        ),
        _ExtraButton.lite(
          title: 'Contact help',
          iconData: Icons.question_mark,
        ),
      ],
    );
  }
}

class _ExtraButton extends StatelessWidget {
  const _ExtraButton({
    Key? key,
    required this.title,
    required this.iconData,
    this.trailing,
  })  : isLite = false,
        super(key: key);

  const _ExtraButton.lite({
    Key? key,
    required this.title,
    required this.iconData,
  })  : isLite = true,
        trailing = null,
        super(key: key);

  final String title;
  final IconData iconData;
  final Widget? trailing;
  final bool isLite;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return ListTile(
      minVerticalPadding: 25,
      leading: CircleAvatar(
        backgroundColor: isLite
            ? customColors.iconMuted!.withOpacity(0.2)
            : customColors.primary,
        foregroundColor:
            isLite ? customColors.iconMuted : customColors.onPrimary,
        child: Icon(iconData),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: trailing,
    );
  }
}
