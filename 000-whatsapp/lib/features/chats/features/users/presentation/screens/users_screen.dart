import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/extensions/platform_type.dart';
import '../../../../bloc/chats_bloc.dart';
import '../views/users_view.dart';
import '../widgets/users_app_bar.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatsBloc>().add(const ChatsContactsScreenPopped());
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Theme.of(context).platform.isMobile
              ? const Size.fromHeight(kToolbarHeight)
              : const Size.fromHeight(kToolbarHeight * 2),
          child: const UsersAppBar(),
        ),
        body: const UsersView(),
      ),
    );
  }
}

// TODO: Extract to widgets
