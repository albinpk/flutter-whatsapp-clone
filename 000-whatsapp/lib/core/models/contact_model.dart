import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String name;
  final String phNumber;

  const Contact({
    required this.name,
    required this.phNumber,
  });

  @override
  List<Object> get props => [name, phNumber];
}
