part of 'profile_settings_bloc.dart';

abstract class ProfileSettingsState extends Equatable {
  const ProfileSettingsState();
  
  @override
  List<Object> get props => [];
}

class ProfileSettingsInitial extends ProfileSettingsState {}
