import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'list_item.dart';

class TitleItem implements ListItem {
  final String title;

  const TitleItem(this.title);

  @override
  Widget buildItem(context) => ItemCategoryTitle(title);
}
