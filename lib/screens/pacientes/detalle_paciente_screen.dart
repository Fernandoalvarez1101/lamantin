import 'package:flutter/material.dart';

import '../../data/aplicaciones/registro_aplicaciones.dart';
import '../../models/instrumento_aplicable.dart';
import '../../models/paciente.dart';
import '../../models/sesion.dart';
import '../../repositories/almacen.dart';
import '../../utils/formato.dart';
import '../../widgets/futuristic_button.dart';
import '../../widgets/theme_toggle_button.dart';
import '../aplicacion/aplicacion_instrumento_screen.dart';
import '../resultados/informe_paciente_screen.dart';
import '../sesiones/detalle_sesion_sheet.dart';
import 'formulario_paciente_screen.dart';

/// Detalle de un paciente: datos personales e historial de sesiones.
class DetallePacienteScreen extends StatefulWidget {
  const DetallePacienteScreen({super.key, required this.paciente});

  final Paciente paciente;

  @override
  State<DetallePacienteScreen> createState() => _DetallePacienteScreenState();
}

class _DetallePacienteScreenState extends State<DetallePacienteScreen> {
  late Future<List<Sesion>> _futuroSesiones;

  @override
  void initState() {
    super.initState();
    _futuroSesiones = _cargarSesiones();
  }

  Future<List<Sesion>> _cargarSesiones() =>
      AppRepositorios.sesion.obtenerPorPaciente(widget.paciente.id);

  void _recargarSesiones() {
    setState(() {
      _futuroSesiones = _cargarSesiones();
    });
  }

  Future<void> _editarPaciente() async {
    final editado = await Navigator.of(context).push<Paciente>(
      MaterialPageRoute<Paciente>(
        builder: (_) => FormularioPacienteScreen(paciente: widget.paciente),
      ),
    );
    if (editado != null && mounted) {
      Navigator.of(context).pop(editado);
    }
  }

  Future<void> _eliminarPaciente() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar paciente'),
        content: Text(
          'Se eliminará a ${widget.paciente.nombreCompleto} junto con '
          'todas sus sesiones guardadas. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmado != true || !mounted) return;

    final sesiones =
        await AppRepositorios.sesion.obtenerPorPaciente(widget.paciente.id);
    for (final sesion in sesiones) {
      await AppRepositorios.sesion.eliminar(sesion.id);
    }
    await AppRepositorios.paciente.eliminar(widget.paciente.id);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _aplicarInstrumento() async {
    final instrumento = await showModalBottomSheet<InstrumentoAplicable>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => const _SelectorInstrumento(),
    );
    if (instrumento == null || !mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AplicacionInstrumentoScreen(
          instrumento: instrumento,
          idPaciente: widget.paciente.id,
          nombrePaciente: widget.paciente.nombreCompleto,
        ),
      ),
    );
    _recargarSesiones();
  }

  void _verInforme() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => InformePacienteScreen(paciente: widget.paciente),
      ),
    );
  }

  Future<void> _verSesion(Sesion sesion) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => DetalleSesionSheet(
        sesion: sesion,
        nombrePaciente: widget.paciente.nombreCompleto,
        onEliminar: () async {
          await AppRepositorios.sesion.eliminar(sesion.id);
          if (mounted) Navigator.of(context).pop();
        },
      ),
    );
    _recargarSesiones();
  }

  String _datosDemograficos() {
    final p = widget.paciente;
    final partes = <String>[
      if (p.edad != null) '${p.edad} años',
      if (p.sexo != null) p.sexo!,
    ];
    final demograficos = partes.join(' · ');
    final alta = 'Alta: ${formatearFecha(p.fechaRegistro)}';
    return demograficos.isEmpty ? alta : '$demograficos\n$alta';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final p = widget.paciente;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.nombreCompleto),
        actions: [
          IconButton(
            icon: const Icon(Icons.assessment_outlined),
            tooltip: 'Ver informe',
            onPressed: _verInforme,
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar paciente',
            onPressed: _editarPaciente,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Eliminar paciente',
            onPressed: _eliminarPaciente,
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        child: Text(
                          inicialesDe(p.nombre, p.apellido),
                          style: textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _datosDemograficos(),
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  if (p.notas != null) ...[
                    const SizedBox(height: 12),
                    const Divider(),
                    Text('Notas', style: textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(p.notas!, style: textTheme.bodyMedium),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Historial de sesiones',
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              FuturisticButton(
                label: 'Aplicar',
                icon: Icons.add_chart,
                onTap: _aplicarInstrumento,
              ),
            ],
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<Sesion>>(
            future: _futuroSesiones,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final sesiones = snapshot.data ?? const <Sesion>[];
              if (sesiones.isEmpty) {
                return Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(Icons.history, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          'Sin sesiones todavía.',
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Aplica un instrumento y guarda el resultado para '
                          'que aparezca aquí.',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  for (final sesion in sesiones)
                    Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        onTap: () => _verSesion(sesion),
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          foregroundColor:
                              theme.colorScheme.onSecondaryContainer,
                          child: Text(
                            sesion.siglaInstrumento,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(sesion.nombreInstrumento),
                        subtitle: Text(
                          '${formatearFechaHora(sesion.fechaAplicacion)}'
                          '${sesion.resultadoEtiqueta.isNotEmpty ? ' · ${sesion.resultadoEtiqueta}' : ''}',
                        ),
                        trailing: Text(
                          '${sesion.resultadoTotal}',
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Hoja inferior con los instrumentos aplicables disponibles.
class _SelectorInstrumento extends StatelessWidget {
  const _SelectorInstrumento();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final instrumentos = aplicacionesDisponibles.values.toList()
      ..sort((a, b) => a.sigla.compareTo(b.sigla));

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Text(
              'Elegir instrumento',
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: instrumentos.length,
              itemBuilder: (context, index) {
                final instrumento = instrumentos[index];
                return ListTile(
                  leading: const Icon(Icons.assignment_outlined),
                  title: Text(instrumento.sigla),
                  subtitle: Text(
                    instrumento.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => Navigator.of(context).pop(instrumento),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
