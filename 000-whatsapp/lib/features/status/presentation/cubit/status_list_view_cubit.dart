import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_list_view_state.dart';

class StatusListViewCubit extends Cubit<StatusListViewState> {
  StatusListViewCubit() : super(StatusListViewInitial());

  /// Emits [StatusListViewOpenState].
  void push() => emit(const StatusListViewOpenState());

  /// Emits [StatusListViewCloseState].
  void pop() => emit(const StatusListViewCloseState());
}
