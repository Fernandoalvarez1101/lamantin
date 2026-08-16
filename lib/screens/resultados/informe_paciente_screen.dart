import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

import '../../models/paciente.dart';
import '../../models/sesion.dart';
import '../../repositories/almacen.dart';
import '../../services/informe_pdf.dart';
import '../../services/informe_texto.dart';
import '../../services/reporte_paciente.dart';
import '../../utils/formato.dart';
import '../../widgets/evolucion_chart.dart';
import '../../widgets/theme_toggle_button.dart';

/// Informe de un paciente: datos personales, resumen y todas sus sesiones
/// agrupadas por instrumento, con gráfica de evolución temporal cuando un
/// instrumento se aplicó más de una vez.
class InformePacienteScreen extends StatefulWidget {
  const InformePacienteScreen({super.key, required this.paciente});

  final Paciente paciente;

  @override
  State<InformePacienteScreen> createState() => _InformePacienteScreenState();
}

class _InformePacienteScreenState extends State<InformePacienteScreen> {
  late Future<List<Sesion>> _futuroSesiones;

  @override
  void initState() {
    super.initState();
    _futuroSesiones =
        AppRepositorios.sesion.obtenerPorPaciente(widget.paciente.id);
  }

  String _subtituloPaciente() {
    final p = widget.paciente;
    final partes = <String>[
      if (p.edad != null) '${p.edad} años',
      if (p.sexo != null) p.sexo!,
    ];
    return partes.join(' · ');
  }

  Future<void> _mostrarOpcionesExportar(BuildContext context) async {
    final opcion = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: const Text('Descargar informe en PDF'),
              onTap: () => Navigator.of(sheetContext).pop('pdf'),
            ),
            ListTile(
              leading: const Icon(Icons.copy_all_outlined),
              title: const Text('Copiar informe como texto'),
              onTap: () => Navigator.of(sheetContext).pop('texto'),
            ),
          ],
        ),
      ),
    );
    if (opcion == 'pdf') await _exportarPdf();
    if (opcion == 'texto') await _copiarTexto();
  }

  Future<void> _exportarPdf() async {
    try {
      final sesiones =
          await AppRepositorios.sesion.obtenerPorPaciente(widget.paciente.id);
      if (sesiones.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay sesiones para exportar.')),
        );
        return;
      }
      final bytes = await generarInformePdf(
        paciente: widget.paciente,
        sesiones: sesiones,
      );
      final nombre =
          'informe_${nombreArchivoSeguro(widget.paciente.nombreCompleto)}.pdf';
      await Printing.sharePdf(bytes: bytes, filename: nombre);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo exportar el PDF: $error')),
      );
    }
  }

  Future<void> _copiarTexto() async {
    final sesiones =
        await AppRepositorios.sesion.obtenerPorPaciente(widget.paciente.id);
    final texto = generarInformeTexto(
      paciente: widget.paciente,
      sesiones: sesiones,
    );
    await Clipboard.setData(ClipboardData(text: texto));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informe copiado al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final p = widget.paciente;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            tooltip: 'Exportar informe',
            onPressed: () => _mostrarOpcionesExportar(context),
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: FutureBuilder<List<Sesion>>(
        future: _futuroSesiones,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final sesiones = snapshot.data ?? const <Sesion>[];
          if (sesiones.isEmpty) {
            return _sinSesiones(theme, textTheme);
          }
          final grupos = agruparSesionesPorInstrumento(sesiones);
          final totalAlertas = sesiones.where((s) => s.tieneAlertas).length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _cabeceraPaciente(theme, textTheme, p),
              const SizedBox(height: 16),
              _resumen(theme, textTheme, sesiones, grupos, totalAlertas),
              const SizedBox(height: 16),
              for (final grupo in grupos) ...[
                _seccionInstrumento(textTheme, grupo.sesiones),
                const SizedBox(height: 16),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _sinSesiones(ThemeData theme, TextTheme textTheme) {
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
              'Sin sesiones guardadas.',
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Aplicá instrumentos al paciente y guardá los resultados '
              'para construir su informe.',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cabeceraPaciente(
    ThemeData theme,
    TextTheme textTheme,
    Paciente p,
  ) {
    final demograficos = _subtituloPaciente();
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.nombreCompleto,
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    demograficos.isEmpty
                        ? 'Alta: ${formatearFecha(p.fechaRegistro)}'
                        : '$demograficos\nAlta: ${formatearFecha(p.fechaRegistro)}',
                    style: textTheme.bodyMedium,
                  ),
                  if (p.notas != null) ...[
                    const SizedBox(height: 8),
                    Text('Notas: ${p.notas}', style: textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumen(
    ThemeData theme,
    TextTheme textTheme,
    List<Sesion> sesiones,
    List<GrupoInstrumento> grupos,
    int totalAlertas,
  ) {
    return Row(
      children: [
        _ChipResumen(
          icono: Icons.history,
          valor: '${sesiones.length}',
          etiqueta: 'sesiones',
        ),
        const SizedBox(width: 8),
        _ChipResumen(
          icono: Icons.assignment_outlined,
          valor: '${grupos.length}',
          etiqueta: 'instrumentos',
        ),
        const SizedBox(width: 8),
        _ChipResumen(
          icono: Icons.warning_amber_rounded,
          valor: '$totalAlertas',
          etiqueta: 'con alertas',
          color: totalAlertas > 0 ? theme.colorScheme.error : null,
        ),
      ],
    );
  }

  Widget _seccionInstrumento(TextTheme textTheme, List<Sesion> grupo) {
    final primera = grupo.first;
    final ultima = grupo.last;
    final delta = ultima.resultadoTotal - primera.resultadoTotal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                primera.siglaInstrumento,
                style:
                    textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '${grupo.length} aplicación(es)',
              style: textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(primera.nombreInstrumento, style: textTheme.bodyMedium),
        const SizedBox(height: 12),
        if (grupo.length >= 2) ...[
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Evolución',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  EvolucionChart(sesiones: grupo),
                  const SizedBox(height: 12),
                  Text(
                    '1.ª: ${primera.resultadoTotal}'
                    '${primera.resultadoEtiqueta.isNotEmpty ? ' (${primera.resultadoEtiqueta})' : ''}'
                    ' → Última: ${ultima.resultadoTotal}'
                    '${ultima.resultadoEtiqueta.isNotEmpty ? ' (${ultima.resultadoEtiqueta})' : ''}'
                    ' · Δ ${delta >= 0 ? '+' : ''}$delta',
                    style: textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        for (final sesion in grupo.reversed) ...[
          _FilaSesion(sesion: sesion),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

/// Fila con el resumen de una sesión dentro del informe.
class _FilaSesion extends StatelessWidget {
  const _FilaSesion({required this.sesion});

  final Sesion sesion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      child: ListTile(
        dense: true,
        leading: sesion.tieneAlertas
            ? Icon(
                Icons.warning_amber_rounded,
                color: theme.colorScheme.error,
              )
            : const Icon(Icons.check_circle_outline),
        title: Text(
          'Puntuación: ${sesion.resultadoTotal}'
          '${sesion.resultadoEtiqueta.isNotEmpty ? ' · ${sesion.resultadoEtiqueta}' : ''}',
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(formatearFechaHora(sesion.fechaAplicacion)),
      ),
    );
  }
}

/// Métrica compacta del resumen del informe (sesiones, instrumentos, alertas).
class _ChipResumen extends StatelessWidget {
  const _ChipResumen({
    required this.icono,
    required this.valor,
    required this.etiqueta,
    this.color,
  });

  final IconData icono;
  final String valor;
  final String etiqueta;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = color ?? theme.colorScheme.primary;

    return Expanded(
      child: Card(
        elevation: 0,
        color: c.withValues(alpha: 0.10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            children: [
              Icon(icono, size: 18, color: c),
              const SizedBox(height: 4),
              Text(
                valor,
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: c, fontWeight: FontWeight.bold),
              ),
              Text(
                etiqueta,
                style: theme.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
