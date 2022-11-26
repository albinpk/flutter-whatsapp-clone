import 'package:flutter/material.dart';

import '../../new_chat.dart';

/// A model used for build ListView on [UsersAndContactsView].
///
/// This class is implemented on [ButtonItem], [ContactItem],
/// [TitleItem] and [UserItem] classes.
abstract class ListItemImpl {
  Widget buildItem(BuildContext context);
}
