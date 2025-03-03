import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';

part 'collaborator_information_state.dart';

class CollaboratorInformationCubit extends Cubit<CollaboratorInformationState> {
  final CollaboratorRepository collaboratorRepository;
  CollaboratorInformationCubit(this.collaboratorRepository) : super(CollaboratorInformationState());

  Future<void> loadCollaboratorInfo(String collaboratorId) async {
    emit(state.copyWith(loading: true));
    try {
      final collaborator = await collaboratorRepository.getCollaboratorById(collaboratorId);
      if (collaborator != null) {
        emit(state.copyWith(
          loading: false,
          collaborator: collaborator,
        ));
      } else {
        emit(state.copyWith(
          loading: false,
          errorMessage: 'Colaborador no encontrado',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: 'Error al cargar la información del colaborador',
      ));
    }
  }
}
