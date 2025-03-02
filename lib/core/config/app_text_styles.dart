import 'package:flutter/material.dart';

class AppTextStyles {
  // Estilo para títulos medianos
  static TextStyle titleMedium(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      letterSpacing: 1.2,
    );
  }

  // // Estilo para títulos grandes
  // static TextStyle titleLarge(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 32,
  //     fontWeight: FontWeight.bold,
  //     color: colorScheme.primary, // Usa el color primario del tema
  //     letterSpacing: 1.5,
  //   );
  // }

  // // Estilo para títulos medianos
  // static TextStyle titleMedium(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 20,
  //     fontWeight: FontWeight.bold,
  //     color: colorScheme.primary,
  //     letterSpacing: 1.2,
  //   );
  // }

  // Estilo para títulos pequeños
  // static TextStyle titleSmall(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 18,
  //     fontWeight: FontWeight.w500,
  //     color: colorScheme.primary, // Usa el color primario del tema
  //     letterSpacing: 1.0,
  //   );
  // }

  // // Estilo para texto normal
  // static TextStyle bodyText(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.normal,
  //     color: colorScheme.onSurface, // Usa el color de texto sobre el fondo
  //     letterSpacing: 0.5,
  //   );
  // }

  // // Estilo para texto en negrita
  // static TextStyle bodyTextBold(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //     color: colorScheme.onSurface, // Usa el color de texto sobre el fondo
  //     letterSpacing: 0.5,
  //   );
  // }

  // // Estilo para texto en cursiva
  // static TextStyle bodyTextItalic(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.normal,
  //     fontStyle: FontStyle.italic,
  //     color: colorScheme.onSurface, // Usa el color de texto sobre el fondo
  //     letterSpacing: 0.5,
  //   );
  // }

  // // Estilo para texto de error
  // static TextStyle errorText(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.normal,
  //     color: colorScheme.error, // Usa el color de error del tema
  //     letterSpacing: 0.5,
  //   );
  // }

  // // Estilo para texto de éxito
  // static TextStyle successText(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.normal,
  //     color: colorScheme.tertiary, // Usa el color terciario del tema
  //     letterSpacing: 0.5,
  //   );
  // }
}
