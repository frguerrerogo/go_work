import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_work/core/config/index.dart' show Injector, AppUtils, AppTextStyles, AppConstants;
import 'package:go_work/presentation/collaborator/utils/cubits/index.dart'
    show CollaboratorInformationCubit, CollaboratorInformationState;

class CollaboratorInformationScreen extends StatelessWidget {
  final int collaboratorId;

  CollaboratorInformationScreen({super.key, required this.collaboratorId});

  final cubit = Injector.container.resolve<CollaboratorInformationCubit>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    cubit.loadCollaboratorInfo(collaboratorId.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Colaborador',
          style: AppTextStyles.titleMedium(context),
        ),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: collaborator.imagePath != null
                            ? Image.file(
                                File(collaborator.imagePath!),
                                width: 400,
                                height: 400,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppConstants.iconDefaultAvatar,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 10),
                      //Full name
                      Text(
                        '${collaborator.firstName} ${collaborator.lastName}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.titleLarge(context),
                      ),
                      SizedBox(height: 10),
                      //BirthDate
                      Text(
                        'Fecha de Nacimiento: ${AppUtils.dateFormat(collaborator.birthDate)}',
                        style: AppTextStyles.bodyText(context),
                      ),
                      SizedBox(height: 10),
                      // Direcciones
                      ExpansionTile(
                        title: Text(
                          'Direcciones',
                          style: AppTextStyles.titleSmall(context),
                        ),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        collapsedBackgroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        children: collaborator.addresses.map((address) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            elevation: 2,
                            child: ListTile(
                              leading: Icon(Icons.location_city, color: colorScheme.onPrimaryContainer, size: 24),
                              title: Text(
                                address,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyText(context),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
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
