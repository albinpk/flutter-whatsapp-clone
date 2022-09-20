import 'package:flutter/material.dart';

import '../../../../../../models/models.dart';
import '../widgets/widgets.dart';
import 'list_item.dart';

class UserItem implements ListItem {
  final WhatsAppUser user;

  const UserItem(this.user);

  @override
  Widget buildItem(context) => UsersAndContactsListTile(user: user);
}
