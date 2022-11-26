import 'package:flutter/material.dart';

class CenterIcon extends StatelessWidget {
  /// Center the icon in [ListTile.leading].
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
