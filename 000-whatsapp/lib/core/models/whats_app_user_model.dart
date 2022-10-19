import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'contact_model.dart';

const _uuid = Uuid();

/// WhatsApp user model.
class WhatsAppUser extends Equatable {
  /// User id.
  final String id;

  /// User name.
  final String name;

  /// Phone number of user.
  final String phNumber;

  /// User about text.
  final String about;

  /// Create WhatsApp user.
  const WhatsAppUser({
    required this.id,
    required this.name,
    required this.phNumber,
    this.about = 'About',
  });

  /// Create WhatsApp user from [Contact].
  WhatsAppUser.fromContact(Contact contact)
      : this(
          id: _uuid.v4(),
          name: contact.name,
          phNumber: contact.phNumber,
        );

  @override
  List<Object> get props => [id, name, phNumber, about];
}
