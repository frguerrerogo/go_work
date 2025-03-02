import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';
import 'package:go_work/core/config/router/app_routes.dart';

import '../../utils/screens/index.dart';
import '../../utils/cubits/index.dart';

class CollaboratorHomeScreen extends StatelessWidget {
  CollaboratorHomeScreen({super.key});

  final cubit = Injector.container.resolve<CollaboratorHomeCubit>();

  @override
  Widget build(BuildContext context) {
    cubit.loadCollaborators();
    return Scaffold(
      appBar: AppBar(
        title: Text('Colaboradores'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Lógica de búsqueda
            },
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
              // Aquí puedes mostrar la lista de colaboradores
              return ListView.builder(
                itemCount: 10, // Cambia esto por la lista real de colaboradores
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      ),
                      title: Text('Colaborador $index'),
                      subtitle: Text('Puesto $index'),
                      trailing: Icon(Icons.location_on, color: Colors.blue),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollaboratorInformationScreen(
                              collaboratorId: 1,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppRoutes.collaboratorCreateUpdate);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
