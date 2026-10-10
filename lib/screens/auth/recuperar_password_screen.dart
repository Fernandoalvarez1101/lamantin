import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/recuperacion_password.dart';
import '../../widgets/futuristic_button.dart';
import '../../widgets/glowing_app_logo.dart';
import '../../widgets/theme_toggle_button.dart';

/// Pantalla para pedir por correo el enlace de recuperación de contraseña.
class RecuperarPasswordScreen extends StatefulWidget {
  const RecuperarPasswordScreen({super.key, required this.onThemeChanged});

  final VoidCallback onThemeChanged;

  @override
  State<RecuperarPasswordScreen> createState() =>
      _RecuperarPasswordScreenState();
}

class _RecuperarPasswordScreenState extends State<RecuperarPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _cargando = false;
  String? _error;
  String? _exito;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  String? _validarEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Ingresá tu correo electrónico.';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(v.trim())) return 'El correo no parece válido.';
    return null;
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _cargando = true;
      _error = null;
      _exito = null;
    });

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        _email.text.trim(),
        redirectTo: RecuperacionPassword.urlRetorno,
      );
      if (!mounted) return;
      // El mensaje no confirma si el correo existe o no, para no filtrar qué
      // cuentas están registradas.
      setState(() {
        _exito = 'Si ese correo está registrado, te enviamos un enlace para '
            'elegir una contraseña nueva. Revisá también la carpeta de spam.';
      });
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
    if (m.contains('rate limit') || m.contains('too many')) {
      return 'Enviaste demasiadas solicitudes. Esperá unos minutos.';
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
                          'Recuperar contraseña',
                          style: textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Te enviamos un enlace por correo para elegir una '
                          'contraseña nueva',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
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
                          label: 'Enviar enlace',
                          icon: Icons.send_rounded,
                          onTap: _enviar,
                          loading: _cargando,
                          fullWidth: true,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _cargando
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: const Text('Volver al ingreso'),
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
