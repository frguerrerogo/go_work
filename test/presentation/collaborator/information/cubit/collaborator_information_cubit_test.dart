import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';
import 'package:go_work/domain/collaborator/repositories/collaborator_repository.dart';
import 'package:go_work/presentation/collaborator/information/cubit/collaborator_information_cubit.dart';

class MockCollaboratorRepository extends Mock
    implements CollaboratorRepository {}

void main() {
  group('CollaboratorInformationCubit - loadCollaboratorInfo', () {
    late CollaboratorInformationCubit cubit;
    late MockCollaboratorRepository mockRepository;

    setUp(() {
      mockRepository = MockCollaboratorRepository();
      cubit = CollaboratorInformationCubit(mockRepository);
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

    blocTest<CollaboratorInformationCubit, CollaboratorInformationState>(
      'emit [loading, (loading, collaborator)] when loadCollaboratorInfo is successful',
      build: () => cubit,
      act: (cubit) => cubit.loadCollaboratorInfo('1'),
      setUp: () {
        when(() => mockRepository.getCollaboratorById('1')).thenAnswer(
          (_) async => collaborator,
        );
      },
      expect: () => [
        isA<CollaboratorInformationState>()
            .having((state) => state.loading, 'loading', true),
        cubit.state.copyWith(
          loading: false,
          collaborator: collaborator,
        ),
      ],
    );

    blocTest<CollaboratorInformationCubit, CollaboratorInformationState>(
      'emit [loading, (loading, errorMessage)] when collaborator is not found',
      build: () => cubit,
      act: (cubit) => cubit.loadCollaboratorInfo('1'),
      setUp: () {
        when(() => mockRepository.getCollaboratorById('1')).thenAnswer(
          (_) async => null,
        );
      },
      expect: () => [
        isA<CollaboratorInformationState>()
            .having((state) => state.loading, 'loading', true),
        cubit.state.copyWith(
          loading: false,
          errorMessage: 'Colaborador no encontrado',
        ),
      ],
    );

    blocTest<CollaboratorInformationCubit, CollaboratorInformationState>(
      'emit [loading, (loading, errorMessage)] when loadCollaboratorInfo fails',
      build: () => cubit,
      act: (cubit) => cubit.loadCollaboratorInfo('1'),
      setUp: () {
        when(() => mockRepository.getCollaboratorById('1')).thenThrow(
          Exception('Error al cargar la información del colaborador'),
        );
      },
      expect: () => [
        isA<CollaboratorInformationState>()
            .having((state) => state.loading, 'loading', true),
        cubit.state.copyWith(
          loading: false,
          errorMessage: 'Error al cargar la información del colaborador',
        ),
      ],
    );
  });
}
