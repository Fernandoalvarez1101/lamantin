import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/cesdc.dart';
import 'package:lamantin/data/aplicaciones/cssrs.dart';
import 'package:lamantin/data/aplicaciones/mfq.dart';
import 'package:lamantin/data/aplicaciones/sbqr.dart';
import 'package:lamantin/data/aplicaciones/scared.dart';
import 'package:lamantin/data/aplicaciones/sdq.dart';
import 'package:lamantin/data/aplicaciones/snap_iv.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('CES-DC', () {
    test('Tiene 20 preguntas con 4 ítems invertidos', () {
      expect(cesdcAplicable.preguntas.length, 20);
      expect(cesdcAplicable.preguntas.where((p) => p.invertida).length, 4);
    });

    test('Puntúa correctamente con inversión', () {
      // Sin síntomas: 0 en negativos, 3 en los positivos.
      final sinSintomas = List.filled(20, 0);
      for (final i in [3, 7, 11, 15]) {
        sinSintomas[i] = 3;
      }
      final r = puntuarInstrumento(cesdcAplicable, sinSintomas);
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Sin síntomas');

      // Máximo: 3 en negativos, 0 en positivos.
      final maximo = List.filled(20, 3);
      for (final i in [3, 7, 11, 15]) {
        maximo[i] = 0;
      }
      final r2 = puntuarInstrumento(cesdcAplicable, maximo);
      expect(r2.total, 60);
      expect(r2.rango.etiqueta, 'Síntomas clínicamente significativos');
    });
  });

  group('MFQ', () {
    test('Puntúa en el rango 0-26', () {
      final r = puntuarInstrumento(mfqAplicable, List.filled(13, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      final r2 = puntuarInstrumento(mfqAplicable, List.filled(13, 2));
      expect(r2.total, 26);
      expect(r2.rango.etiqueta, 'Probable');

      // Suma 8 → posible.
      final r3 = puntuarInstrumento(
        mfqAplicable,
        [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
      );
      expect(r3.total, 8);
      expect(r3.rango.etiqueta, 'Posible');
    });
  });

  group('SNAP-IV', () {
    test('Calcula las 3 subescalas', () {
      expect(snapIvAplicable.preguntas.length, 26);

      final r = puntuarInstrumento(snapIvAplicable, List.filled(26, 0));
      expect(r.subescalas.length, 3);
      expect(r.subescalas.first.total, 0);

      // Inatención al máximo.
      final respuestas = List.filled(26, 0);
      for (var i = 0; i < 9; i++) {
        respuestas[i] = 3;
      }
      final r2 = puntuarInstrumento(snapIvAplicable, respuestas);
      final inatencion =
          r2.subescalas.firstWhere((s) => s.nombre == 'Inatención');
      expect(inatencion.total, 27);
      expect(inatencion.rango.etiqueta, 'Sobre el corte');
    });
  });

  group('SDQ', () {
    test('Calcula el total de dificultades y 5 subescalas', () {
      expect(sdqAplicable.preguntas.length, 25);

      // Sin dificultades: negativos en 0, los invertidos en 2.
      final sinDificultades = List.filled(25, 0);
      for (final i in [6, 10, 13, 20, 24]) {
        sinDificultades[i] = 2;
      }
      final r = puntuarInstrumento(sdqAplicable, sinDificultades);
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Normal');
      expect(r.subescalas.length, 5);

      // Todo en 2 → dificultades altas (prosocial no cuenta).
      final r2 = puntuarInstrumento(sdqAplicable, List.filled(25, 2));
      expect(r2.total, 30);
      expect(r2.rango.etiqueta, 'Anormal');
    });
  });

  group('SCARED', () {
    test('Puntúa en el rango 0-82 con 5 subescalas', () {
      expect(scaredAplicable.preguntas.length, 41);

      final r = puntuarInstrumento(scaredAplicable, List.filled(41, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');
      expect(r.subescalas.length, 5);

      final r2 = puntuarInstrumento(scaredAplicable, List.filled(41, 2));
      expect(r2.total, 82);
      expect(r2.rango.etiqueta, 'Alto');

      // 13 ítems en 2 = 26 → sobre el corte (≥ 25).
      final respuestas = List.filled(41, 0);
      for (var i = 0; i < 13; i++) {
        respuestas[i] = 2;
      }
      final r3 = puntuarInstrumento(scaredAplicable, respuestas);
      expect(r3.total, 26);
      expect(r3.rango.etiqueta, 'Moderado');
    });
  });

  group('C-SSRS', () {
    test('Cualquier respuesta positiva activa alerta', () {
      final r = puntuarInstrumento(cSsrsAplicable, List.filled(6, 0));
      expect(r.total, 0);
      expect(r.tieneAlertas, isFalse);
      expect(r.rango.etiqueta, 'Sin riesgo reportado');

      final r2 = puntuarInstrumento(cSsrsAplicable, [1, 0, 0, 0, 0, 0]);
      expect(r2.total, 1);
      expect(r2.tieneAlertas, isTrue);
      expect(r2.rango.etiqueta, 'Riesgo presente');

      final r3 = puntuarInstrumento(cSsrsAplicable, List.filled(6, 1));
      expect(r3.total, 6);
      expect(r3.alertasActivadas.length, 6);
      expect(r3.rango.etiqueta, 'Riesgo alto');
    });
  });

  group('SBQ-R', () {
    test('Puntúa en el rango 3-18 y usa el corte de 7', () {
      final r = puntuarInstrumento(sbqRAplicable, [1, 1, 1, 0]);
      expect(r.total, 3);
      expect(r.rango.etiqueta, 'Bajo');

      final r2 = puntuarInstrumento(sbqRAplicable, [1, 2, 1, 3]);
      expect(r2.total, 7);
      expect(r2.rango.etiqueta, 'Riesgo presente');

      final r3 = puntuarInstrumento(sbqRAplicable, [3, 1, 1, 0]);
      expect(r3.total, 5);
      expect(r3.tieneAlertas, isTrue);
      expect(r3.alertasActivadas.single, contains('historia'));
    });
  });
}
