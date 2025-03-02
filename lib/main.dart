import 'package:flutter/material.dart';
import 'package:go_work/core/config/router/app_router.dart';
import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';
import 'package:go_work/data/core/datasources/local/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase().database;
  Injector.setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoWork',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      //theme: appTheme.getTheme(),
    );
  }
}
