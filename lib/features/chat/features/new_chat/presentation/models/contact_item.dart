import 'package:flutter/material.dart';

import '../../../../../../core/models/models.dart';
import '../views/users_and_contacts_view.dart';
import '../widgets/widgets.dart';
import 'list_item_impl.dart';

/// Contact item in [UsersAndContactsView] ListView.
class ContactItem implements ListItemImpl {
  final Contact contact;

  ContactItem(this.contact);

  @override
  Widget buildItem(context) => ContactTile(contact: contact);
}
