part of 'profile_settings_bloc.dart';

abstract class ProfileSettingsEvent extends Equatable {
  const ProfileSettingsEvent();

  @override
  List<Object> get props => [];
}

class ProfileSettingsOpen extends ProfileSettingsEvent {
  const ProfileSettingsOpen();
}

class ProfileSettingsClose extends ProfileSettingsEvent {
  const ProfileSettingsClose();
}
