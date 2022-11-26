import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'contact_model.dart';

const _uuid = Uuid();
final _random = Random();

/// WhatsApp user model.
class WhatsAppUser extends Equatable {
  /// User id.
  final String id;

  /// User name.
  final String name;

  /// Phone number of user.
  final String phNumber;

  /// User DP url.
  final String? dpUrl;

  /// User about text.
  final String about;

  /// Create WhatsApp user.
  const WhatsAppUser({
    required this.id,
    required this.name,
    required this.phNumber,
    this.dpUrl,
    this.about = 'About',
  });

  /// Create WhatsApp user from [Contact].
  /// With a random `dpUrl` (maybe null).
  WhatsAppUser.fromContact(Contact contact)
      : this(
          id: _uuid.v4(),
          name: contact.name,
          phNumber: contact.phNumber,
          dpUrl: _random.nextBool()
              ? null
              : 'https://picsum.photos/500?random=${_random.nextInt(100)}',
        );

  @override
  List<Object?> get props => [id, name, phNumber, dpUrl, about];
}
