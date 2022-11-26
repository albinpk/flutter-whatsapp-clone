import 'dart:math';

import '../core/models/models.dart';

final _random = Random();

/// All contacts saved in user's phone
final List<Contact> contacts = List<Contact>.generate(
  30,
  (index) => Contact(
    name: '${String.fromCharCode(_random.nextInt(25) + 65)} User ${++index}',
    phNumber: '+000${++index}',
  ),
)..sort((a, b) => a.name.compareTo(b.name));
