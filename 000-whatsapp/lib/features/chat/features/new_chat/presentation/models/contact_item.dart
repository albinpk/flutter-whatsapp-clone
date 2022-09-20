import 'package:flutter/material.dart';

import '../../../../../../models/models.dart';
import '../widgets/widgets.dart';
import 'list_item.dart';

class ContactItem implements ListItem {
  final Contact contact;

  ContactItem(this.contact);

  @override
  Widget buildItem(context) => ContactTile(contact: contact);
}
