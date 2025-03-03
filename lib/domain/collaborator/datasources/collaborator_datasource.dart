import 'package:go_work/data/collaborator/models/collaborator_model.dart';

abstract class CollaboratorDataSource {
  Future<int> insertCollaborator(CollaboratorModel collaborator);
  Future<List<CollaboratorModel>> getCollaborators();
  Future<CollaboratorModel?> getCollaboratorById(int id);
  Future<void> updateCollaborator(CollaboratorModel collaborator);
  Future<void> deleteCollaborator(int id);
}
