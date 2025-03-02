part of 'collaborator_home_cubit.dart';

 class CollaboratorHomeState extends Equatable {
  final bool loading;

  const CollaboratorHomeState( {this.loading  = true,});

  @override
  List<Object> get props => [loading,];

  CollaboratorHomeState copyWith({
      bool? loading,
  }) {
    return CollaboratorHomeState(
      loading: loading ?? this.loading,
    );
  }
}


