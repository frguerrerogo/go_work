
import 'package:go_work/domain/entities/collaborator/Collaborator_entity.dart';

abstract class CollaboratorRepository {
  Future<List<Collaborator>> getCollaborators();
  Future<Collaborator> getCollaboratorById(String id);
  Future<void> createCollaborator(Collaborator collaborator);
  Future<void> updateCollaborator(Collaborator collaborator);
  Future<void> deleteCollaborator(String id);
}