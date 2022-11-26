import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../models/models.dart';

class UsersAndContactsView extends StatelessWidget {
  const UsersAndContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _UsersAndContactsViewMobile()
        : const _UsersAndContactsViewDesktop();
  }
}

class _UsersAndContactsViewMobile extends StatelessWidget {
  const _UsersAndContactsViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = context.watch<List<WhatsAppUser>>();
    final contacts = context.watch<List<Contact>>();
    final List<ListItemImpl> items = _generateItems(context, contacts, users);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 6),
      itemCount: items.length,
      itemBuilder: (c, i) => items[i].buildItem(c),
    );
  }

  List<ListItemImpl> _generateItems(
    BuildContext context,
    List<Contact> contacts,
    List<WhatsAppUser> users,
  ) {
    return [
      const ButtonItem(title: 'New group', iconData: Icons.group),
      ButtonItem(
        title: 'New contact',
        iconData: Icons.person_add,
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.qr_code),
          color: CustomColors.of(context).iconMuted,
        ),
      ),
      const TitleItem('Contacts on WhatsApp'),
      ...users.map((u) => UserItem(u)),
      const TitleItem('Invite to WhatsApp'),
      ...contacts
          .where((c) => users.where((u) => u.phNumber == c.phNumber).isEmpty)
          .map((e) => ContactItem(e)),
      const ButtonItem(
        title: 'Share invite link',
        iconData: Icons.share,
        isLite: true,
      ),
      const ButtonItem(
        title: 'Contact help',
        iconData: Icons.question_mark,
        isLite: true,
      ),
    ];
  }
}

class _UsersAndContactsViewDesktop extends StatelessWidget {
  const _UsersAndContactsViewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = context.watch<List<WhatsAppUser>>();
    final List<ListItemImpl> items = _generateItems(users);

    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(indent: 65, height: 1),
      itemCount: items.length,
      itemBuilder: (c, i) => items[i].buildItem(c),
    );
  }

  List<ListItemImpl> _generateItems(List<WhatsAppUser> users) {
    String lastTitle = '';
    final List<ListItemImpl> items = [
      const ButtonItem(title: 'New group', iconData: Icons.group),
    ];
    for (final user in users) {
      items.addAll([
        if (lastTitle != (lastTitle = user.name[0].toUpperCase()))
          TitleItem(lastTitle),
        UserItem(user),
      ]);
    }
    return items;
  }
}
