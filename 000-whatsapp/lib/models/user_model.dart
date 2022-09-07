import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final List<int> friends;

  const User({
    required this.id,
    required this.name,
    this.friends = const [],
  });

  @override
  List<Object> get props => [id, name, friends];
}
