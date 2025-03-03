import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_work/core/config/app_constants.dart';
import 'package:go_work/core/config/app_text_styles.dart';

import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';
import 'package:go_work/core/config/router/app_routes.dart';

import '../../../core/widgets/widgets.dart';
import '../../utils/screens/index.dart';
import '../../utils/cubits/index.dart';

class CollaboratorHomeScreen extends StatelessWidget {
  CollaboratorHomeScreen({super.key});

  final cubit = Injector.container.resolve<CollaboratorHomeCubit>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchController = TextEditingController();

    cubit.loadCollaborators();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GoWork',
          style: AppTextStyles.titleLarge(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: colorScheme.primary,
              size: 30,
            ),
            onPressed: () => cubit.isSearch(),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<CollaboratorHomeCubit, CollaboratorHomeState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //Search
                    if (state.isSearch)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        height: state.isSearch ? 71.0 : 0.0,
                        child: AnimatedTextFieldCustom(
                          controller: searchController,
                          icon: Icons.search,
                          labelText: 'Buscar',
                          onChanged: (value) {
                            cubit.searchCollaborators(value);
                          },
                        ),
                      ),
                    // Lista de colaboradores
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.collaborators.length,
                      itemBuilder: (context, index) {
                        final collaborator = state.collaborators[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: collaborator.imagePath != null
                                  ? FileImage(File(collaborator.imagePath!)) as ImageProvider
                                  : AssetImage(AppConstants.iconDefaultAvatar) as ImageProvider,
                            ),
                            title: Text(
                              collaborator.firstName,
                              style: AppTextStyles.titleSmall(context),
                            ),
                            subtitle: Text(
                              collaborator.lastName,
                              style: AppTextStyles.bodyText(context),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CollaboratorInformationScreen(collaboratorId: collaborator.id!),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await GoRouter.of(context).push(AppRoutes.collaboratorCreateUpdate);

          if (result == true) {
            cubit.loadCollaborators();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
