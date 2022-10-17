part of 'chat_settings_bloc.dart';

class ChatSettingsState extends Equatable {
  const ChatSettingsState({
    required this.themeMode,
  });

  const ChatSettingsState.initial() : this(themeMode: ThemeMode.system);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  ChatSettingsState copyWith({
    ThemeMode? themeMode,
  }) {
    return ChatSettingsState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
