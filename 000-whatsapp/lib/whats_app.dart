import 'package:flutter/material.dart';

import 'features/app/presentation/widgets/sliver_wrap.dart';
import 'utils/themes/dark_theme.dart';
import 'utils/themes/light_theme.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const SliverWrap(),
    );
  }
}
