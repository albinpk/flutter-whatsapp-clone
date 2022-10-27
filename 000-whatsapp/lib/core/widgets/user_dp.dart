import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';

class UserDP extends StatelessWidget {
  const UserDP({
    super.key,
    this.radius = 20,
    this.url,
  });

  final double radius;

  /// The image url.
  ///
  /// If null, then the [WhatsAppUser.dpUrl] is used.
  ///
  /// If cannot find [WhatsAppUser] above widget tree or
  /// [WhatsAppUser.dpUrl] is null, then default user avatar used.
  final String? url;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    // DP image
    final Image image;
    final String? link; // To reuse only // assigned in if condition
    if (url != null) {
      image = Image.network(url!);
    } else if ((link = context.select((WhatsAppUser? u) => u?.dpUrl)) != null) {
      image = Image.network(link!);
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
