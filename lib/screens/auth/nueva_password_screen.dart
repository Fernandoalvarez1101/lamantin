import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/futuristic_button.dart';
import '../../widgets/glowing_app_logo.dart';
import '../../widgets/theme_toggle_button.dart';

/// Pantalla que se muestra al volver del enlace de recuperación por correo.
///
/// El profesional ya tiene una sesión temporal de recuperación: sólo falta que
/// elija la contraseña nueva. Al terminar se avisa con [onListo] para que la
/// app cierre el flujo y lo deje entrar.
class NuevaPasswordScreen extends StatefulWidget {
  const NuevaPasswordScreen({
    super.key,
    required this.onThemeChanged,
    required this.onListo,
  });

  final VoidCallback onThemeChanged;

  /// Se llama cuando la contraseña ya fue actualizada, o cuando el profesional
  /// cancela y se cierra su sesión temporal.
  final VoidCallback onListo;

  @override
  State<NuevaPasswordScreen> createState() => _NuevaPasswordScreenState();
}

class _NuevaPasswordScreenState extends State<NuevaPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmar = TextEditingController();
  bool _cargando = false;
  bool _ocultarPassword = true;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  String? _validarPassword(String? v) {
    if (v == null || v.isEmpty) return 'Ingresá una contraseña.';
    if (v.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }
    return null;
  }

  String? _validarConfirmacion(String? v) {
    if (v == null || v.isEmpty) return 'Repetí la contraseña.';
    if (v != _password.text) return 'Las contraseñas no coinciden.';
    return null;
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _cargando = true;
      _error = null;
    });

    try {
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(password: _password.text));
      if (!mounted) return;
      widget.onListo();
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

  Future<void> _cancelar() async {
    setState(() => _cargando = true);
    try {
      // La sesión de recuperación es temporal: se cierra antes de volver al
      // login para no dejar al profesional dentro con una contraseña vieja.
      await Supabase.instance.client.auth.signOut();
    } catch (_) {
      // Si el cierre falla igual se vuelve al ingreso.
    }
    if (!mounted) return;
    widget.onListo();
  }

  String _traducirError(String mensaje) {
    final m = mensaje.toLowerCase();
    if (m.contains('should be at least')) {
      return 'La contraseña es demasiado corta.';
    }
    if (m.contains('should be different')) {
      return 'La contraseña nueva debe ser distinta de la anterior.';
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const GlowingAppLogo(size: 96),
                        const SizedBox(height: 16),
                        Text(
                          'Nueva contraseña',
                          style: textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Elegí una contraseña nueva para tu cuenta',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _password,
                          obscureText: _ocultarPassword,
                          decoration: InputDecoration(
                            labelText: 'Contraseña nueva *',
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
                          validator: _validarPassword,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmar,
                          obscureText: _ocultarPassword,
                          decoration: const InputDecoration(
                            labelText: 'Confirmar contraseña *',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: _validarConfirmacion,
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
                          label: 'Guardar contraseña',
                          icon: Icons.save_rounded,
                          onTap: _guardar,
                          loading: _cargando,
                          fullWidth: true,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _cargando ? null : _cancelar,
                          child: const Text('Cancelar y volver al ingreso'),
                        ),
                      ],
                    ),
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
