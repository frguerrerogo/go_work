import 'package:go_work/data/core/adapter/adapter.dart';
import 'package:go_work/data/collaborator/models/collaborator_model.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';

class CollaboratorAdapter implements Adapter<Collaborator, CollaboratorModel> {
  @override
  CollaboratorModel toModel(Collaborator entity) {
    return CollaboratorModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      birthDate: entity.birthDate.millisecondsSinceEpoch ~/ 1000,
      imagePath: entity.imagePath,
      addresses: entity.addresses,
    );
  }

  @override
  Collaborator toEntity(CollaboratorModel model) {
    return Collaborator(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      birthDate: DateTime.fromMillisecondsSinceEpoch(model.birthDate * 1000),
      imagePath: model.imagePath,
      addresses: model.addresses,
    );
  }
}
