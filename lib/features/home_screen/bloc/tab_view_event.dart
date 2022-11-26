part of 'tab_view_bloc.dart';

abstract class TabViewEvent extends Equatable {
  const TabViewEvent();

  @override
  List<Object> get props => [];
}

class TabViewChange extends TabViewEvent {
  const TabViewChange({required this.tabView});

  final TabView tabView;

  @override
  List<Object> get props => [tabView];
}
