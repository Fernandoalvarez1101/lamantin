import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/gad7.dart';
import 'package:lamantin/data/aplicaciones/pswq.dart';
import 'package:lamantin/data/aplicaciones/spin.dart';
import 'package:lamantin/data/aplicaciones/zung_sas.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('GAD-7', () {
    test('Tiene 7 preguntas con 4 opciones cada una', () {
      expect(gad7Aplicable.preguntas.length, 7);
      for (final pregunta in gad7Aplicable.preguntas) {
        expect(pregunta.opciones.length, 4);
      }
    });

    test('Puntúa en el rango 0-21', () {
      final r = puntuarInstrumento(gad7Aplicable, List.filled(7, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Mínima');

      final r2 = puntuarInstrumento(gad7Aplicable, List.filled(7, 3));
      expect(r2.total, 21);
      expect(r2.rango.etiqueta, 'Grave');

      // Suma 10 → moderada.
      final r3 = puntuarInstrumento(
        gad7Aplicable,
        [1, 1, 1, 1, 1, 2, 3],
      );
      expect(r3.total, 10);
      expect(r3.rango.etiqueta, 'Moderada');
    });
  });

  group('Zung SAS', () {
    test('Tiene 20 preguntas con 5 ítems invertidos', () {
      expect(zungSasAplicable.preguntas.length, 20);
      expect(
        zungSasAplicable.preguntas.where((p) => p.invertida).length,
        5,
      );
    });

    test('Puntúa en el rango 20-80 con inversión', () {
      // Mínimo (20): negativos «rara vez», positivos «casi siempre».
      final minimo = List.filled(20, 1);
      for (final i in [4, 8, 12, 16, 18]) {
        minimo[i] = 4;
      }
      final r = puntuarInstrumento(zungSasAplicable, minimo);
      expect(r.total, 20);
      expect(r.rango.etiqueta, 'Normal');

      // Máximo (80): negativos «siempre», positivos «rara vez».
      final maximo = List.filled(20, 4);
      for (final i in [4, 8, 12, 16, 18]) {
        maximo[i] = 1;
      }
      final r2 = puntuarInstrumento(zungSasAplicable, maximo);
      expect(r2.total, 80);
      expect(r2.rango.etiqueta, 'Extrema');
    });
  });

  group('SPIN', () {
    test('Tiene 17 preguntas y puntúa en el rango 0-68', () {
      expect(spinAplicable.preguntas.length, 17);

      final r = puntuarInstrumento(spinAplicable, List.filled(17, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      final r2 = puntuarInstrumento(spinAplicable, List.filled(17, 4));
      expect(r2.total, 68);
      expect(r2.rango.etiqueta, 'Severa');
    });

    test('El punto de corte 19 marca fobia social probable', () {
      final respuestas = List.filled(17, 1);
      respuestas[0] = 3; // suma 19
      final r = puntuarInstrumento(spinAplicable, respuestas);
      expect(r.total, 19);
      expect(r.rango.etiqueta, 'Probable fobia social');
    });
  });

  group('PSWQ', () {
    test('Tiene 16 preguntas con 5 ítems invertidos', () {
      expect(pswqAplicable.preguntas.length, 16);
      expect(
        pswqAplicable.preguntas.where((p) => p.invertida).length,
        5,
      );
    });

    test('Puntúa en el rango 16-80 con inversión', () {
      // Mínimo (16): negativos «nada típico», positivos «totalmente típico».
      final minimo = List.filled(16, 1);
      for (final i in [0, 2, 7, 9, 10]) {
        minimo[i] = 5;
      }
      final r = puntuarInstrumento(pswqAplicable, minimo);
      expect(r.total, 16);
      expect(r.rango.descriptiva, isTrue);

      // Máximo (80): negativos «totalmente típico», positivos «nada típico».
      final maximo = List.filled(16, 5);
      for (final i in [0, 2, 7, 9, 10]) {
        maximo[i] = 1;
      }
      final r2 = puntuarInstrumento(pswqAplicable, maximo);
      expect(r2.total, 80);
      expect(r2.rango.descriptiva, isTrue);
    });
  });
}
