import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme.dart';
import '../widgets/glowing_app_logo.dart';
import '../widgets/theme_toggle_button.dart';
import 'instrumentos/lista_instrumentos_screen.dart';
import 'pacientes/lista_pacientes_screen.dart';
import 'resultados/lista_resultados_screen.dart';
import 'sesiones/lista_sesiones_screen.dart';

/// Módulo disponible desde el dashboard de Lamantin.
class _Modulo {
  const _Modulo({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.construirPantalla,
  });

  final String titulo;
  final String descripcion;
  final IconData icono;
  final Color color;

  /// Construye la pantalla de destino del módulo.
  final Widget Function() construirPantalla;
}

/// Pantalla principal de Lamantin.
///
/// Funciona como centro de navegación: muestra los módulos disponibles y
/// cada botón lleva a la pantalla correspondiente de la aplicación.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.onThemeChanged});

  /// Callback para alternar entre tema claro y oscuro.
  final VoidCallback onThemeChanged;

  static const List<_Modulo> _modulos = [
    _Modulo(
      titulo: 'Instrumentos',
      descripcion: 'Catálogo de tests de uso público',
      icono: Icons.assignment_outlined,
      color: LamantinColors.dustyViolet,
      construirPantalla: ListaInstrumentosScreen.new,
    ),
    _Modulo(
      titulo: 'Pacientes',
      descripcion: 'Gestión de pacientes',
      icono: Icons.people_outline,
      color: LamantinColors.slateBlueSecondary,
      construirPantalla: ListaPacientesScreen.new,
    ),
    _Modulo(
      titulo: 'Sesiones',
      descripcion: 'Historial de aplicaciones',
      icono: Icons.history_rounded,
      color: LamantinColors.darkSlatePurple,
      construirPantalla: ListaSesionesScreen.new,
    ),
    _Modulo(
      titulo: 'Resultados',
      descripcion: 'Puntuaciones e informes',
      icono: Icons.insights_outlined,
      color: LamantinColors.dustyViolet,
      construirPantalla: ListaResultadosScreen.new,
    ),
  ];

  void _abrirModulo(BuildContext context, _Modulo modulo) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => modulo.construirPantalla()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlowingAppLogo(size: 34, animate: false, glowAlpha: 0.3),
            SizedBox(width: 12),
            Text('Lamantin'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              try {
                await Supabase.instance.client.auth.signOut();
              } catch (_) {
                // Sin Supabase (modo local/tests) no hay sesión que cerrar.
              }
            },
          ),
          ThemeToggleButton(onThemeChanged: onThemeChanged),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 2 columnas en móvil, 4 en pantallas anchas (web/desktop).
          final esPantallaAncha = constraints.maxWidth >= 900;
          final columnas = esPantallaAncha ? 4 : 2;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Panel de control', style: textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'Selecciona una sección para comenzar',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnas,
                    mainAxisExtent: esPantallaAncha ? 200 : 180,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: _modulos.length,
                  itemBuilder: (context, index) {
                    final modulo = _modulos[index];
                    return _TarjetaModulo(
                      modulo: modulo,
                      onTap: () => _abrirModulo(context, modulo),
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
}

/// Tarjeta de un módulo del dashboard.
class _TarjetaModulo extends StatelessWidget {
  const _TarjetaModulo({required this.modulo, required this.onTap});

  final _Modulo modulo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: modulo.color,
                foregroundColor: Colors.white,
                radius: 24,
                child: Icon(modulo.icono, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                modulo.titulo,
                style:
                    textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  modulo.descripcion,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
