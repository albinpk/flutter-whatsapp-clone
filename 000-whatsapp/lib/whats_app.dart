import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/models/models.dart';
import 'core/utils/extensions/target_platform.dart';
import 'core/utils/themes/dark_theme.dart';
import 'core/utils/themes/light_theme.dart';
import 'dummy_data/dummy_data.dart';
import 'features/chat/chat.dart';
import 'features/home_screen/home_screen.dart';
import 'features/settings/settings.dart';
import 'features/status/status.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Disable the app on web version on mobile.
    if (defaultTargetPlatform.isWebMobile) {
      return const MaterialApp(
        title: 'WhatsApp',
        home: Scaffold(
          body: Center(
            child: Text('Please open in desktop browser.'),
          ),
        ),
      );
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider<User>.value(value: user),
        RepositoryProvider<List<WhatsAppUser>>.value(value: whatsappUsers),
        RepositoryProvider<List<Contact>>.value(value: contacts),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChatBloc(messageStore: messages)),
          BlocProvider(create: (context) => ChatRoomBloc()),
          BlocProvider(create: (context) => NewChatBloc()),
          BlocProvider(create: (context) => ChatSearchBloc()),
          BlocProvider(create: (context) => UserProfileBloc()),
          BlocProvider(create: (context) => SettingsBloc()),
          BlocProvider(create: (context) => ChatSettingsBloc()),
          BlocProvider(create: (context) => ProfileSettingsBloc()),
          BlocProvider(
            lazy: false,
            create: (context) => StatusBloc(
              whatsAppUsers: context.read<List<WhatsAppUser>>(),
            ),
          ),
          BlocProvider(create: (context) => StatusListViewCubit()),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            title: 'WhatsApp',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: context.select(
              (ChatSettingsBloc bloc) => bloc.state.themeMode,
            ),
            home: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}
