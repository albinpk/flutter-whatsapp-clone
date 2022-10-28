import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc() : super(ProfileSettingsInitial()) {
    on<ProfileSettingsOpen>(_onOpen);
    on<ProfileSettingsClose>(_onClose);
  }

  void _onOpen(ProfileSettingsOpen event, Emitter<ProfileSettingsState> emit) {
    emit(const ProfileSettingsOpenState());
  }

  void _onClose(
    ProfileSettingsClose event,
    Emitter<ProfileSettingsState> emit,
  ) {
    emit(const ProfileSettingsCloseState());
  }
}
