class User {
  final int id;
  final String name;
  final List<int> friends;

  const User({
    required this.id,
    required this.name,
    this.friends = const [],
  });
}
