import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';

part 'collaborator_home_state.dart';

class CollaboratorHomeCubit extends Cubit<CollaboratorHomeState> {
  final CollaboratorRepository collaboratorRepository;

  CollaboratorHomeCubit(this.collaboratorRepository) : super(CollaboratorHomeState());

  Future<void> loadCollaborators() async {
    final collaboratorList = await collaboratorRepository.getCollaborators();
    emit(state.copyWith(loading: true)); // Activar el estado de carga
    emit(state.copyWith(loading: false)); // Activar el estado de carga
    try {
      //final collaborators = await getCollaboratorsUseCase();
      // Aquí puedes manejar la lista de colaboradores si es necesario
      emit(state.copyWith(loading: false)); // Desactivar el estado de carga
    } catch (e) {
      emit(state.copyWith(loading: false)); // Desactivar el estado de carga en caso de error
      // Puedes manejar el error de otra manera si lo prefieres
    }
  }
}
