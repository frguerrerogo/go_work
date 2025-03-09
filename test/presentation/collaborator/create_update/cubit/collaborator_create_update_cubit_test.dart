import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';
import 'package:go_work/domain/core/datasourse/local/file_storage.dart';
import 'package:go_work/presentation/collaborator/create_update/cubit/collaborator_create_update_cubit.dart';

class MockFileStorage extends Mock implements FileStorage {}

class MockCollaboratorRepository extends Mock
    implements CollaboratorRepository {}

class FakeCollaborator extends Fake implements Collaborator {}

void main() {
  group('CollaboratorCreateUpdateCubit', () {
    late CollaboratorCreateUpdateCubit cubit;
    late MockFileStorage mockFileStorage;
    late MockCollaboratorRepository mockRepository;

    setUp(
      () {
        registerFallbackValue(FakeCollaborator());
      },
    );

    setUp(() {
      mockFileStorage = MockFileStorage();
      mockRepository = MockCollaboratorRepository();
      cubit = CollaboratorCreateUpdateCubit(mockFileStorage, mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    final collaborator = Collaborator(
      id: 1,
      firstName: 'Fabian',
      lastName: 'Guerrero',
      birthDate: DateTime(1997, 11, 7),
    );

    final imageFile = File('path/to/image.jpg');

    blocTest<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
      'emit [loading, loading] when saveCollaborator is successful',
      build: () => cubit,
      act: (cubit) => cubit.saveCollaborator(
        firstName: 'Fabian',
        lastName: 'Guerrero',
        birthDate: DateTime(1997, 11, 7),
        addresses: [],
      ),
      setUp: () {
        when(() => mockFileStorage.saveImageToStorage(imageFile))
            .thenAnswer((_) async => 'path/to/image.jpg');
        when(() => mockRepository.createCollaborator(any()))
            .thenAnswer((_) async {});
      },
      expect: () => [
        isA<CollaboratorCreateUpdateState>()
            .having((state) => state.loading, 'loading', true),
        isA<CollaboratorCreateUpdateState>()
            .having((state) => state.loading, 'loading', false),
      ],
    );

    blocTest<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
      'emit [loading, (loading, errorMessage)] when saveCollaborator fails',
      build: () => cubit,
      act: (cubit) => cubit.saveCollaborator(
        firstName: 'Fabian',
        lastName: 'Guerrero',
        birthDate: DateTime(1997, 11, 7),
        addresses: [],
      ),
      setUp: () {
        when(() => mockRepository.createCollaborator(any()))
            .thenThrow(Exception('Error saving collaborator'));
      },
      expect: () => [
        isA<CollaboratorCreateUpdateState>()
            .having((state) => state.loading, 'loading', true),
        cubit.state.copyWith(
          loading: false,
          errorMessage: 'Error: Exception: Error saving collaborator',
        ),
      ],
    );

    blocTest<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
      'update state when isEditing is called',
      build: () => cubit,
      act: (cubit) => cubit.isEditing(collaborator),
      expect: () => [
        cubit.state.copyWith(
          collaborator: collaborator,
          isEditing: true,
          image: null,
          birthDate: collaborator.birthDate,
        ),
      ],
    );

    blocTest<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
      'update state when pickImage is called',
      build: () => cubit,
      act: (cubit) => cubit.pickImage(imageFile),
      expect: () => [
        cubit.state.copyWith(image: imageFile),
      ],
    );

    blocTest<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
      'update state when updateBirthDate is called',
      build: () => cubit,
      act: (cubit) => cubit.updateBirthDate(DateTime(1990, 1, 1)),
      expect: () => [
        cubit.state.copyWith(birthDate: DateTime(1990, 1, 1)),
      ],
    );

    blocTest<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
      'call deleteCollaborator without errors',
      build: () => cubit,
      act: (cubit) => cubit.deleteCollaborator(collaborator.id),
      setUp: () {
        when(() =>
                mockRepository.deleteCollaborator(collaborator.id.toString()))
            .thenAnswer((_) async {});
      },
      verify: (_) {
        verify(() =>
                mockRepository.deleteCollaborator(collaborator.id.toString()))
            .called(1);
      },
    );
  });
}
