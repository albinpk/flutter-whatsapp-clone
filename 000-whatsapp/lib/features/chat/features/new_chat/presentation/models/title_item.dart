import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../views/users_and_contacts_view.dart';
import 'list_item_impl.dart';

/// Title item in [UsersAndContactsView] ListView.
class TitleItem implements ListItemImpl {
  final String title;

  const TitleItem(this.title);

  @override
  Widget buildItem(context) {
    final isDesktop = Theme.of(context).platform.isDesktop;
    return ListSectionTitle(
      title,
      textColor: isDesktop ? CustomColors.of(context).primary : null,
      padding: isDesktop ? const EdgeInsets.all(25).copyWith(left: 30) : null,
    );
  }
}
