import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../new_chat.dart';

class NewChatSelectionScreen extends StatelessWidget {
  const NewChatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NewChatBloc>().add(const NewChatSelectionScreenClose());
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Theme.of(context).platform.isMobile
              ? const Size.fromHeight(kToolbarHeight)
              : const Size.fromHeight(kToolbarHeight * 2),
          child: const NewChatSelectionAppBar(),
        ),
        body: const UsersAndContactsView(),
      ),
    );
  }
}
