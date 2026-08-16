import 'package:flutter/material.dart';

import '../../models/categoria_instrumento.dart';
import '../../theme.dart';

/// Color de marca asociado a cada categoría (cicla la paleta de Lamantin).
Color colorDeCategoria(CategoriaInstrumento categoria) {
  switch (categoria) {
    case CategoriaInstrumento.depresion:
    case CategoriaInstrumento.trauma:
    case CategoriaInstrumento.sueno:
    case CategoriaInstrumento.bienestar:
    case CategoriaInstrumento.riesgoSuicida:
    case CategoriaInstrumento.regulacionEmocional:
      return LamantinColors.dustyViolet;
    case CategoriaInstrumento.ansiedad:
    case CategoriaInstrumento.vocacional:
    case CategoriaInstrumento.adicciones:
    case CategoriaInstrumento.atencion:
    case CategoriaInstrumento.infantoJuvenil:
    case CategoriaInstrumento.neurocognitivo:
      return LamantinColors.slateBlueSecondary;
    case CategoriaInstrumento.estres:
    case CategoriaInstrumento.autoestima:
    case CategoriaInstrumento.personalidad:
    case CategoriaInstrumento.saludMentalGeneral:
    case CategoriaInstrumento.apoyoSocialSoledad:
      return LamantinColors.darkSlatePurple;
  }
}

/// Icono representativo de cada categoría.
IconData iconoDeCategoria(CategoriaInstrumento categoria) {
  switch (categoria) {
    case CategoriaInstrumento.depresion:
      return Icons.mood_bad_outlined;
    case CategoriaInstrumento.ansiedad:
      return Icons.psychology_outlined;
    case CategoriaInstrumento.estres:
      return Icons.self_improvement_outlined;
    case CategoriaInstrumento.trauma:
      return Icons.healing_outlined;
    case CategoriaInstrumento.vocacional:
      return Icons.work_outline;
    case CategoriaInstrumento.autoestima:
      return Icons.favorite_outline;
    case CategoriaInstrumento.sueno:
      return Icons.bedtime_outlined;
    case CategoriaInstrumento.adicciones:
      return Icons.science_outlined;
    case CategoriaInstrumento.personalidad:
      return Icons.diversity_3_outlined;
    case CategoriaInstrumento.bienestar:
      return Icons.mood_outlined;
    case CategoriaInstrumento.atencion:
      return Icons.visibility_outlined;
    case CategoriaInstrumento.saludMentalGeneral:
      return Icons.fact_check_outlined;
    case CategoriaInstrumento.riesgoSuicida:
      return Icons.crisis_alert_outlined;
    case CategoriaInstrumento.infantoJuvenil:
      return Icons.child_care_outlined;
    case CategoriaInstrumento.apoyoSocialSoledad:
      return Icons.handshake_outlined;
    case CategoriaInstrumento.regulacionEmocional:
      return Icons.psychology_alt_outlined;
    case CategoriaInstrumento.neurocognitivo:
      return Icons.memory_outlined;
  }
}
