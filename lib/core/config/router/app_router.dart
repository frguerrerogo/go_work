import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'screen_builders.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: ScreenBuilders.homeScreenBuilder,
    ),
    GoRoute(
      path: AppRoutes.collaboratorInformation,
      builder: ScreenBuilders.collaboratorInformationBuilder,
    ),
    GoRoute(
      path: AppRoutes.collaboratorCreateUpdate,
      builder: ScreenBuilders.collaboratorCreateUpdateBuilder,
    ),
  ],
  errorBuilder: ScreenBuilders.errorScreenBuilder,
);
