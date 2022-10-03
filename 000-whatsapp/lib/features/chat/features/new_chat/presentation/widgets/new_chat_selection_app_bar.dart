import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../new_chat.dart';

class NewChatSelectionAppBar extends StatelessWidget {
  const NewChatSelectionAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          context.read<NewChatBloc>().add(const NewChatSelectionScreenClose());
          if (isMobile) Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(isMobile ? 'Select contact' : 'New chat'),
      actions: !isMobile
          ? null
          : [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
    );

    return isMobile
        ? appBar
        : AppBar(
            bottom: appBar,
            elevation: 0,
            automaticallyImplyLeading: false,
          );
  }
}
