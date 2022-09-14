import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/dummy_data/whats_app_users.dart';

import 'dummy_data/app_user.dart';
import 'features/chat/chat.dart';
import 'features/home_screen/home_screen.dart';
import 'models/app_user_model.dart';
import 'models/whats_app_user_model.dart';
import 'utils/themes/dark_theme.dart';
import 'utils/themes/light_theme.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppUser>.value(value: appUser),
        RepositoryProvider<List<WhatsAppUser>>.value(value: whatsappUsers),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChatBloc()),
        ],
        child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
