import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../../../core/types.dart';
import '../../../dummy_data/dummy_data.dart';
import '../chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    MessageStore messageStore = const {},
  }) : super(ChatState(messageStore: messageStore)) {
    on<ChatMessageSend>(_onMessageSend);
  }

  void _onMessageSend(
    ChatMessageSend event,
    Emitter<ChatState> emit,
  ) {
    final MessageStore store = Map.from(state._messageStore);
    store.update(
      event.to.id,
      (messages) => [...messages, event.message],
      ifAbsent: () => [event.message],
    );
    emit(state.copyWith(messageStore: store));
  }
}
