class Collaborator {
  final int? id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String? imagePath;
  final List<String> addresses;

  Collaborator({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.imagePath,
    this.addresses = const [],
  });
}
