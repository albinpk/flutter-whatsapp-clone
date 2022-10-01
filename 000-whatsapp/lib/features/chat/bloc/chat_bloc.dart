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
    on<ChatMarkMessageAsRead>(_onMarkMessageAsRead);
  }

  /// Return a fresh copy of _messageStore
  Map<String, List<Message>> get _store => Map.from(state._messageStore);

  Future<void> _onMessageSend(
    ChatMessageSend event,
    Emitter<ChatState> emit,
  ) async {
    final message = event.message;

    // Add the message to messageStore
    final MessageStore store = _store;
    store.update(
      event.to.id,
      (messages) => [...messages, message],
      ifAbsent: () => [message],
    );
    emit(state.copyWith(messageStore: store));

    /// Update the status of sended message and emit
    void updateStatusAndEmit(MessageStatus status) {
      final MessageStore store = _store;
      store.update(
        event.to.id,
        (messages) {
          final i = messages.indexWhere((m) => m.id == message.id);
          final updatedMsg = messages[i].changeStatus(status);
          return [...messages]..replaceRange(i, i + 1, [updatedMsg]);
        },
      );
      emit(state.copyWith(messageStore: store));
    }

    // Mock message status changes and reply the same message

    // Set status to sended
    await Future.delayed(const Duration(milliseconds: 500), () {
      updateStatusAndEmit(MessageStatus.sended);
    });

    // Set status to delivered
    await Future.delayed(const Duration(milliseconds: 500), () {
      updateStatusAndEmit(MessageStatus.delivered);
    });

    // Set status to read
    await Future.delayed(const Duration(seconds: 1), () {
      updateStatusAndEmit(MessageStatus.read);
    });

    // Reply the same message
    await Future.delayed(const Duration(seconds: 2), () {
      final MessageStore store = _store;
      store.update(
        event.to.id,
        (messages) => [
          ...messages,
          Message.fromText(
            '${message.content.text} ${message.content.text}',
            author: event.to,
            status: MessageStatus.delivered,
          ),
        ],
      );
      emit(state.copyWith(messageStore: store));
    });
  }

  void _onMarkMessageAsRead(
    ChatMarkMessageAsRead event,
    Emitter<ChatState> emit,
  ) {
    final store = _store;
    store.update(
      event.user.id,
      (msgs) {
        final i = msgs.indexOf(event.message);
        return [...msgs]..replaceRange(
            i,
            i + 1,
            [event.message.changeStatus(MessageStatus.read)],
          );
      },
    );
    emit(state.copyWith(messageStore: store));
  }
}
