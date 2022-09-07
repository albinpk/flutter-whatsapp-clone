import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsTilePressed>(_chatsTilePressed);
    on<ChatsScreenCloseButtonPressed>(_chatsScreenCloseButtonPressed);
  }

  void _chatsTilePressed(
    ChatsTilePressed event,
    Emitter<ChatsState> emit,
  ) {
    emit(ChatsRoomOpened(user: event.user));
  }

  void _chatsScreenCloseButtonPressed(
    ChatsScreenCloseButtonPressed event,
    Emitter<ChatsState> emit,
  ) {
    emit(const ChatsRoomClosed());
  }
}
