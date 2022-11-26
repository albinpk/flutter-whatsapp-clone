import 'package:uuid/uuid.dart';

import '../core/models/models.dart';

final user = User(
  id: const Uuid().v4(),
  name: 'John Doe',
  phNumber: '+0000',
  dpUrl: 'https://picsum.photos/500',
);
