import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';
import 'package:go_work/domain/core/datasourse/local/file_storage.dart';

part 'collaborator_create_update_state.dart';

class CollaboratorCreateUpdateCubit extends Cubit<CollaboratorCreateUpdateState> {
  final FileStorage fileStorage;
  final CollaboratorRepository collaboratorRepository;
  CollaboratorCreateUpdateCubit(this.fileStorage, this.collaboratorRepository) : super(CollaboratorCreateUpdateState());

  Future<void> saveCollaborator({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required List<String> addresses,
  }) async {
    emit(state.copyWith(loading: true));

    String? imagePath;
    if (state.image != null) imagePath = await fileStorage.saveImageToStorage(state.image!);

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
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: 'Error: $e',
      ));
    }
  }

  Future<void> pickImage(File image) async {
    emit(state.copyWith(image: image));
  }

  Future<void> updateBirthDate(DateTime? birthDate) async {
    emit(state.copyWith(birthDate: birthDate));
  }
}
