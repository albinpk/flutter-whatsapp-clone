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
    return CircleAvatar(
      radius: radius,
      backgroundColor: isLight ? Colors.white : const Color(0xFFCED8DE),
      child: FractionalTranslation(
        translation: const Offset(-0.11, -0.11),
        child: Icon(
          Icons.account_circle,
          color: isLight ? const Color(0xFFCED8DE) : const Color(0xFF627884),
          size: radius * 2.45,
        ),
      ),
    );
  }
}
