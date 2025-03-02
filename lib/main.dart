import 'package:flutter/material.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
