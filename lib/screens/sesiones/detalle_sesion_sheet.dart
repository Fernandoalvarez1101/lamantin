import 'package:flutter/material.dart';

import '../../models/sesion.dart';
import '../../utils/formato.dart';

/// Hoja inferior con el detalle completo de una sesión guardada.
class DetalleSesionSheet extends StatelessWidget {
  const DetalleSesionSheet({
    super.key,
    required this.sesion,
    this.nombrePaciente,
    this.onEliminar,
  });

  final Sesion sesion;
  final String? nombrePaciente;

  /// Si se provee, se muestra un botón para eliminar la sesión.
  final Future<void> Function()? onEliminar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  sesion.siglaInstrumento,
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(sesion.nombreInstrumento,
                    style: textTheme.bodyMedium, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  formatearFechaHora(sesion.fechaAplicacion),
                  style: textTheme.bodySmall,
                ),
              ),
              if (nombrePaciente != null) ...[
                const SizedBox(height: 12),
                Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Paciente: $nombrePaciente')),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Puntuación total', style: textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${sesion.resultadoTotal}',
                        style: textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (sesion.resultadoEtiqueta.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          sesion.resultadoEtiqueta,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        sesion.resultadoDescripcion,
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              if (sesion.subescalas.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Subescalas', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final subescala in sesion.subescalas)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $subescala', style: textTheme.bodyMedium),
                  ),
              ],
              if (sesion.tieneAlertas) ...[
                const SizedBox(height: 16),
                Card(
                  color: theme.colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atención clínica',
                          style: textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        for (final alerta in sesion.alertas)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              alerta,
                              style: textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
              if (onEliminar != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                    ),
                    onPressed: () async {
                      await onEliminar!();
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Eliminar sesión'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

