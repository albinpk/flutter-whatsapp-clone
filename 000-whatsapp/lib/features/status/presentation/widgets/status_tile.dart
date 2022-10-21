import 'package:flutter/material.dart';

import '../../../../core/utils/themes/custom_colors.dart';

class StatusTile extends StatelessWidget {
  /// Create a status tile widget.
  const StatusTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodyMedium!.copyWith(
          color: CustomColors.of(context).onBackgroundMuted,
        ),
      ),
    );
  }
}
