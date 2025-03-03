part of 'collaborator_home_cubit.dart';

class CollaboratorHomeState extends Equatable {
  final bool loading;
  final bool isSearch;
  final List<Collaborator> collaborators;
  final List<Collaborator> collaboratorsAux;
  final String? errorMessage;

  const CollaboratorHomeState({
    this.loading = true,
    this.isSearch = false,
    this.collaborators = const [],
    this.collaboratorsAux = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        loading,
        isSearch,
        collaborators,
        collaboratorsAux,
        errorMessage,
      ];

  CollaboratorHomeState copyWith({
    bool? loading,
    bool? isSearch,
    List<Collaborator>? collaborators,
    List<Collaborator>? collaboratorsAux,
    String? errorMessage,
  }) {
    return CollaboratorHomeState(
      loading: loading ?? this.loading,
      isSearch: isSearch ?? this.isSearch,
      collaborators: collaborators ?? this.collaborators,
      collaboratorsAux: collaboratorsAux ?? this.collaboratorsAux,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
