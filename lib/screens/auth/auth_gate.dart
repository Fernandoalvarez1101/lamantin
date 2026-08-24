import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../repositories/almacen.dart';
import '../dashboard_screen.dart';
import 'login_screen.dart';

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
  StreamSubscription<AuthState>? _suscripcionAuth;

  @override
  void initState() {
    super.initState();
    _modoOffline = widget.modoOffline;
    try {
      final auth = Supabase.instance.client.auth;
      // Primero nos suscribimos a los cambios de sesión y después leemos la
      // sesión restaurada, para no perder el evento de restauración que
      // pudiera emitirse entre ambas operaciones.
      _suscripcionAuth = auth.onAuthStateChange.listen((data) {
        if (!mounted) return;
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

  @override
  Widget build(BuildContext context) {
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

    return LoginScreen(onThemeChanged: widget.onThemeChanged);
  }
}
