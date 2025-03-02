import 'package:go_work/data/collaborator/adapters/collaborator_adapter.dart';
import 'package:go_work/data/collaborator/datasources/collaborator_datasource.dart';
import 'package:go_work/data/collaborator/repositories/collaborator_repository_impl.dart';
import 'package:go_work/data/core/datasources/local/app_database.dart';
import 'package:go_work/data/core/datasources/local/file_storage_impl.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';
import 'package:go_work/domain/core/datasourse/local/file_storage.dart';

import 'package:kiwi/kiwi.dart';

import 'package:go_work/presentation/core/utils/cubits/index.dart';

part 'dependency_injector.g.dart';

abstract class Injector {
  static final KiwiContainer container = KiwiContainer();

  static void setup() {
    final injector = _$Injector();
    injector._configure();
  }

  // 1. Base de Datos
  @Register.singleton(AppDatabase)
  void _registerDatabase();

  // 2. DataSources
  @Register.singleton(CollaboratorDataSource)
  @Register.singleton(FileStorage, from: FileStorageImpl)
  void _registerDataSources();

  // 3. Adapters
  @Register.singleton(CollaboratorAdapter)
  void _registerAdapters();

  // 4. Repositories
  @Register.singleton(CollaboratorRepository, from: CollaboratorRepositoryImpl)
  void _registerRepositories();

  // 5. Cubits
  @Register.factory(CollaboratorHomeCubit)
  @Register.factory(CollaboratorInformationCubit)
  @Register.factory(CollaboratorCreateUpdateCubit)
  void _registerCubits();

  // Método principal que llama a todos los registros
  void _configure() {
    _registerDatabase();
    _registerDataSources();
    _registerAdapters();
    _registerRepositories();
    _registerCubits();
  }
}
