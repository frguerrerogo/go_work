import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_work/domain/core/entities/index.dart' show Collaborator;
import 'package:go_work/domain/core/repositories/index.dart'
    show CollaboratorRepository;

part 'collaborator_home_state.dart';

class CollaboratorHomeCubit extends Cubit<CollaboratorHomeState> {
  final CollaboratorRepository collaboratorRepository;

  CollaboratorHomeCubit(this.collaboratorRepository)
      : super(CollaboratorHomeState());

  Future<void> loadCollaborators() async {
    emit(state.copyWith(loading: true));
    try {
      final collaborators = await collaboratorRepository.getCollaborators();

      emit(state.copyWith(
        loading: false,
        collaborators: collaborators,
        collaboratorsAux: collaborators,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: 'Error: $e',
      ));
    }
  }

  void isSearch() {
    emit(state.copyWith(
      isSearch: !state.isSearch,
    ));
  }

  void searchCollaborators(String searchQuery) {
    List<Collaborator> collaborators;
    if (searchQuery.isEmpty) {
      collaborators = state.collaboratorsAux;
    } else {
      collaborators = state.collaboratorsAux.where((collaborator) {
        final fullName =
            '${collaborator.firstName} ${collaborator.lastName}'.toLowerCase();
        return fullName.contains(searchQuery.toLowerCase());
      }).toList();
    }
    emit(state.copyWith(
      collaborators: collaborators,
    ));
  }
}
