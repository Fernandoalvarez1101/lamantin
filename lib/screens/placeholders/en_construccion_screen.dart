import 'package:flutter/material.dart';

import '../../widgets/theme_toggle_button.dart';

/// Pantalla temporal que se muestra mientras una sección aún no está
/// implementada. Se reemplazará por la pantalla real de cada módulo.
class EnConstruccionScreen extends StatelessWidget {
  const EnConstruccionScreen({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.icono,
  });

  /// Nombre del módulo (aparece en el AppBar y en el cuerpo).
  final String titulo;

  /// Breve descripción de lo que ofrecerá la sección.
  final String descripcion;

  /// Icono representativo del módulo.
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        actions: const [ThemeToggleButton()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icono,
                size: 96,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(titulo, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                descripcion,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const Chip(
                avatar: Icon(Icons.construction, size: 18),
                label: Text('Sección en construcción'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
