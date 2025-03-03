import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle titleLarge(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      letterSpacing: 1.5,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      letterSpacing: 1.2,
    );
  }

  static TextStyle titleSmall(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: colorScheme.primary,
      letterSpacing: 1.0,
    );
  }

  static TextStyle bodyText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: colorScheme.onSurface,
      letterSpacing: 0.5,
    );
  }
}
