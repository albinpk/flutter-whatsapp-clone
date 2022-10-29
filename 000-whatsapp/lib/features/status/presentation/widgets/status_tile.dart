import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusTile extends StatelessWidget {
  /// Create a status tile widget.
  const StatusTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  })  : assert(onTap != null),
        _status = null;

  /// Create status tile from [Status].
  StatusTile.fromStatus(Status status, {super.key})
      : _status = status,
        leading = StatusPreviewCircle(status: status),
        title = status.author.name,
        subtitle = DateFormat(DateFormat.HOUR_MINUTE).format(status.time),
        onTap = null;

  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  final Status? _status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      visualDensity: VisualDensity.standard,
      onTap: onTap ??
          () {
            Navigator.of(context).push(
              FadePageRoute(
                builder: (context) => StatusPageView(
                  initialPage: context
                      .read<StatusBloc>()
                      .state
                      .statuses
                      .indexOf(_status!),
                ),
              ),
            );
          },
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
