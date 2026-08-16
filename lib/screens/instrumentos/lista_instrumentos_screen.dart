import 'package:flutter/material.dart';

import '../../data/catalogo_instrumentos.dart';
import '../../models/categoria_instrumento.dart';
import '../../widgets/theme_toggle_button.dart';
import 'categoria_ui.dart';
import 'instrumentos_por_categoria_screen.dart';

/// Pantalla del módulo Instrumentos.
///
/// Muestra las categorías de clasificación (Depresión, Ansiedad, Estrés,
/// Vocacional, etc.). Cada categoría conduce a la lista de instrumentos
/// que miden ese constructo.
class ListaInstrumentosScreen extends StatelessWidget {
  const ListaInstrumentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instrumentos'),
        actions: const [ThemeToggleButton()],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final esPantallaAncha = constraints.maxWidth >= 900;
          final columnas = esPantallaAncha ? 3 : 2;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clasificación por categoría',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Selecciona una categoría para ver los instrumentos '
                  'disponibles.',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnas,
                    mainAxisExtent: 180,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: CategoriaInstrumento.values.length,
                  itemBuilder: (context, index) {
                    final categoria = CategoriaInstrumento.values[index];
                    final cantidad = instrumentosDeCategoria(categoria).length;
                    return _TarjetaCategoria(
                      categoria: categoria,
                      cantidad: cantidad,
                      onTap: () => _abrirCategoria(context, categoria),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _abrirCategoria(
    BuildContext context,
    CategoriaInstrumento categoria,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => InstrumentosPorCategoriaScreen(categoria: categoria),
      ),
    );
  }
}

/// Tarjeta de una categoría en la pantalla de clasificación.
class _TarjetaCategoria extends StatelessWidget {
  const _TarjetaCategoria({
    required this.categoria,
    required this.cantidad,
    required this.onTap,
  });

  final CategoriaInstrumento categoria;
  final int cantidad;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = colorDeCategoria(categoria);

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color,
                foregroundColor: Colors.white,
                radius: 22,
                child: Icon(iconoDeCategoria(categoria), size: 24),
              ),
              const SizedBox(height: 10),
              Text(
                categoria.nombre,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                cantidad == 1 ? '1 instrumento' : '$cantidad instrumentos',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
