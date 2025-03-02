class CollaboratorModel {
  int? id;
  final String firstName;
  final String lastName;
  final int birthDate;
  final String? imagePath;
  final List<String> addresses;

  CollaboratorModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.imagePath,
    this.addresses = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'imagePath': imagePath,
      'addresses': addresses.join(','),
    };
  }

  factory CollaboratorModel.fromMap(Map<String, dynamic> map) {
    return CollaboratorModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      birthDate: map['birthDate'],
      imagePath: map['imagePath'],
      addresses: map['addresses'].split(','),
    );
  }
}
