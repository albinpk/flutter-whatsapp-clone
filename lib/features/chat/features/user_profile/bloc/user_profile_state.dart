part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileOpenState extends UserProfileState {
  const UserProfileOpenState({required this.user});

  final WhatsAppUser user;

  @override
  List<Object> get props => [user];
}

class UserProfileCloseState extends UserProfileState {
  const UserProfileCloseState();
}
