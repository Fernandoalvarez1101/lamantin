import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import '../../models/sesion.dart';
import '../../repositories/almacen.dart';
import '../../theme.dart';
import '../../utils/formato.dart';
import '../../widgets/theme_toggle_button.dart';
import 'informe_paciente_screen.dart';

/// Módulo Resultados: listado de pacientes con resumen para acceder a su
/// informe completo (puntuaciones y evolución temporal).
class ListaResultadosScreen extends StatefulWidget {
  const ListaResultadosScreen({super.key});

  @override
  State<ListaResultadosScreen> createState() => _ListaResultadosScreenState();
}

/// Paciente con el resumen de sus sesiones para el listado.
class _PacienteResumen {
  const _PacienteResumen({required this.paciente, required this.sesiones});

  final Paciente paciente;
  final List<Sesion> sesiones;

  DateTime? get ultimaSesion =>
      sesiones.isEmpty ? null : sesiones.first.fechaAplicacion;
}

class _ListaResultadosScreenState extends State<ListaResultadosScreen> {
  late Future<List<_PacienteResumen>> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = _cargar();
  }

  Future<List<_PacienteResumen>> _cargar() async {
    final pacientes = await AppRepositorios.paciente.obtenerTodos();
    final resumenes = <_PacienteResumen>[];
    for (final paciente in pacientes) {
      final sesiones =
          await AppRepositorios.sesion.obtenerPorPaciente(paciente.id);
      resumenes.add(
        _PacienteResumen(paciente: paciente, sesiones: sesiones),
      );
    }
    // Los pacientes con actividad primero, ordenados por última sesión;
    // los que aún no tienen sesiones al final, por nombre.
    resumenes.sort((a, b) {
      final aUltima = a.ultimaSesion;
      final bUltima = b.ultimaSesion;
      if (aUltima == null && bUltima == null) {
        return a.paciente.nombreCompleto.compareTo(b.paciente.nombreCompleto);
      }
      if (aUltima == null) return 1;
      if (bUltima == null) return -1;
      return bUltima.compareTo(aUltima);
    });
    return resumenes;
  }

  void _recargar() {
    setState(() {
      _futuro = _cargar();
    });
  }

  Future<void> _abrirInforme(_PacienteResumen resumen) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => InformePacienteScreen(paciente: resumen.paciente),
      ),
    );
    _recargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informes de pacientes'),
        actions: const [ThemeToggleButton()],
      ),
      body: FutureBuilder<List<_PacienteResumen>>(
        future: _futuro,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final resumenes = snapshot.data ?? const <_PacienteResumen>[];
          if (resumenes.isEmpty) {
            return const _EstadoVacio();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: resumenes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final resumen = resumenes[index];
              return _TarjetaPacienteInforme(
                resumen: resumen,
                onTap: () => _abrirInforme(resumen),
              );
            },
          );
        },
      ),
    );
  }
}

/// Tarjeta de un paciente con el resumen de sus aplicaciones.
class _TarjetaPacienteInforme extends StatelessWidget {
  const _TarjetaPacienteInforme({required this.resumen, required this.onTap});

  final _PacienteResumen resumen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final p = resumen.paciente;

    final demograficos = <String>[
      if (p.edad != null) '${p.edad} años',
      if (p.sexo != null) p.sexo!,
    ].join(' · ');

    final String subtitulo;
    if (resumen.sesiones.isEmpty) {
      subtitulo = 'Sin sesiones guardadas';
    } else {
      final instrumentos = {
        for (final s in resumen.sesiones) s.siglaInstrumento,
      }.length;
      subtitulo =
          '${resumen.sesiones.length} sesión(es) · $instrumentos instrumento(s)'
          ' · Última: ${formatearFecha(resumen.ultimaSesion!)}';
    }

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: LamantinColors.dustyViolet,
          foregroundColor: Colors.white,
          child: Text(
            inicialesDe(p.nombre, p.apellido),
            style: const TextStyle(fontSize: 14),
          ),
        ),
        title: Text(
          p.nombreCompleto,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (demograficos.isNotEmpty)
              Text(demograficos, style: textTheme.bodySmall),
            const SizedBox(height: 2),
            Text(subtitulo, style: textTheme.bodySmall),
          ],
        ),
        trailing: resumen.sesiones.isEmpty
            ? const Icon(Icons.chevron_right)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${resumen.sesiones.first.resultadoTotal}',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right),
                ],
              ),
      ),
    );
  }
}

/// Estado vacío del módulo Resultados.
class _EstadoVacio extends StatelessWidget {
  const _EstadoVacio();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insights_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Aún no hay informes para mostrar.',
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Registrá un paciente, aplicá instrumentos y guardá los '
              'resultados para ver aquí sus puntuaciones y su evolución.',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
