import 'package:flutter/material.dart';

import '../theme.dart';

/// Botón futurista con efecto de resplandor (glow).
///
/// Mismo formato que el botón de la Bitácora del paciente, adaptado a la
/// paleta de Lamantin: fondo oscuro, borde violeta de 1.5 px que se aclara
/// al pasar el mouse y sombra resplandeciente que se intensifica en hover.
class FuturisticButton extends StatefulWidget {
  const FuturisticButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.fullWidth = false,
    this.loading = false,
  });

  /// Texto del botón (se conserva tal cual, en minúsculas o como se pase).
  final String label;

  /// Acción al tocar; si es `null` o [loading] es `true`, queda inactivo.
  final VoidCallback? onTap;

  /// Icono opcional a la izquierda del texto.
  final IconData? icon;

  /// Si es `true`, ocupa todo el ancho disponible con el contenido centrado.
  final bool fullWidth;

  /// Si es `true`, muestra un indicador de carga en lugar del contenido.
  final bool loading;

  @override
  State<FuturisticButton> createState() => _FuturisticButtonState();
}

class _FuturisticButtonState extends State<FuturisticButton> {
  bool _isHovered = false;

  /// Borde y resplandor: violeta de marca que se aclara al pasar el mouse.
  Color get _colorBorde => _isHovered
      ? Color.lerp(LamantinColors.dustyViolet, Colors.white, 0.35)!
      : LamantinColors.dustyViolet;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: LamantinColors.darkSlatePurple,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _colorBorde, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: _colorBorde.withValues(alpha: 0.3),
                blurRadius: _isHovered ? 16 : 8,
                spreadRadius: _isHovered ? 2 : 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: widget.fullWidth
                ? MainAxisSize.max
                : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.loading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else ...[
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                ],
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
