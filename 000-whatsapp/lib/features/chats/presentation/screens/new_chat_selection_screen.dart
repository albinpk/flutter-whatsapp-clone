import 'package:flutter/material.dart';

import '../views/contacts_view.dart';

class NewChatSelectionScreen extends StatelessWidget {
  const NewChatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: const ContactsView(),
    );
  }
}
