import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

final appUser = AppUser(
  id: const Uuid().v4(),
  name: 'John Doe',
);

class AppUser extends User {
  const AppUser({
    required super.id,
    required super.name,
    super.friends,
  });
}
