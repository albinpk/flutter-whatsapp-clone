import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/types.dart';
import '../../../dummy_data/dummy_data.dart';
import '../chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    MessageStore messageStore = const {},
  }) : super(ChatState.initial(messageStore));
}
