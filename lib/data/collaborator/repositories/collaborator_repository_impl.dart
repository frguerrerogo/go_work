import 'package:go_work/data/collaborator/adapters/collaborator_adapter.dart';
import 'package:go_work/domain/collaborator/datasources/collaborator_datasource.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';

class CollaboratorRepositoryImpl implements CollaboratorRepository {
  final CollaboratorDataSource dataSource;
  final CollaboratorAdapter adapter;

  CollaboratorRepositoryImpl(this.adapter, {required this.dataSource});
  @override
  Future<List<Collaborator>> getCollaborators() async {
    final collaboratorModels = await dataSource.getCollaborators();
    final collaboratorEntis =
        collaboratorModels.map((model) => adapter.toEntity(model)).toList();
    return collaboratorEntis;
  }

  @override
  Future<Collaborator?> getCollaboratorById(String id) async {
    final collaboratorModel =
        await dataSource.getCollaboratorById(int.parse(id));
    if (collaboratorModel != null) {
      return adapter.toEntity(collaboratorModel);
    }
    throw Exception('Collaborator not found');
  }

  @override
  Future<void> createCollaborator(Collaborator collaborator) async {
    final collaboratorModel = adapter.toModel(collaborator);
    await dataSource.insertCollaborator(collaboratorModel);
  }

  @override
  Future<void> updateCollaborator(Collaborator collaborator) async {
    final collaboratorModel = adapter.toModel(collaborator);
    await dataSource.updateCollaborator(collaboratorModel);
  }

  @override
  Future<void> deleteCollaborator(String id) async {
    await dataSource.deleteCollaborator(int.parse(id));
  }
}
