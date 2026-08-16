import 'package:flutter/material.dart';

import '../../data/aplicaciones/registro_aplicaciones.dart';
import '../../data/catalogo_instrumentos.dart';
import '../../models/categoria_instrumento.dart';
import '../../models/instrumento.dart';
import '../../models/instrumento_aplicable.dart';
import '../../widgets/futuristic_button.dart';
import '../../widgets/theme_toggle_button.dart';
import '../aplicacion/aplicacion_instrumento_screen.dart';
import 'categoria_ui.dart';

/// Muestra los instrumentos que miden la categoría seleccionada.
///
/// Cada tarjeta presenta la ficha resumida del instrumento y, al pulsarla,
/// abre una hoja inferior con la información completa.
class InstrumentosPorCategoriaScreen extends StatelessWidget {
  const InstrumentosPorCategoriaScreen({
    super.key,
    required this.categoria,
  });

  final CategoriaInstrumento categoria;

  @override
  Widget build(BuildContext context) {
    final instrumentos = instrumentosDeCategoria(categoria);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoria.nombre),
        actions: const [ThemeToggleButton()],
      ),
      body: instrumentos.isEmpty
          ? const Center(child: Text('Sin instrumentos en esta categoría.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: instrumentos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final instrumento = instrumentos[index];
                return _TarjetaInstrumento(
                  instrumento: instrumento,
                  onTap: () => _mostrarDetalle(context, instrumento),
                );
              },
            ),
    );
  }

  Future<void> _mostrarDetalle(
    BuildContext context,
    Instrumento instrumento,
  ) async {
    final aplicacion = aplicacionDe(instrumento.id);

    final aplicar = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _DetalleInstrumento(
        instrumento: instrumento,
        aplicacion: aplicacion,
        onAplicar: () => Navigator.of(sheetContext).pop(true),
      ),
    );

    if (aplicar == true && aplicacion != null && context.mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => AplicacionInstrumentoScreen(instrumento: aplicacion),
        ),
      );
    }
  }
}

/// Tarjeta resumida de un instrumento.
class _TarjetaInstrumento extends StatelessWidget {
  const _TarjetaInstrumento({required this.instrumento, required this.onTap});

  final Instrumento instrumento;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = colorDeCategoria(instrumento.categoria);

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color,
                foregroundColor: Colors.white,
                radius: 22,
                child: const Icon(Icons.description_outlined, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instrumento.sigla,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(instrumento.nombre, style: textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        _ChipMeta(
                          icono: Icons.list_alt,
                          texto: '${instrumento.numeroItems} ítems',
                        ),
                        _ChipMeta(
                          icono: Icons.timer_outlined,
                          texto: instrumento.tiempo,
                        ),
                        _ChipMeta(
                          icono: Icons.verified_user_outlined,
                          texto: instrumento.disponibilidad,
                        ),
                        if (aplicacionDe(instrumento.id) != null)
                          const _ChipMeta(
                            icono: Icons.play_circle_outline,
                            texto: 'Aplicable',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// Metadato breve (ítems, tiempo, disponibilidad) de un instrumento.
class _ChipMeta extends StatelessWidget {
  const _ChipMeta({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icono, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          texto,
          style: textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}

/// Hoja inferior con la ficha completa del instrumento.
class _DetalleInstrumento extends StatelessWidget {
  const _DetalleInstrumento({
    required this.instrumento,
    this.aplicacion,
    this.onAplicar,
  });

  final Instrumento instrumento;

  /// Aplicación disponible para este instrumento, si existe.
  final InstrumentoAplicable? aplicacion;

  /// Acción para iniciar la aplicación (cierra la hoja).
  final VoidCallback? onAplicar;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            instrumento.sigla,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(instrumento.nombre, style: textTheme.titleMedium),
          const SizedBox(height: 16),
          _FilaDetalle(
            icono: Icons.psychology_outlined,
            etiqueta: 'Qué mide',
            valor: instrumento.descripcion,
          ),
          _FilaDetalle(
            icono: Icons.person_outline,
            etiqueta: 'Autor',
            valor: '${instrumento.autor} (${instrumento.anio})',
          ),
          _FilaDetalle(
            icono: Icons.list_alt,
            etiqueta: 'Ítems',
            valor: '${instrumento.numeroItems}',
          ),
          _FilaDetalle(
            icono: Icons.timer_outlined,
            etiqueta: 'Tiempo de aplicación',
            valor: instrumento.tiempo,
          ),
          if (instrumento.poblacion != null)
            _FilaDetalle(
              icono: Icons.groups_outlined,
              etiqueta: 'Población',
              valor: instrumento.poblacion!,
            ),
          _FilaDetalle(
            icono: Icons.verified_user_outlined,
            etiqueta: 'Disponibilidad',
            valor: instrumento.disponibilidad,
          ),
          if (instrumento.nota != null)
            _FilaDetalle(
              icono: Icons.info_outline,
              etiqueta: 'Nota',
              valor: instrumento.nota!,
            ),
          if (aplicacion != null) ...[
            const SizedBox(height: 24),
            FuturisticButton(
              label: 'Aplicar instrumento',
              icon: Icons.play_arrow,
              onTap: onAplicar,
              fullWidth: true,
            ),
          ],
        ],
      ),
    );
  }
}

/// Fila de la ficha de detalle: icono, etiqueta y valor.
class _FilaDetalle extends StatelessWidget {
  const _FilaDetalle({
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  final IconData icono;
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icono,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  etiqueta.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(letterSpacing: 1),
                ),
                const SizedBox(height: 2),
                Text(valor, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
