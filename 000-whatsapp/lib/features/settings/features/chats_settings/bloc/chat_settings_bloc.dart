import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_settings_event.dart';
part 'chat_settings_state.dart';

class ChatSettingsBloc extends Bloc<ChatSettingsEvent, ChatSettingsState> {
  ChatSettingsBloc() : super(const ChatSettingsState.initial()) {
    on<ChatSettingsThemeModeChange>(_onThemeModeChange);
  }

  void _onThemeModeChange(
    ChatSettingsThemeModeChange event,
    Emitter<ChatSettingsState> emit,
  ) {
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
