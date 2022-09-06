import '../models/user_model.dart';

final users = List<User>.generate(
  10,
  (index) => User(id: index, name: 'User name $index'),
);
