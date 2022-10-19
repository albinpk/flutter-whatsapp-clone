import 'package:flutter/material.dart';

import '../../../../../../core/models/models.dart';
import '../views/users_and_contacts_view.dart';
import '../widgets/widgets.dart';
import 'list_item_impl.dart';

/// User item in [UsersAndContactsView] ListView.
class UserItem implements ListItemImpl {
  final WhatsAppUser user;

  const UserItem(this.user);

  @override
  Widget buildItem(context) => UserTile(user: user);
}
