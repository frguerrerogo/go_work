part of 'collaborator_information_cubit.dart';

class CollaboratorInformationState extends Equatable {
  final bool loading;
  final Collaborator? collaborator;
  final String? errorMessage;

  const CollaboratorInformationState({
    this.loading = true,
    this.collaborator,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        loading,
        collaborator,
        errorMessage,
      ];

  CollaboratorInformationState copyWith({
    bool? loading,
    Collaborator? collaborator,
    String? errorMessage,
  }) {
    return CollaboratorInformationState(
      loading: loading ?? this.loading,
      collaborator: collaborator ?? this.collaborator,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
