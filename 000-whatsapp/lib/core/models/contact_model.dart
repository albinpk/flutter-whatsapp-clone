import 'package:equatable/equatable.dart';

/// Contact in user's phone.
class Contact extends Equatable {
  /// Contact name.
  final String name;

  /// Phone number.
  final String phNumber;

  /// Create a contact with [name] and [phNumber].
  const Contact({
    required this.name,
    required this.phNumber,
  });

  @override
  List<Object> get props => [name, phNumber];
}
