part of 'chat_settings_bloc.dart';

abstract class ChatSettingsEvent extends Equatable {
  const ChatSettingsEvent();

  @override
  List<Object> get props => [];
}

class ChatSettingsThemeModeChange extends ChatSettingsEvent {
  const ChatSettingsThemeModeChange({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
