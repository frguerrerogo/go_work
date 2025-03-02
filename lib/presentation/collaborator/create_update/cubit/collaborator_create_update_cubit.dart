import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';

part 'collaborator_create_update_state.dart';

class CollaboratorCreateUpdateCubit extends Cubit<CollaboratorCreateUpdateState> {
  CollaboratorCreateUpdateCubit() : super(CollaboratorCreateUpdateState());

  Future<void> saveCollaborator({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required List<String> addresses,
  }) async {
    emit(state.copyWith(loading: true)); // Activar el estado de carga
    try {
      final collaborator = Collaborator(
        id: state.collaborator?.id, // Mantén el ID si está editando
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        addresses: addresses,
      );

      // if (state.isEditing) {
      //   await updateCollaboratorUseCase(collaborator);
      // } else {
      //   await createCollaboratorUseCase(collaborator);
      // }

      emit(state.copyWith(loading: false)); // Desactivar el estado de carga
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: 'Error al guardar el colaborador',
      )); // Error en la operación
    }
  }
}
