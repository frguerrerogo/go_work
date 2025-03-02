// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _registerDatabase() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => AppDatabase());
  }

  @override
  void _registerDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) =>
        CollaboratorDataSource(databaseHelper: c.resolve<AppDatabase>()));
  }

  @override
  void _registerAdapters() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => CollaboratorAdapter());
  }

  @override
  void _registerRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<CollaboratorRepository>((c) =>
        CollaboratorRepositoryImpl(c.resolve<CollaboratorAdapter>(),
            dataSource: c.resolve<CollaboratorDataSource>()));
  }

  @override
  void _registerCubits() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => CollaboratorHomeCubit())
      ..registerFactory((c) => CollaboratorInformationCubit())
      ..registerFactory((c) => CollaboratorCreateUpdateCubit());
  }
}
