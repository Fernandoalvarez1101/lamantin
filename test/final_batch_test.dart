import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/asrs.dart';
import 'package:lamantin/data/aplicaciones/bfi44.dart';
import 'package:lamantin/data/aplicaciones/dass21.dart';
import 'package:lamantin/data/aplicaciones/k10.dart';
import 'package:lamantin/data/aplicaciones/mspss.dart';
import 'package:lamantin/data/aplicaciones/onet_ip.dart';
import 'package:lamantin/data/aplicaciones/rses.dart';
import 'package:lamantin/data/aplicaciones/srq20.dart';
import 'package:lamantin/data/aplicaciones/ucla20.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('RSES', () {
    test('Puntúa en el rango 10-40 con 5 ítems invertidos', () {
      // Autoestima alta: positivos a 4, invertidos a 1.
      final alta = List.filled(10, 1);
      for (final i in [0, 1, 3, 5, 6]) {
        alta[i] = 4;
      }
      final r = puntuarInstrumento(rsesAplicable, alta);
      expect(r.total, 40);
      expect(r.rango.descriptiva, isTrue);

      // Autoestima baja: positivos a 1, invertidos a 4.
      final baja = List.filled(10, 4);
      for (final i in [0, 1, 3, 5, 6]) {
        baja[i] = 1;
      }
      final r2 = puntuarInstrumento(rsesAplicable, baja);
      expect(r2.total, 10);
      expect(r2.rango.descriptiva, isTrue);
    });
  });

  group('K10', () {
    test('Puntúa en el rango 10-50', () {
      final r = puntuarInstrumento(k10Aplicable, List.filled(10, 1));
      expect(r.total, 10);
      expect(r.rango.etiqueta, 'Bajo');

      final r2 = puntuarInstrumento(k10Aplicable, List.filled(10, 5));
      expect(r2.total, 50);
      expect(r2.rango.etiqueta, 'Alto');

      final r3 = puntuarInstrumento(k10Aplicable, List.filled(10, 3));
      expect(r3.total, 30);
      expect(r3.rango.etiqueta, 'Alto');
    });
  });

  group('SRQ-20', () {
    test('Puntúa 0-20 y alerta por el ítem 17', () {
      final r = puntuarInstrumento(srq20Aplicable, List.filled(20, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      final respuestas = List.filled(20, 0);
      respuestas[16] = 1; // ítem 17
      final r2 = puntuarInstrumento(srq20Aplicable, respuestas);
      expect(r2.total, 1);
      expect(r2.tieneAlertas, isTrue);
      expect(r2.alertasActivadas.single, contains('ítem 17'));
    });
  });

  group('UCLA-20', () {
    test('Puntúa con 10 ítems invertidos', () {
      // Soledad baja: negativos a 1, positivos a 4.
      final baja = List.filled(20, 4);
      for (final i in [1, 2, 3, 6, 7, 10, 12, 13, 16, 17]) {
        baja[i] = 1;
      }
      final r = puntuarInstrumento(ucla20Aplicable, baja);
      expect(r.total, 20);
      expect(r.rango.descriptiva, isTrue);

      // Soledad alta: negativos a 4, positivos a 1.
      final alta = List.filled(20, 1);
      for (final i in [1, 2, 3, 6, 7, 10, 12, 13, 16, 17]) {
        alta[i] = 4;
      }
      final r2 = puntuarInstrumento(ucla20Aplicable, alta);
      expect(r2.total, 80);
      expect(r2.rango.descriptiva, isTrue);
    });
  });

  group('MSPSS', () {
    test('Calcula el total y las 3 subescalas', () {
      final r = puntuarInstrumento(mspssAplicable, List.filled(12, 1));
      expect(r.total, 12);
      expect(r.rango.descriptiva, isTrue);
      expect(r.subescalas.length, 3);

      final r2 = puntuarInstrumento(mspssAplicable, List.filled(12, 7));
      expect(r2.total, 84);
      expect(r2.rango.descriptiva, isTrue);
      expect(r2.subescalas.every((s) => s.total == 28), isTrue);
    });
  });

  group('ASRS', () {
    test('Cuenta los ítems positivos de la parte A', () {
      expect(asrsAplicable.preguntas.length, 6);
      expect(asrsAplicable.preguntasComplementarias.length, 12);

      final r = puntuarInstrumento(asrsAplicable, List.filled(6, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Negativo');

      // Ítems 1-3 a 3 y ítems 4-6 a 2 → los 6 positivos.
      final positivo = [3, 3, 3, 2, 2, 2];
      final r2 = puntuarInstrumento(asrsAplicable, positivo);
      expect(r2.total, 6);
      expect(r2.rango.etiqueta, 'Positivo');
    });
  });

  group('O*NET IP', () {
    test('Calcula las 6 escalas RIASEC', () {
      expect(onetIpAplicable.preguntas.length, 30);

      final r = puntuarInstrumento(onetIpAplicable, List.filled(30, 0));
      expect(r.subescalas.length, 6);
      expect(r.subescalas.every((s) => s.total == 0), isTrue);

      // Perfil social: solo los ítems 16-20 positivos.
      final respuestas = List.filled(30, 0);
      for (var i = 15; i < 20; i++) {
        respuestas[i] = 1;
      }
      final r2 = puntuarInstrumento(onetIpAplicable, respuestas);
      final social = r2.subescalas.firstWhere((s) => s.nombre == 'Social (S)');
      expect(social.total, 5);
      expect(social.rango.descriptiva, isTrue);
    });
  });

  group('BFI-44', () {
    test('Usa la clave estándar de inversión y muestra puntuación descriptiva',
        () {
      expect(bfi44Aplicable.preguntas.length, 44);

      // Clave estándar de inversión (16 ítems en total).
      final invertidos = <int>[
        5, 20, 30, // E: 6, 21, 31
        1, 11, 26, 36, // A: 2, 12, 27, 37
        7, 17, 22, 42, // C: 8, 18, 23, 43
        8, 23, 33, // N: 9, 24, 34
        34, 40, // O: 35, 41
      ];
      expect(
        bfi44Aplicable.preguntas.where((p) => p.invertida).length,
        invertidos.length,
      );
      // El ítem 22 («Generalmente es confiado») y el 28 («Persevera…»)
      // NO se invierten.
      expect(bfi44Aplicable.preguntas[21].invertida, isFalse);
      expect(bfi44Aplicable.preguntas[27].invertida, isFalse);

      final r = puntuarInstrumento(bfi44Aplicable, List.filled(44, 1));
      expect(r.subescalas.length, 5);
      // Sin etiqueta categórica: subescalas descriptivas.
      expect(r.subescalas.every((s) => s.rango.descriptiva), isTrue);
      expect(r.subescalas.every((s) => s.cantidadItems > 0), isTrue);

      // Extraversión máxima: 40 puntos en 8 ítems → media por ítem 5.00.
      final respuestas = List.filled(44, 1);
      for (final i in [0, 5, 10, 15, 20, 25, 30, 35]) {
        respuestas[i] = 5;
      }
      respuestas[5] = 1;
      respuestas[20] = 1;
      respuestas[30] = 1;
      final r2 = puntuarInstrumento(bfi44Aplicable, respuestas);
      final extraversion =
          r2.subescalas.firstWhere((s) => s.nombre == 'Extraversión');
      expect(extraversion.total, 40);
      expect(extraversion.cantidadItems, 8);
      expect(extraversion.rango.descriptiva, isTrue);
      expect(extraversion.rango.etiqueta, 'Descriptivo');
      expect((extraversion.total / extraversion.cantidadItems), 5.0);
    });
  });

  group('DASS-21', () {
    test('Duplica las subescalas y aplica los cortes del manual', () {
      expect(dass21Aplicable.preguntas.length, 21);

      final r = puntuarInstrumento(dass21Aplicable, List.filled(21, 0));
      expect(r.subescalas.length, 3);
      expect(r.subescalas.every((s) => s.total == 0), isTrue);

      // Depresión al máximo: 7 ítems a 3 → 21 × 2 = 42 → muy severa.
      final respuestas = List.filled(21, 0);
      for (final i in [2, 4, 9, 12, 15, 16, 20]) {
        respuestas[i] = 3;
      }
      final r2 = puntuarInstrumento(dass21Aplicable, respuestas);
      final depresion =
          r2.subescalas.firstWhere((s) => s.nombre == 'Depresión');
      expect(depresion.total, 42);
      expect(depresion.rango.etiqueta, 'Muy severa');
    });
  });
}
