import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/models.dart';
import '../../../../core/utils/extensions/target_platform.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../settings.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    final theme = Theme.of(context);
    final isMobile = theme.platform.isMobile;
    final textTheme = theme.textTheme;
    final customColors = CustomColors.of(context);

    return InkWell(
      onTap: () {
        context.read<ProfileSettingsBloc>().add(const ProfileSettingsOpen());
      },
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            Hero(
              tag: 'user-profile-dp',
              child: UserDP(
                radius: isMobile ? 30 : 35,
                url: user.dpUrl,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.about,
                  style: textTheme.bodyMedium!.copyWith(
                    color: customColors.onBackgroundMuted,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isMobile)
              Icon(
                Icons.qr_code,
                color: customColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
