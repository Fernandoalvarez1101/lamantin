import 'package:flutter/material.dart';

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';
import '../../services/puntuacion.dart';
import '../../widgets/futuristic_button.dart';
import '../../widgets/theme_toggle_button.dart';
import 'resultado_aplicacion_screen.dart';

/// Pantalla que aplica un instrumento pregunta por pregunta.
///
/// Muestra primero una introducción con las instrucciones y, al comenzar,
/// cada pregunta con su escala de respuesta y una barra de progreso.
class AplicacionInstrumentoScreen extends StatefulWidget {
  const AplicacionInstrumentoScreen({
    super.key,
    required this.instrumento,
    this.idPaciente,
    this.nombrePaciente,
  });

  final InstrumentoAplicable instrumento;

  /// Id del paciente desde el que se inició la aplicación (opcional).
  final String? idPaciente;

  /// Nombre del paciente, para mostrarlo al guardar el resultado.
  final String? nombrePaciente;

  @override
  State<AplicacionInstrumentoScreen> createState() =>
      _AplicacionInstrumentoScreenState();
}

class _AplicacionInstrumentoScreenState
    extends State<AplicacionInstrumentoScreen> {
  bool _mostrandoIntro = true;
  int _indicePregunta = 0;
  late final List<int?> _respuestas;

  InstrumentoAplicable get _instrumento => widget.instrumento;

  bool get _esUltimaPregunta =>
      _indicePregunta == _instrumento.totalPreguntas - 1;

  @override
  void initState() {
    super.initState();
    _respuestas = List<int?>.filled(_instrumento.totalPreguntas, null);
  }

  void _comenzar() => setState(() => _mostrandoIntro = false);

  void _seleccionar(int valor) {
    setState(() => _respuestas[_indicePregunta] = valor);
  }

  void _anterior() => setState(() => _indicePregunta--);

  void _siguiente() => setState(() => _indicePregunta++);

  Future<void> _finalizar() async {
    final cantidadPuntuables = _instrumento.preguntas.length;
    final valores = _respuestas.sublist(0, cantidadPuntuables).cast<int>();
    final respuestasComplementarias =
        _respuestas.sublist(cantidadPuntuables).cast<int>();
    final resultado = puntuarInstrumento(_instrumento, valores);

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ResultadoAplicacionScreen(
          instrumento: _instrumento,
          resultado: resultado,
          preguntasComplementarias: _instrumento.preguntasComplementarias,
          respuestasComplementarias: respuestasComplementarias,
          respuestas: valores,
          idPaciente: widget.idPaciente,
          nombrePaciente: widget.nombrePaciente,
        ),
      ),
    );

    // Al regresar del resultado, se reinicia la aplicación.
    if (mounted) {
      setState(() {
        _mostrandoIntro = true;
        _indicePregunta = 0;
        _respuestas.setAll(
          0,
          List<int?>.filled(_respuestas.length, null),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_instrumento.sigla),
        actions: const [ThemeToggleButton()],
      ),
      body: _mostrandoIntro
          ? _construirIntro(context)
          : _construirPregunta(context),
    );
  }

  Widget _construirIntro(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            child: const Icon(Icons.assignment_outlined, size: 32),
          ),
          const SizedBox(height: 16),
          Text(_instrumento.titulo, style: textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(
            _instrumento.instrucciones,
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              Chip(
                avatar: const Icon(Icons.list_alt, size: 18),
                label: Text('${_instrumento.totalPreguntas} preguntas'),
              ),
              const Chip(
                avatar: Icon(Icons.info_outline, size: 18),
                label: Text('Cribado, no diagnóstico'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FuturisticButton(
            label: 'Comenzar',
            icon: Icons.play_arrow,
            onTap: _comenzar,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _construirPregunta(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final preguntas = [
      ..._instrumento.preguntas,
      ..._instrumento.preguntasComplementarias,
    ];
    final pregunta = preguntas[_indicePregunta];
    final esComplementaria = _indicePregunta >= _instrumento.preguntas.length;
    final seleccion = _respuestas[_indicePregunta];
    final progreso = (_indicePregunta + 1) / _instrumento.totalPreguntas;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pregunta ${_indicePregunta + 1} de ${preguntas.length}',
                style: textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.primary),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progreso,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (esComplementaria) ...[
                  const Chip(
                    avatar: Icon(Icons.fact_check_outlined, size: 18),
                    label: Text('Información clínica adicional (no se puntúa)'),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(pregunta.texto, style: textTheme.titleLarge),
                const SizedBox(height: 20),
                for (final opcion in pregunta.opciones)
                  _OpcionTarjeta(
                    opcion: opcion,
                    seleccionada: seleccion == opcion.valor,
                    onTap: () => _seleccionar(opcion.valor),
                  ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _indicePregunta == 0 ? null : _anterior,
                    child: const Text('Anterior'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: seleccion == null
                        ? null
                        : (_esUltimaPregunta ? _finalizar : _siguiente),
                    child: Text(
                      _esUltimaPregunta ? 'Ver resultados' : 'Siguiente',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Tarjeta seleccionable de una opción de respuesta.
class _OpcionTarjeta extends StatelessWidget {
  const _OpcionTarjeta({
    required this.opcion,
    required this.seleccionada,
    required this.onTap,
  });

  final OpcionRespuesta opcion;
  final bool seleccionada;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color:
            seleccionada ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: seleccionada
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
                width: seleccionada ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  seleccionada
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: seleccionada
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    opcion.etiqueta,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
