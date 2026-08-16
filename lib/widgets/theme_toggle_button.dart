import 'package:flutter/material.dart';

/// Expone el cambio de tema a todas las rutas de la aplicación.
class ThemeToggleScope extends InheritedWidget {
  const ThemeToggleScope({
    super.key,
    required this.onThemeChanged,
    required super.child,
  });

  final VoidCallback onThemeChanged;

  static ThemeToggleScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeToggleScope>();

  @override
  bool updateShouldNotify(ThemeToggleScope oldWidget) =>
      onThemeChanged != oldWidget.onThemeChanged;
}

/// Botón común para alternar entre los temas claro y oscuro.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key, this.onThemeChanged});

  final VoidCallback? onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      tooltip: 'Cambiar tema',
      onPressed:
          onThemeChanged ?? ThemeToggleScope.maybeOf(context)?.onThemeChanged,
    );
  }
}
