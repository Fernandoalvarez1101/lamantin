import 'package:flutter/material.dart';

import 'config/supabase_config.dart';
import 'repositories/almacen.dart';
import 'screens/auth/auth_gate.dart';
import 'services/recuperacion_password.dart';
import 'theme.dart';
import 'widgets/theme_toggle_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Si la app no está configurada para Supabase, arrancamos en modo local.
  // Si la configuración existe pero la red/cliente falla, no hacemos fallback
  // silencioso: dejamos la app bloqueada y se mostrará un error en AuthGate.
  var supabaseListo = false;
  try {
    await AppRepositorios.inicializar();
    supabaseListo = SupabaseConfig.estaConfigurado;
  } catch (error, stackTrace) {
    debugPrint(
      'Supabase no disponible; el acceso queda bloqueado hasta elegir offline: $error',
    );
    debugPrintStack(stackTrace: stackTrace);
  }

  // El enlace de recuperación de contraseña se canjea antes de mostrar la app,
  // porque en web la URL se consume durante la inicialización de Supabase. Si
  // el enlace era de recuperación, AuthGate mostrará la pantalla para elegir
  // una contraseña nueva.
  if (supabaseListo) {
    await RecuperacionPassword.procesarCallbackWeb();
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
