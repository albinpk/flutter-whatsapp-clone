import 'package:uuid/uuid.dart';

import '../models/app_user_model.dart';
import 'whats_app_users.dart';

final appUser = AppUser(
  id: const Uuid().v4(),
  name: 'John Doe',
  phNumber: '+0000',
  friends: whatsappUsers.sublist(5).map((e) => e.id).toList(),
);
