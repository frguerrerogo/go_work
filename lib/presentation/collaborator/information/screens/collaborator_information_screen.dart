import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';

import '../../utils/cubits/index.dart';

class CollaboratorInformationScreen extends StatelessWidget {
  final int collaboratorId;

  CollaboratorInformationScreen({super.key, required this.collaboratorId});

  final cubit = Injector.container.resolve<CollaboratorInformationCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del Colaborador'),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<CollaboratorInformationCubit, CollaboratorInformationState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.collaborator != null) {
              final collaborator = state.collaborator!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre: ${collaborator.firstName} ${collaborator.lastName}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Fecha de Nacimiento: ${collaborator.birthDate.toLocal()}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 16),
                    Text('Ubicaciones:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ...collaborator.addresses.map((address) {
                      return ListTile(
                        leading: Icon(Icons.location_on, color: Colors.blue),
                        title: Text(address),
                      );
                    }).toList(),
                  ],
                ),
              );
            } else if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
