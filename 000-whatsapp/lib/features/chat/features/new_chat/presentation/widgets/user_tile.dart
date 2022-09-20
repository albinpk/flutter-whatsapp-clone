import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/models.dart';
import '../../../../../../utils/extensions/platform_type.dart';
import '../../../../../../utils/themes/custom_colors.dart';
import '../../../../../../widgets/widgets.dart';
import '../../../../chat.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final WhatsAppUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const UserDP(),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        user.about,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
      ),
      onTap: () {
        context.read<NewChatBloc>().add(const NewChatSelectionScreenClose());
        if (Theme.of(context).platform.isMobile) Navigator.of(context).pop();
        context.read<ChatRoomBloc>().add(ChatRoomOpen(user: user));
      },
    );
  }
}
