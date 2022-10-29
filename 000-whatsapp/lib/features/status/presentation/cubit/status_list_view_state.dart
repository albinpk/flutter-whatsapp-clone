part of 'status_list_view_cubit.dart';

abstract class StatusListViewState extends Equatable {
  const StatusListViewState();

  @override
  List<Object> get props => [];
}

class StatusListViewInitial extends StatusListViewState {}

class StatusListViewOpenState extends StatusListViewState {
  const StatusListViewOpenState();
}

class StatusListViewCloseState extends StatusListViewState {
  const StatusListViewCloseState();
}
