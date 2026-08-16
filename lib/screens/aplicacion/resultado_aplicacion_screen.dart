import 'package:flutter/material.dart';

import '../../models/instrumento_aplicable.dart';
import '../../models/paciente.dart';
import '../../models/pregunta.dart';
import '../../models/resultado_aplicacion.dart';
import '../../repositories/almacen.dart';
import '../../services/guardar_resultado.dart';
import '../../widgets/futuristic_button.dart';
import '../../widgets/theme_toggle_button.dart';
import '../pacientes/formulario_paciente_screen.dart';
import '../pacientes/seleccionar_paciente_sheet.dart';

/// Pantalla de resultados de la aplicación de un instrumento.
///
/// Muestra la puntuación total, la banda de severidad, las alertas
/// clínicas activadas, la información complementaria (p. ej. deterioro
/// funcional) y la nota sobre el alcance del instrumento.
class ResultadoAplicacionScreen extends StatelessWidget {
  const ResultadoAplicacionScreen({
    super.key,
    required this.instrumento,
    required this.resultado,
    this.preguntasComplementarias = const [],
    this.respuestasComplementarias = const [],
    this.respuestas = const [],
    this.idPaciente,
    this.nombrePaciente,
  });

  final InstrumentoAplicable instrumento;
  final ResultadoAplicacion resultado;

  /// Preguntas complementarias aplicadas (no puntuadas).
  final List<Pregunta> preguntasComplementarias;

  /// Respuestas a las preguntas complementarias, en el mismo orden.
  final List<int> respuestasComplementarias;

  /// Valores de respuesta a las preguntas puntuables, en orden.
  final List<int> respuestas;

  /// Id del paciente desde el que se inició la aplicación (opcional).
  final String? idPaciente;

  /// Nombre del paciente, para mostrarlo al guardar el resultado.
  final String? nombrePaciente;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = _colorNivel(resultado.rango.nivel);
    final cantidadPuntuable =
        instrumento.preguntas.where((p) => p.puntuable).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        actions: const [ThemeToggleButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (instrumento.mostrarPuntuacionTotal)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text('Puntuación total', style: textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        '${resultado.total}',
                        style: textTheme.displayLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (resultado.rango.descriptiva) ...[
                        Text(
                          'Rango: ${resultado.rango.minimo}–'
                          '${resultado.rango.maximo}',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Media por ítem: '
                          '${(resultado.total / cantidadPuntuable).toStringAsFixed(2)}',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ] else ...[
                        Chip(
                          backgroundColor: color.withValues(alpha: 0.15),
                          label: Text(
                            resultado.rango.etiqueta,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          resultado.rango.descripcion,
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            if (resultado.subescalas.isNotEmpty) ...[
              if (instrumento.mostrarPuntuacionTotal) ...[
                const SizedBox(height: 12),
              ],
              Text(
                'Puntuaciones',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              for (final subescala in resultado.subescalas) ...[
                _TarjetaSubescala(subescala: subescala),
                const SizedBox(height: 12),
              ],
            ],
            if (resultado.tieneAlertas) ...[
              const SizedBox(height: 16),
              Card(
                color: theme.colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Atención clínica',
                            style: textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      for (final alerta in resultado.alertasActivadas)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            alerta,
                            style: textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
            if (preguntasComplementarias.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                color: theme.colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.fact_check_outlined,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Información clínica adicional',
                            style: textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (var i = 0;
                          i < preguntasComplementarias.length;
                          i++) ...[
                        Text(
                          preguntasComplementarias[i].texto,
                          style: textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _etiquetaRespuesta(
                            preguntasComplementarias[i],
                            respuestasComplementarias[i],
                          ),
                          style: textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        if (i < preguntasComplementarias.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        instrumento.nota,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FuturisticButton(
              label: idPaciente != null && nombrePaciente != null
                  ? 'Guardar en $nombrePaciente'
                  : 'Guardar en un paciente…',
              icon: Icons.person_add_alt,
              onTap: () => _guardarEnPaciente(context),
              fullWidth: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Aplicar de nuevo'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    child: const Text('Volver a instrumentos'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarEnPaciente(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    var idDestino = idPaciente;
    var nombreDestino = nombrePaciente;

    if (idDestino == null) {
      final seleccion = await showModalBottomSheet<String>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => const SeleccionarPacienteSheet(),
      );
      if (seleccion == null || !context.mounted) return;

      if (seleccion == SeleccionarPacienteSheet.nuevoPaciente) {
        final creado = await navigator.push<Paciente>(
          MaterialPageRoute<Paciente>(
            builder: (_) => const FormularioPacienteScreen(),
          ),
        );
        if (creado == null || !context.mounted) return;
        idDestino = creado.id;
        nombreDestino = creado.nombreCompleto;
      } else {
        idDestino = seleccion;
        final paciente = await AppRepositorios.paciente.obtenerPorId(seleccion);
        nombreDestino = paciente?.nombreCompleto;
      }
    }

    await guardarResultadoEnPaciente(
      instrumento: instrumento,
      resultado: resultado,
      respuestas: respuestas,
      idPaciente: idDestino,
    );

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          'Resultado guardado en ${nombreDestino ?? 'el paciente'}',
        ),
      ),
    );
  }

  String _etiquetaRespuesta(Pregunta pregunta, int valor) {
    for (final opcion in pregunta.opciones) {
      if (opcion.valor == valor) return opcion.etiqueta;
    }
    return '$valor';
  }

  Color _colorNivel(int nivel) {
    switch (nivel) {
      case 1:
        return Colors.green.shade700;
      case 2:
        return Colors.orange.shade800;
      case 3:
        return Colors.deepOrange;
      case 4:
        return Colors.red.shade700;
      default:
        return Colors.blueGrey;
    }
  }
}

/// Tarjeta con la puntuación de una subescala del instrumento.
class _TarjetaSubescala extends StatelessWidget {
  const _TarjetaSubescala({required this.subescala});

  final Subpuntuacion subescala;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = _colorNivel(subescala.rango.nivel);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              subescala.nombre,
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${subescala.total}',
              style: textTheme.displayMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (subescala.rango.descriptiva) ...[
              Text(
                'Rango: ${subescala.rango.minimo}–${subescala.rango.maximo}',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Media por ítem: '
                '${(subescala.total / subescala.cantidadItems).toStringAsFixed(2)}',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Chip(
                backgroundColor: color.withValues(alpha: 0.15),
                label: Text(
                  subescala.rango.etiqueta,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subescala.rango.descripcion,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (subescala.descripcion != null) ...[
              const SizedBox(height: 8),
              Text(
                subescala.descripcion!,
                style: textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Color _colorNivel(int nivel) {
  switch (nivel) {
    case 1:
      return Colors.green.shade700;
    case 2:
      return Colors.orange.shade800;
    case 3:
      return Colors.deepOrange;
    case 4:
      return Colors.red.shade700;
    default:
      return Colors.blueGrey;
  }
}
