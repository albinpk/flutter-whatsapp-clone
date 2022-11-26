part of 'message_input_bloc.dart';

class MessageInputState extends Equatable {
  /// TextField value
  final String text;

  /// Whether send button pressed
  final bool isSendPressed;

  const MessageInputState({
    this.text = '',
    this.isSendPressed = false,
  });

  /// Returns `text.trim().isEmpty`
  bool get isEmpty => text.trim().isEmpty;

  /// Return total number of lines (`\n`) in message text.
  int get lineCount => text.split('\n').length;

  @override
  List<Object> get props => [text, isSendPressed];

  MessageInputState copyWith({
    String? text,
    bool isSendPressed = false,
  }) {
    return MessageInputState(
      text: text ?? this.text,
      isSendPressed: isSendPressed,
    );
  }
}
