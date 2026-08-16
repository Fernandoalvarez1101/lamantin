import 'package:flutter/material.dart';

/// Paleta de marca de Lamantin.
///
/// Fuente única de verdad para los colores de la marca. Todas las pantallas
/// y componentes deben usar estos valores en lugar de repetir códigos
/// hexadecimales, para que un cambio de paleta se refleje en toda la app.
abstract final class LamantinColors {
  /// Púrpura pizarra oscuro profundo: base del tema oscuro.
  static const Color darkSlatePurple = Color(0xFF161426);

  /// Violeta apagado: color primario de la marca (ajustado para contraste WCAG AA con texto blanco).
  static const Color dustyViolet = Color(0xFF6852D6);

  /// Gris plata: texto principal y acentos del tema oscuro.
  static const Color silverCloud = Color(0xFFE2E1EC);

  /// Azul pizarra: color secundario de la marca (tono analítico, sustituye a plum).
  static const Color slateBlueSecondary = Color(0xFF4D6B8C);

  /// Lavanda muy claro: fondo del tema claro (limpio, clínico y neutral).
  static const Color lightLavenderBackground = Color(0xFFF5F4FA);

  /// Texto oscuro del tema claro (alto contraste y nitidez).
  static const Color darkText = Color(0xFF1E1A34);

  /// Superficie de las tarjetas en el tema oscuro (elevación neutra).
  static const Color darkSurface = Color(0xFF221F38);

  /// Texto secundario del tema oscuro.
  static const Color darkBodyMedium = Color(0xFFA5A2B8);

  /// Texto secundario del tema claro (gris púrpura suave).
  static const Color lightBodyMedium = Color(0xFF58546C);
}

final ThemeData lamantinDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: LamantinColors.darkSlatePurple,
  primaryColor: LamantinColors.dustyViolet,
  colorScheme: const ColorScheme.dark(
    primary: LamantinColors.dustyViolet,
    secondary: LamantinColors.slateBlueSecondary,
    tertiary: LamantinColors.silverCloud,
    surface: LamantinColors.darkSurface,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: LamantinColors.silverCloud,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: LamantinColors.silverCloud,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    bodyLarge: TextStyle(color: LamantinColors.silverCloud),
    bodyMedium: TextStyle(color: LamantinColors.darkBodyMedium),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: LamantinColors.darkSlatePurple,
    foregroundColor: LamantinColors.silverCloud,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LamantinColors.dustyViolet,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      elevation: 2,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LamantinColors.slateBlueSecondary,
    foregroundColor: Colors.white,
  ),
);

final ThemeData lamantinLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  // Fondo claro
  scaffoldBackgroundColor: LamantinColors.lightLavenderBackground,
  primaryColor: LamantinColors.dustyViolet, // Color de marca

  colorScheme: const ColorScheme.light(
    primary: LamantinColors.dustyViolet,
    secondary: LamantinColors.slateBlueSecondary,
    tertiary: LamantinColors.darkSlatePurple,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: LamantinColors.darkText,
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: LamantinColors.darkSlatePurple,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    bodyLarge: TextStyle(color: LamantinColors.darkText),
    bodyMedium: TextStyle(color: LamantinColors.lightBodyMedium),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: LamantinColors.dustyViolet,
    foregroundColor: Colors.white,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LamantinColors.slateBlueSecondary,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      elevation: 2,
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LamantinColors.darkSlatePurple,
    foregroundColor: Colors.white,
  ),
);
