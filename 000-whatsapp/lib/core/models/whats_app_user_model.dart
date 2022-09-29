import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'contact_model.dart';

const _uuid = Uuid();

class WhatsAppUser extends Equatable {
  final String id;
  final String name;
  final String phNumber;
  final String about;

  const WhatsAppUser({
    required this.id,
    required this.name,
    required this.phNumber,
    this.about = 'About',
  });

  factory WhatsAppUser.fromContact(Contact contact) {
    return WhatsAppUser(
      id: _uuid.v4(),
      name: contact.name,
      phNumber: contact.phNumber,
    );
  }

  @override
  List<Object> get props => [id, name, phNumber, about];
}
