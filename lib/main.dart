import 'package:flutter/material.dart';

import 'repositories/almacen.dart';
import 'screens/auth/auth_gate.dart';
import 'theme.dart';
import 'widgets/theme_toggle_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Conecta Supabase si está configurada; si no, usa la base local.
  try {
    await AppRepositorios.inicializar();
  } catch (error, stackTrace) {
    // Si la inicialización de la nube falla (red, storage, configuración),
    // la app arranca igual con la base local en vez de quedarse en negro.
    debugPrint('No se pudo inicializar Supabase, usando base local: $error');
    debugPrintStack(stackTrace: stackTrace);
    await AppRepositorios.inicializarLocal();
  }
  runApp(const LamantinApp());
}

/// Aplicación principal de Lamantin.
///
/// Gestiona el tema global (claro/oscuro/sistema) y define la pantalla
/// inicial: el dashboard con los módulos disponibles.
class LamantinApp extends StatefulWidget {
  const LamantinApp({super.key});

  @override
  State<LamantinApp> createState() => _LamantinAppState();
}

class _LamantinAppState extends State<LamantinApp> {
  /// Modo de tema actual de la aplicación.
  ThemeMode _themeMode = ThemeMode.system;

  /// Alterna entre el tema claro y el oscuro.
  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lamantin',
      debugShowCheckedModeBanner: false,
      theme: lamantinLightTheme,
      darkTheme: lamantinDarkTheme,
      themeMode: _themeMode,
      builder: (context, child) => ThemeToggleScope(
        onThemeChanged: _toggleTheme,
        child: child!,
      ),
      home: AuthGate(onThemeChanged: _toggleTheme),
    );
  }
}
