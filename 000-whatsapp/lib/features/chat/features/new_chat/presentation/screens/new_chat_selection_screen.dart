import 'package:flutter/material.dart';

import '../../../../../../utils/extensions/platform_type.dart';
import '../views/users_and_contacts_view.dart';
import '../widgets/new_chat_selection_app_bar.dart';

class NewChatSelectionScreen extends StatelessWidget {
  const NewChatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // context.read<ChatsBloc>().add(const ChatsContactsScreenPopped());
        return false;
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

// TODO: Extract to widgets
