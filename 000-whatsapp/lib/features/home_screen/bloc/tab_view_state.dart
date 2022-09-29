part of 'tab_view_bloc.dart';

enum TabView { chats, status, calls }

abstract class TabViewState extends Equatable {
  const TabViewState({required this.tabView});

  final TabView tabView;

  @override
  List<Object> get props => [tabView];
}

class TabViewInitial extends TabViewState {
  const TabViewInitial() : super(tabView: TabView.chats);
}

class TabViewChangeState extends TabViewState {
  const TabViewChangeState({required super.tabView});
}
