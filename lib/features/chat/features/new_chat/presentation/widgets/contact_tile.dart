import 'package:flutter/material.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 25,
      title: Text(
        contact.name,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      leading: const UserDP(),
      trailing: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll<Color>(
            CustomColors.of(context).primary!.withOpacity(0.1),
          ),
        ),
        child: Text(
          'INVITE',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: CustomColors.of(context).primary,
                letterSpacing: 1,
              ),
        ),
      ),
    );
  }
}
