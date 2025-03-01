class Collaborator {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<String> addresses;

  Collaborator({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.addresses = const [],
  });

  @override
  String toString() {
    return 'Collaborator(id: $id, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, addresses: $addresses)';
  }
}