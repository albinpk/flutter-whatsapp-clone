import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_view_event.dart';
part 'tab_view_state.dart';

class TabViewBloc extends Bloc<TabViewEvent, TabViewState> {
  TabViewBloc() : super(const TabViewInitial()) {
    on<TabViewChange>(_onTabViewChange);
  }

  void _onTabViewChange(
    TabViewChange event,
    Emitter<TabViewState> emit,
  ) {
    emit(TabViewChangeState(tabView: event.tabView));
  }
}
