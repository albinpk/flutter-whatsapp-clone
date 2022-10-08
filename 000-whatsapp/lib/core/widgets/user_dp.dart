import 'package:flutter/material.dart';

class UserDP extends StatelessWidget {
  const UserDP({
    super.key,
    this.radius = 20,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return ClipOval(
      child: SizedBox.square(
        dimension: radius * 2,
        child: Image(
          image: Image.asset(
            isLight
                ? 'assets/images/default-user-avatar-light.png'
                : 'assets/images/default-user-avatar-dark.png',
          ).image,
        ),
      ),
    );
  }
}
