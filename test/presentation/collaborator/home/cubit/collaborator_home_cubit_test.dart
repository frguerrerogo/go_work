import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';

import 'package:go_work/presentation/core/utils/cubits/index.dart';

class MockCollaboratorRepository extends Mock
    implements CollaboratorRepository {}

void main() {
  group(
    'CollaboratorHomeCubit - loadCollaborators',
    () {
      late CollaboratorHomeCubit cubit;
      late MockCollaboratorRepository mockRepository;

      setUp(() {
        mockRepository = MockCollaboratorRepository();
        cubit = CollaboratorHomeCubit(mockRepository);
      });

      tearDown(() {
        cubit.close();
      });

      final collaborators = [
        Collaborator(
          id: 1,
          firstName: 'Fabian',
          lastName: 'Guerrero',
          birthDate: DateTime(1997, 11, 7),
        ),
      ];

      blocTest<CollaboratorHomeCubit, CollaboratorHomeState>(
        'emit [loading, (loading,collaborators,collaboratorsAux)] when loadCollaborators is successful',
        build: () => cubit,
        act: (cubit) => cubit.loadCollaborators(),
        setUp: () {
          when(
            () => mockRepository.getCollaborators(),
          ).thenAnswer((_) async => collaborators);
        },
        expect: () => [
          isA<CollaboratorHomeState>()
              .having((state) => state.loading, 'loading', true),
          cubit.state.copyWith(
            loading: false,
            collaborators: collaborators,
            collaboratorsAux: collaborators,
          ),
        ],
      );

      blocTest<CollaboratorHomeCubit, CollaboratorHomeState>(
        'emit [loading, (loading, errorMessage)] when loadCollaborators fails',
        build: () => cubit,
        act: (cubit) => cubit.loadCollaborators(),
        setUp: () {
          when(() => mockRepository.getCollaborators())
              .thenThrow(Exception('Error loading collaborators'));
        },
        expect: () => [
          isA<CollaboratorHomeState>()
              .having((state) => state.loading, 'loading', true),
          cubit.state.copyWith(
            loading: false,
            errorMessage: 'Error: Exception: Error loading collaborators',
          ),
        ],
      );
    },
  );

  group('CollaboratorHomeCubit - isSearch', () {
    late CollaboratorHomeCubit cubit;

    setUp(() {
      cubit = CollaboratorHomeCubit(MockCollaboratorRepository());
    });

    tearDown(() {
      cubit.close();
    });

    blocTest<CollaboratorHomeCubit, CollaboratorHomeState>(
      ' toggle isSearch state',
      build: () => cubit,
      act: (cubit) => cubit.isSearch(),
      expect: () => [
        cubit.state.copyWith(isSearch: true),
      ],
    );

    blocTest<CollaboratorHomeCubit, CollaboratorHomeState>(
      'toggle isSearch state back to false',
      build: () => cubit,
      act: (cubit) {
        cubit.isSearch();
        cubit.isSearch();
      },
      expect: () => [
        cubit.state.copyWith(isSearch: true),
        cubit.state.copyWith(isSearch: false),
      ],
    );
  });

  group('CollaboratorHomeCubit - searchCollaborators', () {
    late CollaboratorHomeCubit cubit;

    final collaborators = [
      Collaborator(
        id: 1,
        firstName: 'Fabian',
        lastName: 'Guerrero',
        birthDate: DateTime(1997, 11, 7),
      ),
      Collaborator(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
      ),
    ];

    setUp(() {
      cubit = CollaboratorHomeCubit(MockCollaboratorRepository());
      cubit.emit(cubit.state.copyWith(
        collaboratorsAux: collaborators,
      ));
    });

    tearDown(() {
      cubit.close();
    });

    blocTest<CollaboratorHomeCubit, CollaboratorHomeState>(
      'returns empty if the search query is not in the collaborators parameters',
      build: () => cubit,
      act: (cubit) => cubit.searchCollaborators('pruebas'),
      expect: () => [],
    );

    blocTest<CollaboratorHomeCubit, CollaboratorHomeState>(
      'return all collaborators if search query is empty',
      build: () => cubit,
      act: (cubit) => cubit.searchCollaborators(''),
      expect: () => [
        cubit.state.copyWith(
          collaborators: collaborators,
        ),
      ],
    );
  });
}
