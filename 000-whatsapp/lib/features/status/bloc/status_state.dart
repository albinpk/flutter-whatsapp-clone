part of 'status_bloc.dart';

abstract class StatusState extends Equatable {
  const StatusState();
  
  @override
  List<Object> get props => [];
}

class StatusInitial extends StatusState {}
