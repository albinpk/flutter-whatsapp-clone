import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

const uuid = Uuid();

final users = List<User>.generate(
  10,
  (index) => User(id: uuid.v4(), name: 'User name $index'),
);
