import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dummy_data/dummy_data.dart';
import 'features/chat/chat.dart';
import 'home_screen/domain/repository/user_repository.dart';
import 'home_screen/home_screen.dart';
import 'models/models.dart';
import 'utils/themes/dark_theme.dart';
import 'utils/themes/light_theme.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider<User>.value(value: user),
        RepositoryProvider<List<WhatsAppUser>>.value(value: whatsappUsers),
        RepositoryProvider<List<Contact>>.value(value: contacts),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChatRoomBloc()),
          BlocProvider(create: (context) => NewChatBloc()),
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
