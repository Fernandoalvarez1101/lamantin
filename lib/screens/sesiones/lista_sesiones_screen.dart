import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import '../../models/sesion.dart';
import '../../repositories/almacen.dart';
import '../../utils/formato.dart';
import '../../widgets/theme_toggle_button.dart';
import 'detalle_sesion_sheet.dart';

/// Historial global de sesiones (aplicaciones de instrumentos).
class ListaSesionesScreen extends StatefulWidget {
  const ListaSesionesScreen({super.key});

  @override
  State<ListaSesionesScreen> createState() => _ListaSesionesScreenState();
}

/// Sesión con el paciente al que pertenece (para mostrar su nombre).
class _SesionConPaciente {
  const _SesionConPaciente({required this.sesion, required this.paciente});

  final Sesion sesion;
  final Paciente? paciente;
}

class _ListaSesionesScreenState extends State<ListaSesionesScreen> {
  late Future<List<_SesionConPaciente>> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = _cargar();
  }

  Future<List<_SesionConPaciente>> _cargar() async {
    final sesiones = await AppRepositorios.sesion.obtenerTodas();
    final pacientes = await AppRepositorios.paciente.obtenerTodos();
    final pacientesPorId = {for (final p in pacientes) p.id: p};
    return [
      for (final sesion in sesiones)
        _SesionConPaciente(
          sesion: sesion,
          paciente: pacientesPorId[sesion.idPaciente],
        ),
    ];
  }

  void _recargar() {
    setState(() {
      _futuro = _cargar();
    });
  }

  Future<void> _verSesion(_SesionConPaciente item) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => DetalleSesionSheet(
        sesion: item.sesion,
        nombrePaciente: item.paciente?.nombreCompleto,
        onEliminar: () async {
          await AppRepositorios.sesion.eliminar(item.sesion.id);
          if (mounted) Navigator.of(context).pop();
        },
      ),
    );
    _recargar();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sesiones'),
        actions: const [ThemeToggleButton()],
      ),
      body: FutureBuilder<List<_SesionConPaciente>>(
        future: _futuro,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? const <_SesionConPaciente>[];
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.history,
                      size: 64,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aún no hay sesiones guardadas.',
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Aplica un instrumento y guárdalo en un paciente '
                      'para que aparezca aquí.',
                      style: textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              final sesion = item.sesion;
              return Card(
                elevation: 1,
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  onTap: () => _verSesion(item),
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    foregroundColor: theme.colorScheme.onSecondaryContainer,
                    child: Text(
                      sesion.siglaInstrumento,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(sesion.nombreInstrumento),
                  subtitle: Text(
                    '${item.paciente?.nombreCompleto ?? 'Paciente eliminado'}'
                    ' · ${formatearFechaHora(sesion.fechaAplicacion)}'
                    '${sesion.resultadoEtiqueta.isNotEmpty ? ' · ${sesion.resultadoEtiqueta}' : ''}',
                  ),
                  trailing: Text(
                    '${sesion.resultadoTotal}',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
