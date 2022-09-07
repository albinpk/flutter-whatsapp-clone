import '../models/user_model.dart';

const appUser = AppUser(
  id: -1,
  name: 'John Doe',
  friends: [2, 4, 5],
);

class AppUser extends User {
  const AppUser({
    required super.id,
    required super.name,
    super.friends,
  });
}
