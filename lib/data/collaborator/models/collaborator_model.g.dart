// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaborator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollaboratorModel _$CollaboratorModelFromJson(Map<String, dynamic> json) =>
    CollaboratorModel(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: (json['birthDate'] as num).toInt(),
      imagePath: json['imagePath'] as String?,
      addresses: json['addresses'] as String,
    );

Map<String, dynamic> _$CollaboratorModelToJson(CollaboratorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'imagePath': instance.imagePath,
      'addresses': instance.addresses,
    };
