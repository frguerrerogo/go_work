import 'package:go_work/data/repositories/collaborator_repository_impl.dart';
import 'package:go_work/domain/repositories/collaborator_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'dependency_injector.g.dart';

abstract class Injector  {
  static final KiwiContainer container = KiwiContainer();

 static void setup() {
  final injector = _$Injector();
   injector._configure();
  }

  @Register.singleton(CollaboratorRepository, from: CollaboratorRepositoryImpl)
  void _configure();
}

