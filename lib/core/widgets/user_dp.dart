import 'package:flutter/material.dart';

class UserDP extends StatelessWidget {
  const UserDP({
    super.key,
    this.radius = 20,
    this.url,
  });

  final double radius;

  /// The image url.
  ///
  /// If null, then default user avatar used.
  final String? url;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    // DP image
    final Image image;
    if (url != null) {
      image = Image.network(url!);
    } else {
      image = Image.asset(
        isLight
            ? 'assets/images/default-user-avatar-light.png'
            : 'assets/images/default-user-avatar-dark.png',
      );
    }

    return ClipOval(
      child: SizedBox.square(
        dimension: radius * 2,
        child: image,
      ),
    );
  }
}
