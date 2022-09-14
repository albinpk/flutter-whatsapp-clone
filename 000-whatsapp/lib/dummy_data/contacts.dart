import '../models/contact_model.dart';

/// All contacts saved in user's phone
final List<Contact> contacts = List<Contact>.generate(
  30,
  (index) => Contact(
    name: 'User name ${++index}',
    phNumber: '+000${++index}',
  ),
);
