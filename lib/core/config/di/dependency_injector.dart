import 'package:kiwi/kiwi.dart';

// Base de Datos
import 'package:go_work/data/core/datasources/local/sqflite/app_database.dart';

// DataSources
import 'package:go_work/data/core/datasources/index.dart';
import 'package:go_work/domain/core/datasourse/index.dart';

// Adapters
import 'package:go_work/data/core/adapter/index.dart';

// Repositories
import 'package:go_work/data/core/repositories/index.dart';
import 'package:go_work/domain/core/repositories/index.dart';

// Cubits
import 'package:go_work/presentation/core/utils/cubits/index.dart';

part 'dependency_injector.g.dart';

abstract class Injector {
  static final KiwiContainer container = KiwiContainer();

  static void setup() {
    final injector = _$Injector();
    injector._configure();
  }

  // Base de Datos
  @Register.singleton(AppDatabase)
  void _registerDatabase();

  //  DataSources
  @Register.singleton(CollaboratorDataSource, from: CollaboratorDataSourceImpl)
  @Register.singleton(FileStorage, from: FileStorageImpl)
  void _registerDataSources();

  // Adapters
  @Register.singleton(CollaboratorAdapter)
  void _registerAdapters();

  // Repositories
  @Register.singleton(CollaboratorRepository, from: CollaboratorRepositoryImpl)
  void _registerRepositories();

  // Cubits
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
