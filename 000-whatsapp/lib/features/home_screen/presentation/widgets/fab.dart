import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/chat.dart';

class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSearchOpen = context.select(
      (ChatSearchBloc bloc) => bloc.state is ChatSearchOpenState,
    );

    if (isSearchOpen) return const SizedBox.shrink();

    return FloatingActionButton(
      child: const Icon(Icons.message),
      onPressed: () {
        context.read<NewChatBloc>().add(const NewChatSelectionScreenOpen());
      },
    );
  }
}
