import 'package:flutter/material.dart';

class ChatsListTile extends StatelessWidget {
  const ChatsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('John Doe'),
      subtitle: const Text('Hi there!'),
      leading: const CircleAvatar(radius: 26),
      trailing: const Text('8/8/22'),
      onTap: () {},
    );
  }
}
