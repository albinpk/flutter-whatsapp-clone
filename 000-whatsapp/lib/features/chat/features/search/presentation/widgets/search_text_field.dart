import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    return TextField(
      autofocus: isMobile,
      cursorWidth: isMobile ? 2 : 1,
      cursorColor: isMobile ? CustomColors.of(context).primary : Colors.black,
      decoration: InputDecoration(
        hintText: isMobile ? 'Search...' : 'Search or start new chat',
        contentPadding: isMobile ? null : const EdgeInsets.only(bottom: 10),
        border: InputBorder.none,
      ),
    );
  }
}
