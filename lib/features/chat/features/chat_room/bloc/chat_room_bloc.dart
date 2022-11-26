import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/models.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc() : super(ChatRoomInitial()) {
    on<ChatRoomOpen>(_onChatRoomOpen);
    on<ChatRoomClose>(_onChatRoomClose);
  }

  void _onChatRoomOpen(
    ChatRoomOpen event,
    Emitter<ChatRoomState> emit,
  ) {
    emit(ChatRoomOpenState(user: event.user));
  }

  void _onChatRoomClose(
    ChatRoomClose event,
    Emitter<ChatRoomState> emit,
  ) {
    emit(const ChatRoomCloseState());
  }
}
