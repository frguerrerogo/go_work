import 'package:json_annotation/json_annotation.dart';

part 'collaborator_model.g.dart'; // Archivo generado automáticamente

@JsonSerializable() // Anotación para generar códig
class CollaboratorModel {
  int? id;
  final String firstName;
  final String lastName;
  final int birthDate;
  final String? imagePath;
  final String addresses;

  CollaboratorModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.imagePath,
    required this.addresses,
  });

  // Método para deserializar JSON
  factory CollaboratorModel.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorModelFromJson(json);

  // Método para serializar a JSON
  Map<String, dynamic> toJson() => _$CollaboratorModelToJson(this);
}
