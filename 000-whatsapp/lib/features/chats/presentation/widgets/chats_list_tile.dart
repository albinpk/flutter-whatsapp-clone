import 'package:flutter/material.dart';

class ChatsListTile extends StatelessWidget {
  const ChatsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(radius: 26),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'John Doe',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '8/8/22',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Hi there!',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconTheme(
              data: IconTheme.of(context).copyWith(
                size: 18,
                color: Colors.grey[600],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.volume_off),
                  Icon(Icons.push_pin),
                  _UnreadMessageBadge(),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}

class _UnreadMessageBadge extends StatelessWidget {
  const _UnreadMessageBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      // Use size of other icons in ChatsListTile
      dimension: IconTheme.of(context).size,
      child: ClipOval(
        child: ColoredBox(
          color: Colors.green,
          child: Center(
            child: Text(
              '2',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
