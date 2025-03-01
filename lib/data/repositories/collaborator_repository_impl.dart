import 'package:go_work/domain/entities/collaborator/Collaborator_entity.dart';
import 'package:go_work/domain/repositories/collaborator_repository.dart';

class CollaboratorRepositoryImpl implements CollaboratorRepository {


  CollaboratorRepositoryImpl();

  @override
  Future<Collaborator> getCollaboratorById(String id) {
    // TODO: implement getCollaboratorById
    throw UnimplementedError();
  }

  @override
  Future<void> updateCollaborator(Collaborator collaborator) {
    // TODO: implement updateCollaborator
    throw UnimplementedError();
  }

  @override
  Future<void> createCollaborator(Collaborator collaborator) {
    // TODO: implement addCollaborator
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCollaborator(String id) {
    // TODO: implement deleteCollaborator
    throw UnimplementedError();
  }

  @override
  Future<List<Collaborator>> getCollaborators() {
    // TODO: implement getCollaborators
    throw UnimplementedError();
  }

}



// class CollaboratorRepositoryImpl implements CollaboratorRepository {
//   final IsarDataSource dataSource;

//   CollaboratorRepositoryImpl({required this.dataSource});

//   @override
//   Future<Collaborator> getCollaboratorById(String id) async {
//     // Lógica para obtener un colaborador por su ID
//     return dataSource.getCollaboratorById(id);
//   }

//   @override
//   Future<void> updateCollaborator(Collaborator collaborator) async {
//     // Lógica para actualizar un colaborador
//     await dataSource.updateCollaborator(collaborator);
//   }
// }