import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';

part 'collaborator_information_state.dart';

class CollaboratorInformationCubit extends Cubit<CollaboratorInformationState> {
  CollaboratorInformationCubit() : super(CollaboratorInformationState());

  Future<void> loadCollaboratorInfo(String collaboratorId) async {
    emit(state.copyWith(loading: true)); // Activar el estado de carga
    try {
      //final collaborator = await getCollaboratorInfoUseCase(collaboratorId);
      // if (collaborator != null) {
      //   emit(state.copyWith(loading: false, collaborator: collaborator)); // Datos cargados
      // } else {
      //   emit(state.copyWith(
      //     loading: false,
      //     errorMessage: 'Colaborador no encontrado',
      //   )); // Colaborador no encontrado
      // }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: 'Error al cargar la información del colaborador',
      )); // Error en la carga
    }
  }
}
