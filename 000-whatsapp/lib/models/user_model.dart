import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final List<String> friends;

  const User({
    required this.id,
    required this.name,
    this.friends = const [],
  });

  @override
  List<Object> get props => [id, name, friends];
}
