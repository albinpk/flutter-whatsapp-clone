import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/models.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<UserProfileOpen>(_onOpen);
    on<UserProfileClose>(_onClose);
  }

  void _onOpen(UserProfileOpen event, Emitter<UserProfileState> emit) {
    emit(UserProfileOpenState(user: event.user));
  }

  void _onClose(UserProfileClose event, Emitter<UserProfileState> emit) {
    emit(const UserProfileCloseState());
  }
}
