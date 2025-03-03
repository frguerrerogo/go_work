import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    super.key,
    this.onTap,
    required this.icon,
    required this.background,
  });

  final Function()? onTap;
  final IconData icon;
  final bool background;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: colorScheme.primaryContainer,
          size: 18,
        ),
      ),
    );
  }
}
