part of 'collaborator_create_update_cubit.dart';

 class CollaboratorCreateUpdateState extends Equatable {
  final bool loading;
  final bool isEditing;
  final Collaborator? collaborator;
  final String? errorMessage;

  const CollaboratorCreateUpdateState ({
    this.loading = false,
    this.isEditing = false,
    this.collaborator,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [loading, isEditing, collaborator, errorMessage];

  CollaboratorCreateUpdateState  copyWith({
    bool? loading,
    bool? isEditing,
    Collaborator? collaborator,
    String? errorMessage,
  }) {
    return CollaboratorCreateUpdateState (
      loading: loading ?? this.loading,
      isEditing: isEditing ?? this.isEditing,
      collaborator: collaborator ?? this.collaborator,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}