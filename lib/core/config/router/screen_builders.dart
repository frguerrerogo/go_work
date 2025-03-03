import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importa tus pantallas aquí
import 'package:go_work/presentation/core/utils/screens/index.dart';

// Importa tus utilidades aquí
import 'package:go_work/core/config/app_utils.dart';

// Importa tu entidades de Collaborator aquí
import 'package:go_work/domain/collaborator/entities/collaborator_entity.dart';

class ScreenBuilders {
  static Widget homeScreenBuilder(BuildContext context, GoRouterState state) {
    return CollaboratorHomeScreen();
  }

  static Widget collaboratorInformationBuilder(
      BuildContext context, GoRouterState state) {
    final collaboratorId =
        AppUtils.validateInt(state.pathParameters['collaboratorId']);
    if (collaboratorId == null) {
      return const ErrorScreen(message: 'ID de colaborador inválido');
    }
    return CollaboratorInformationScreen(collaboratorId: collaboratorId);
  }

  static Widget collaboratorCreateUpdateBuilder(
      BuildContext context, GoRouterState state) {
    final collaborator =
        state.extra is Collaborator ? state.extra as Collaborator : null;
    return CollaboratorCreateUpdateScreen(collaborator: collaborator);
  }

  static Widget errorScreenBuilder(BuildContext context, GoRouterState state) {
    return ErrorScreen(message: 'Ruta no encontrada: ${state.uri.path}');
  }
}
