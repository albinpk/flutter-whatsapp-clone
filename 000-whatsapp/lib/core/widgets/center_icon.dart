import 'package:flutter/material.dart';

/// Center the icon in [ListTile.leading].
class CenterIcon extends StatelessWidget {
  const CenterIcon(this.iconData, {super.key});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      // To center vertically
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // To center horizontally
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(iconData),
        )
      ],
    );
  }
}
