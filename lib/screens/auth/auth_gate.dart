import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../dashboard_screen.dart';
import 'login_screen.dart';

/// Decide si mostrar el login o el dashboard según la sesión de Supabase.
///
/// Si Supabase no está disponible (p. ej. en tests o sin credenciales),
/// permite el acceso directo.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.onThemeChanged});

  final VoidCallback onThemeChanged;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _supabaseDisponible = true;
  bool _autenticado = false;
  StreamSubscription<AuthState>? _suscripcionAuth;

  @override
  void initState() {
    super.initState();
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
      // Supabase no inicializado (tests o entorno sin credenciales).
      _supabaseDisponible = false;
    }
  }

  @override
  void dispose() {
    // Cancela la suscripción para no dejar listeners huérfanos al destruir
    // el widget (evita llamadas a setState tras el dispose y fugas).
    _suscripcionAuth?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_supabaseDisponible || _autenticado) {
      return DashboardScreen(onThemeChanged: widget.onThemeChanged);
    }
    return LoginScreen(onThemeChanged: widget.onThemeChanged);
  }
}
