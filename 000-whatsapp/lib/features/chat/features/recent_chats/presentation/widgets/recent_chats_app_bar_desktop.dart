import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../new_chat/new_chat.dart';
import '../../../search/search.dart';

class RecentChatsAppBarDesktop extends StatelessWidget
    with PreferredSizeWidget {
  const RecentChatsAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    const actionsIconPadding = EdgeInsets.symmetric(horizontal: 15);
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: FittedBox(child: UserDP()),
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).brightness == Brightness.light
            ? CustomColors.of(context).onBackgroundMuted
            : CustomColors.of(context).iconMuted,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.circle_outlined),
          padding: actionsIconPadding,
        ),
        IconButton(
          onPressed: () {
            context.read<NewChatBloc>().add(const NewChatSelectionScreenOpen());
          },
          icon: const Icon(Icons.message),
          padding: actionsIconPadding,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          padding: actionsIconPadding,
        ),
      ],
      bottom: const SearchBarDesktop(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}
