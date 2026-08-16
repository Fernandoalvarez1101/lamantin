import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/futuristic_button.dart';
import '../../widgets/glowing_app_logo.dart';
import '../../widgets/theme_toggle_button.dart';
import 'registro_screen.dart';

/// Pantalla de ingreso y registro del profesional (Supabase Auth).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onThemeChanged});

  final VoidCallback onThemeChanged;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _cargando = false;
  bool _ocultarPassword = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _ingresar() async {
    final email = _email.text.trim();
    final password = _password.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Ingresá tu correo y tu contraseña.');
      return;
    }
    setState(() {
      _cargando = true;
      _error = null;
    });

    try {
      await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e is AuthException
            ? _traducirError(e.message)
            : 'Error inesperado. Intentá de nuevo.';
      });
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  String _traducirError(String mensaje) {
    final m = mensaje.toLowerCase();
    if (m.contains('invalid login credentials')) {
      return 'Correo o contraseña incorrectos.';
    }
    if (m.contains('email not confirmed')) {
      return 'Tu correo todavía no fue confirmado.';
    }
    return mensaje;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const GlowingAppLogo(size: 96),
                      const SizedBox(height: 16),
                      Text(
                        'Lamantin',
                        style: textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Iniciá sesión para acceder a tus pacientes',
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _password,
                        obscureText: _ocultarPassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ocultarPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            tooltip: _ocultarPassword
                                ? 'Mostrar contraseña'
                                : 'Ocultar contraseña',
                            onPressed: () => setState(
                                () => _ocultarPassword = !_ocultarPassword),
                          ),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _error!,
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 20),
                      FuturisticButton(
                        label: 'Ingresar',
                        icon: Icons.login_rounded,
                        onTap: _ingresar,
                        loading: _cargando,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _cargando
                            ? null
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => RegistroScreen(
                                      onThemeChanged: widget.onThemeChanged,
                                    ),
                                  ),
                                );
                              },
                        child: const Text('¿No tenés cuenta? Registrate'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ThemeToggleButton(onThemeChanged: widget.onThemeChanged),
            ),
          ],
        ),
      ),
    );
  }
}
