import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

/// Logo de Lamantin con halo brillante animado.
///
/// Mismo formato que el logo de la Bitácora del paciente, adaptado a la
/// paleta de Lamantin: el icono flota sobre un halo circular que "respira"
/// (se enciende y apaga) con una animación de pulso.
class GlowingAppLogo extends StatefulWidget {
  const GlowingAppLogo({
    super.key,
    this.size = 80,
    this.animate = true,
    this.glowAlpha = 0.35,
  });

  /// Diámetro del logo en píxeles.
  final double size;

  /// Si es `true`, el halo pulsa continuamente; si es `false`, queda fijo.
  final bool animate;

  /// Opacidad base del halo (0-1).
  final double glowAlpha;

  @override
  State<GlowingAppLogo> createState() => _GlowingAppLogoState();
}

class _GlowingAppLogoState extends State<GlowingAppLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = 0.5;
    }
  }

  @override
  void didUpdateWidget(covariant GlowingAppLogo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animate != widget.animate) {
      if (widget.animate) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0.5;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = widget.animate
            ? Curves.easeInOut.transform(_controller.value)
            : 0.5;
        final scale = 1 + (0.04 * math.sin(t * math.pi));
        final glowAlpha = widget.glowAlpha + (0.12 * t);
        // El halo escala con el tamaño para mantener la proporción del
        // formato original (con tamaño 80 equivale a blur 34-48 y spread 5-8).
        final factor = widget.size / 80;

        return Transform.scale(
          scale: scale,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: LamantinColors.dustyViolet
                      .withValues(alpha: glowAlpha.clamp(0, 1)),
                  blurRadius: (34 + (14 * t)) * factor,
                  spreadRadius: (5 + (3 * t)) * factor,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: Image.asset(
        'assets/logo_manati.png',
        width: widget.size,
        height: widget.size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.broken_image,
          size: widget.size * 0.7,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
