import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../repositories/almacen.dart';
import '../../services/recuperacion_password.dart';
import '../dashboard_screen.dart';
import 'login_screen.dart';
import 'nueva_password_screen.dart';

/// Decide si mostrar el login o el dashboard según la sesión de Supabase.
///
/// El acceso directo a dashboard sólo está permitido si el usuario eligió
/// explícitamente el modo offline. Si Supabase está caído, se bloquea el acceso
/// y se muestra un error en el login para evitar el bypass por red.
class AuthGate extends StatefulWidget {
  const AuthGate({
    super.key,
    required this.onThemeChanged,
    this.modoOffline = false,
  });

  final VoidCallback onThemeChanged;
  final bool modoOffline;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _supabaseDisponible = true;
  bool _autenticado = false;
  bool _modoOffline = false;
  String? _errorEnlace;
  StreamSubscription<AuthState>? _suscripcionAuth;

  @override
  void initState() {
    super.initState();
    _modoOffline = widget.modoOffline;
    // Si el enlace del correo no se pudo canjear (venció o se abrió en otro
    // navegador), el motivo se muestra una sola vez en el login.
    _errorEnlace = RecuperacionPassword.error;
    RecuperacionPassword.error = null;
    try {
      final auth = Supabase.instance.client.auth;
      // Primero nos suscribimos a los cambios de sesión y después leemos la
      // sesión restaurada, para no perder el evento de restauración que
      // pudiera emitirse entre ambas operaciones.
      _suscripcionAuth = auth.onAuthStateChange.listen((data) {
        if (!mounted) return;
        // En móvil y escritorio el evento llega después de inicializar. En web
        // el callback se detecta en `main` antes de mostrar la app.
        if (data.event == AuthChangeEvent.passwordRecovery) {
          RecuperacionPassword.pendiente = true;
        }
        setState(() => _autenticado = data.session != null);
      });
      _autenticado = auth.currentSession != null;
    } catch (_) {
      _supabaseDisponible = false;
    }
  }

  @override
  void dispose() {
    _suscripcionAuth?.cancel();
    super.dispose();
  }

  Future<void> _activarModoOffline() async {
    try {
      await AppRepositorios.inicializarLocal();
    } catch (_) {
      // El usuario eligió explícitamente el modo offline, pero si la base
      // local no puede abrirse es necesario mostrar el error en lugar de
      // continuar con la app.
    }
    if (!mounted) return;
    setState(() => _modoOffline = true);
  }

  /// Cierra el flujo de recuperación de contraseña (ya sea porque el
  /// profesional guardó la contraseña nueva o porque canceló).
  void _cerrarRecuperacion() {
    if (!mounted) return;
    setState(RecuperacionPassword.finalizar);
  }

  @override
  Widget build(BuildContext context) {
    // El profesional volvió desde el enlace del correo: antes de entrar tiene
    // que elegir una contraseña nueva.
    if (RecuperacionPassword.pendiente) {
      return NuevaPasswordScreen(
        onThemeChanged: widget.onThemeChanged,
        onListo: _cerrarRecuperacion,
      );
    }

    if ((_modoOffline || widget.modoOffline) && !_supabaseDisponible) {
      return DashboardScreen(onThemeChanged: widget.onThemeChanged);
    }

    if (_supabaseDisponible && _autenticado) {
      return DashboardScreen(onThemeChanged: widget.onThemeChanged);
    }

    if (!_supabaseDisponible) {
      return LoginScreen(
        onThemeChanged: widget.onThemeChanged,
        errorMessage:
            'No se pudo iniciar Supabase. Revisá tu conexión o elegí "Continuar sin conexión".',
        onContinueOffline: _activarModoOffline,
      );
    }

    return LoginScreen(
      onThemeChanged: widget.onThemeChanged,
      errorMessage: _errorEnlace,
    );
  }
}
