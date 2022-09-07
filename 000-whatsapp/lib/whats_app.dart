import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dummy_data/app_user.dart';
import 'dummy_data/users.dart';
import 'features/chats/bloc/chats_bloc.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'models/user_model.dart';
import 'utils/themes/dark_theme.dart';
import 'utils/themes/light_theme.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppUser>.value(value: appUser),
        RepositoryProvider<List<User>>.value(value: users),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChatsBloc()),
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
