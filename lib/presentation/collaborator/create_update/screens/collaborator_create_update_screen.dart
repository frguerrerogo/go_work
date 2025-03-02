import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';

import '../../utils/cubits/index.dart';

import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';

class CollaboratorCreateUpdateScreen extends StatelessWidget {
  final Collaborator? collaborator;

  CollaboratorCreateUpdateScreen({super.key, this.collaborator});

  final cubit = Injector.container.resolve<CollaboratorCreateUpdateCubit>();

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: collaborator?.firstName);
    final lastNameController = TextEditingController(text: collaborator?.lastName);

    return Scaffold(
      appBar: AppBar(
        title: Text(collaborator == null ? 'Crear Colaborador' : 'Editar Colaborador'),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
          builder: (context, state) {
            final isEditing = state.isEditing;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Campo para el nombre
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el nombre';
                      }
                      return null;
                    },
                  ),
                  // Campo para el apellido
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Apellido'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el apellido';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16),
                  // Botón para guardar o actualizar
                  ElevatedButton(
                    onPressed: () {
                      // Validar el formulario
                      if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Por favor completa todos los campos')),
                        );
                        return;
                      }

                      // Guardar o actualizar el colaborador
                      cubit.saveCollaborator(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,

                        birthDate:
                            collaborator?.birthDate ?? DateTime.now(), // Usar la fecha actual si no hay una existente
                        addresses: collaborator?.addresses ?? [], // Usar las direcciones existentes o una lista vacía
                      );

                      // Navegar de regreso a la pantalla anterior
                      Navigator.pop(context);
                    },
                    child: Text(isEditing ? 'Actualizar' : 'Crear'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
