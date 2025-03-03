import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:go_work/core/config/index.dart';

import '../../../core/widgets/index.dart';
import '../../utils/cubits/index.dart';

class CollaboratorHomeScreen extends StatefulWidget {
  const CollaboratorHomeScreen({super.key});

  @override
  State<CollaboratorHomeScreen> createState() => _CollaboratorHomeScreenState();
}

class _CollaboratorHomeScreenState extends State<CollaboratorHomeScreen> {
  final cubit = Injector.container.resolve<CollaboratorHomeCubit>();

  @override
  void initState() {
    super.initState();
    cubit.loadCollaborators();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchController = TextEditingController();

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
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: collaborator.imagePath !=
                                            null
                                        ? FileImage(
                                                File(collaborator.imagePath!))
                                            as ImageProvider
                                        : AssetImage(
                                                AppConstants.iconDefaultAvatar)
                                            as ImageProvider,
                                  ),
                                  title: Text(
                                    collaborator.firstName,
                                    style: AppTextStyles.titleSmall(context),
                                  ),
                                  subtitle: Text(
                                    collaborator.lastName,
                                    style: AppTextStyles.bodyText(context),
                                  ),
                                  onTap: () => GoRouter.of(context).push(
                                    AppRoutes.collaboratorInformation
                                        .replaceAll(
                                      ':collaboratorId',
                                      collaborator.id.toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 10),
                                  IconButtonCustom(
                                    onTap: () => GoRouter.of(context)
                                        .push(
                                          AppRoutes.collaboratorCreateUpdate,
                                          extra: collaborator,
                                        )
                                        .then((value) =>
                                            cubit.loadCollaborators()),
                                    icon: Icons.edit,
                                    background: false,
                                  ),
                                ],
                              ),
                            ],
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
          GoRouter.of(context)
              .push(AppRoutes.collaboratorCreateUpdate)
              .then((value) => cubit.loadCollaborators());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
