part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsScreenOpen extends SettingsEvent {
  const SettingsScreenOpen();
}

class SettingsScreenClose extends SettingsEvent {
  const SettingsScreenClose();
}
