import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_search_event.dart';
part 'chat_search_state.dart';

class ChatSearchBloc extends Bloc<ChatSearchEvent, ChatSearchState> {
  ChatSearchBloc() : super(ChatSearchInitial()) {
    on<ChatSearchOpen>(_onChatSearchOpen);
    on<ChatSearchClose>(_onChatSearchClose);
  }

  void _onChatSearchOpen(
    ChatSearchOpen event,
    Emitter<ChatSearchState> emit,
  ) {
    emit(const ChatSearchOpenState());
  }

  void _onChatSearchClose(
    ChatSearchClose event,
    Emitter<ChatSearchState> emit,
  ) {
    emit(const ChatSearchCloseState());
  }
}
