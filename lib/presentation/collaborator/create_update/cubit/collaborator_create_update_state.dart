part of 'collaborator_create_update_cubit.dart';

class CollaboratorCreateUpdateState extends Equatable {
  final bool loading;
  final bool isEditing;
  final Collaborator? collaborator;
  final DateTime? birthDate;
  final File? image;
  final String? errorMessage;

  const CollaboratorCreateUpdateState({
    this.loading = false,
    this.isEditing = false,
    this.collaborator,
    this.birthDate,
    this.image,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        loading,
        isEditing,
        collaborator,
        birthDate,
        image,
        errorMessage,
      ];

  CollaboratorCreateUpdateState copyWith({
    bool? loading,
    bool? isEditing,
    Collaborator? collaborator,
    DateTime? birthDate,
    File? image,
    String? errorMessage,
  }) {
    return CollaboratorCreateUpdateState(
      loading: loading ?? this.loading,
      isEditing: isEditing ?? this.isEditing,
      collaborator: collaborator ?? this.collaborator,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
