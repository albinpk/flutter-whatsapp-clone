part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileOpen extends UserProfileEvent {
  const UserProfileOpen({required this.user});

  final WhatsAppUser user;

  @override
  List<Object> get props => [user];
}

class UserProfileClose extends UserProfileEvent {
  const UserProfileClose();
}
