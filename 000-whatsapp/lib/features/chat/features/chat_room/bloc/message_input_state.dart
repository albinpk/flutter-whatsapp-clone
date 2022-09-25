part of 'message_input_bloc.dart';

class MessageInputState extends Equatable {
  final String text;

  const MessageInputState({
    this.text = '',
  });

  /// Returns `text.trim().isEmpty`
  bool get isEmpty => text.trim().isEmpty;

  @override
  List<Object> get props => [text];

  MessageInputState copyWith({
    String? text,
  }) {
    return MessageInputState(
      text: text ?? this.text,
    );
  }
}
