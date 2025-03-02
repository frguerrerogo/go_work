import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_work/core/config/app_theme.dart';
import 'package:go_work/core/config/router/app_router.dart';
import 'package:go_work/core/config/dependency_injector/dependency_injector.dart';
import 'package:go_work/data/core/datasources/local/app_database.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null); // Inicializa los datos de localización
  Intl.defaultLocale = 'es_ES'; // Establece el idioma predeterminado
  await AppDatabase().database;
  Injector.setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();
    return MaterialApp.router(
      title: 'GoWork',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      locale: Locale('es', 'ES'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', 'ES'), // Español
        Locale('en', 'US'), // Inglés (como respaldo)
      ],
    );
  }
}
