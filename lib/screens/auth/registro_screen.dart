import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/futuristic_button.dart';
import '../../widgets/glowing_app_logo.dart';
import '../../widgets/theme_toggle_button.dart';

/// Pantalla de registro del profesional (Supabase Auth).
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key, required this.onThemeChanged});

  final VoidCallback onThemeChanged;

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmar = TextEditingController();
  bool _cargando = false;
  bool _ocultarPassword = true;
  String? _error;
  String? _exito;

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _email.dispose();
    _password.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  String? _validarRequerido(String? v, String mensaje) =>
      (v == null || v.trim().isEmpty) ? mensaje : null;

  String? _validarEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Ingresá tu correo electrónico.';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(v.trim())) return 'El correo no parece válido.';
    return null;
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

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _cargando = true;
      _error = null;
      _exito = null;
    });

    try {
      final auth = Supabase.instance.client.auth;
      final respuesta = await auth.signUp(
        email: _email.text.trim(),
        password: _password.text,
        data: {
          'nombre': _nombre.text.trim(),
          'apellido': _apellido.text.trim(),
        },
      );
      if (!mounted) return;
      if (respuesta.session == null) {
        // La confirmación de email está activada: hay que confirmar.
        setState(() {
          _exito = 'Cuenta creada. Revisá tu correo para confirmarla '
              'y después iniciá sesión.';
        });
      }
      // Si hay sesión, el AuthGate pasa al dashboard automáticamente.
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
    if (m.contains('already registered') || m.contains('already been taken')) {
      return 'Ese correo ya está registrado.';
    }
    if (m.contains('password should be at least')) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }
    if (m.contains('signup not enabled')) {
      return 'El registro está desactivado en este proyecto.';
    }
    return mensaje;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear tu cuenta'),
        actions: [ThemeToggleButton(onThemeChanged: widget.onThemeChanged)],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const GlowingAppLogo(size: 72),
                    const SizedBox(height: 16),
                    Text(
                      'Creá tu cuenta de profesional',
                      style: textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tus datos clínicos quedarán protegidos y vinculados '
                      'a esta cuenta.',
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nombre,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Nombre *',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                _validarRequerido(v, 'Ingresá tu nombre.'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _apellido,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Apellido *',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                _validarRequerido(v, 'Ingresá tu apellido.'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                      validator: _validarEmail,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _password,
                      obscureText: _ocultarPassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña *',
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
                    if (_exito != null) ...[
                      const SizedBox(height: 12),
                      Card(
                        color: theme.colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            _exito!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    FuturisticButton(
                      label: 'Crear cuenta',
                      icon: Icons.person_add_alt,
                      onTap: _registrar,
                      loading: _cargando,
                      fullWidth: true,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed:
                          _cargando ? null : () => Navigator.of(context).pop(),
                      child: const Text('¿Ya tenés cuenta? Ingresá'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
