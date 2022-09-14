import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/whats_app_user_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatRoomOpen>(_onChatRoomOpen);
    on<ChatRoomClose>(_onChatRoomClose);
  }

  void _onChatRoomOpen(
    ChatRoomOpen event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatRoomOpenState(user: event.user));
  }

  FutureOr<void> _onChatRoomClose(
    ChatRoomClose event,
    Emitter<ChatState> emit,
  ) {
    emit(const ChatRoomCloseState());
  }
}
