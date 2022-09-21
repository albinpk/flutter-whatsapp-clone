import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/themes/custom_colors.dart';
import '../../../../../../widgets/widgets.dart';
import '../../../new_chat/new_chat.dart';

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
      bottom: const _SearchBar(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _SearchBar extends StatelessWidget with PreferredSizeWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return SizedBox(
      height: kToolbarHeight,
      child: ColoredBox(
        color: customColors.background!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: customColors.secondary!,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.search,
                            color: customColors.iconMuted,
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              hintText: 'Search or start new chat',
                              contentPadding: EdgeInsets.only(bottom: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                color: customColors.iconMuted,
                icon: const Icon(Icons.sort),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
