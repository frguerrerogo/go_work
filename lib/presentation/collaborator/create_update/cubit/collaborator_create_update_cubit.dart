import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_work/domain/core/datasourse/index.dart' show FileStorage;
import 'package:go_work/domain/core/entities/index.dart' show Collaborator;
import 'package:go_work/domain/core/repositories/index.dart'
    show CollaboratorRepository;

part 'collaborator_create_update_state.dart';

class CollaboratorCreateUpdateCubit
    extends Cubit<CollaboratorCreateUpdateState> {
  final FileStorage fileStorage;
  final CollaboratorRepository collaboratorRepository;
  CollaboratorCreateUpdateCubit(this.fileStorage, this.collaboratorRepository)
      : super(CollaboratorCreateUpdateState());

  Future<void> saveCollaborator({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required List<String> addresses,
  }) async {
    emit(state.copyWith(loading: true));

    String? imagePath;
    if (state.image != null) {
      imagePath = await fileStorage.saveImageToStorage(state.image!);
    }

    try {
      final collaborator = Collaborator(
        id: state.collaborator?.id,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        imagePath: imagePath,
        addresses: addresses,
      );

      if (state.isEditing) {
        await collaboratorRepository.updateCollaborator(collaborator);
      } else {
        await collaboratorRepository.createCollaborator(collaborator);
      }

      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: 'Error: $e',
      ));
    }
  }

  void isEditing(Collaborator collaborator) {
    emit(state.copyWith(
      collaborator: collaborator,
      isEditing: true,
      image:
          collaborator.imagePath != null ? File(collaborator.imagePath!) : null,
      birthDate: collaborator.birthDate,
    ));
  }

  void pickImage(File image) async {
    emit(state.copyWith(image: image));
  }

  void updateBirthDate(DateTime? birthDate) async {
    emit(state.copyWith(birthDate: birthDate));
  }

  Future<void> deleteCollaborator(int? id) async {
    await collaboratorRepository.deleteCollaborator(id.toString());
  }
}
