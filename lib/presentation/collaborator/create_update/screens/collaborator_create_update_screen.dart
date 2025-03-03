import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:go_work/core/config/app_utils.dart';
import 'package:go_work/core/config/app_text_styles.dart';
import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';
import 'package:go_work/presentation/core/widgets/widgets.dart';
import 'package:intl/intl.dart';

import '../../utils/cubits/index.dart';

import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';

class CollaboratorCreateUpdateScreen extends StatelessWidget {
  final Collaborator? collaborator;

  CollaboratorCreateUpdateScreen({super.key, this.collaborator});

  final cubit = Injector.container.resolve<CollaboratorCreateUpdateCubit>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final lastNameController = TextEditingController();
    DateTime? birthDate;
    List<String> addresses = [];

    bool checkForm() {
      if (formKey.currentState!.validate()) {
        if (birthDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Por favor selecciona una fecha de cumpleaños')),
          );
          return false;
        }

        if (addresses.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Por favor agrega al menos una dirección')),
          );
          return false;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Formulario enviado con éxito')),
        );
      }
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          collaborator == null ? 'Crear Colaborador' : 'Editar Colaborador',
          style: AppTextStyles.titleMedium(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<CollaboratorCreateUpdateCubit, CollaboratorCreateUpdateState>(
          builder: (context, state) {
            final isEditing = state.isEditing;
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      // Image;
                      if (state.image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            state.image!,
                            width: 200,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ElevatedButtonIconTextCustom(
                        text: 'Seleccionar imagen',
                        icon: Icons.photo_camera_front_rounded,
                        onPressed: () async {
                          File? pickedFile = await AppUtils.pickImage();

                          if (pickedFile != null) {
                            cubit.pickImage(pickedFile);
                          }
                        },
                      ),
                      //Name
                      AnimatedTextFieldCustom(
                        controller: nameController,
                        labelText: 'Nombre',
                        icon: Icons.person,
                      ),

                      //LastName
                      AnimatedTextFieldCustom(
                        controller: lastNameController,
                        labelText: 'Apellido',
                        icon: Icons.person,
                      ),

                      //BirthDate
                      ElevatedButtonIconTextCustom(
                        text: state.birthDate == null
                            ? 'Selecciona tu fecha de cumpleaños'
                            : 'Fecha: ${DateFormat('dd/MM/yyyy').format(state.birthDate!)}',
                        icon: Icons.calendar_month_sharp,
                        onPressed: () async {
                          birthDate = await AppUtils.selectDate(context);
                          cubit.updateBirthDate(birthDate);
                        },
                      ),

                      //addresses
                      AddTextListWidget(
                        title: 'Direcciones',
                        textList: [],
                        buttonText: 'Añadir direccion',
                        hintText: 'Direccion',
                        onChanged: (value) => addresses = value,
                      ),

                      //Button
                      Builder(builder: (context) {
                        return ElevatedButtonCustom(
                          text: isEditing ? 'Actualizar' : 'Crear',
                          onPressed: () async {
                            final check = checkForm();
                            if (check) {
                              await cubit.saveCollaborator(
                                  firstName: nameController.text,
                                  lastName: lastNameController.text,
                                  birthDate: birthDate!,
                                  addresses: addresses);

                              if (context.mounted) GoRouter.of(context).pop(true);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
