import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/dar5.dart';
import 'package:lamantin/data/aplicaciones/iesr.dart';
import 'package:lamantin/data/aplicaciones/pcl5.dart';
import 'package:lamantin/data/aplicaciones/pss10.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('PSS-10', () {
    test('Tiene 10 preguntas con 4 ítems invertidos', () {
      expect(pss10Aplicable.preguntas.length, 10);
      expect(
        pss10Aplicable.preguntas.where((p) => p.invertida).length,
        4,
      );
    });

    test('Puntúa en el rango 0-40 con inversión', () {
      // Estrés bajo: negativos «nunca», positivos «muy a menudo».
      final minimo = List.filled(10, 0);
      for (final i in [3, 4, 6, 7]) {
        minimo[i] = 4;
      }
      final r = puntuarInstrumento(pss10Aplicable, minimo);
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      // Estrés alto: negativos «muy a menudo», positivos «nunca».
      final maximo = List.filled(10, 4);
      for (final i in [3, 4, 6, 7]) {
        maximo[i] = 0;
      }
      final r2 = puntuarInstrumento(pss10Aplicable, maximo);
      expect(r2.total, 40);
      expect(r2.rango.etiqueta, 'Alto');
    });
  });

  group('PCL-5', () {
    test('Tiene 20 preguntas y puntúa en el rango 0-80', () {
      expect(pcl5Aplicable.preguntas.length, 20);

      final r = puntuarInstrumento(pcl5Aplicable, List.filled(20, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      final r2 = puntuarInstrumento(pcl5Aplicable, List.filled(20, 4));
      expect(r2.total, 80);
      expect(r2.rango.etiqueta, 'Severo');
    });

    test('El punto de corte 33 marca probable TEPT', () {
      final respuestas = List.filled(20, 0);
      for (var i = 0; i < 8; i++) {
        respuestas[i] = 4; // 32 puntos
      }
      respuestas[8] = 1; // 33 puntos
      final r = puntuarInstrumento(pcl5Aplicable, respuestas);
      expect(r.total, 33);
      expect(r.rango.etiqueta, 'Moderado');
    });
  });

  group('IES-R', () {
    test('Tiene 22 preguntas y puntúa en el rango 0-88', () {
      expect(iesrAplicable.preguntas.length, 22);

      final r = puntuarInstrumento(iesrAplicable, List.filled(22, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      final r2 = puntuarInstrumento(iesrAplicable, List.filled(22, 4));
      expect(r2.total, 88);
      expect(r2.rango.etiqueta, 'Alto');
    });
  });

  group('DAR-5', () {
    test('Tiene 5 preguntas y puntúa en el rango 0-20', () {
      expect(dar5Aplicable.preguntas.length, 5);

      final r = puntuarInstrumento(dar5Aplicable, List.filled(5, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Baja');

      final r2 = puntuarInstrumento(dar5Aplicable, List.filled(5, 4));
      expect(r2.total, 20);
      expect(r2.rango.etiqueta, 'Clínicamente significativa');
    });

    test('El punto de corte 12 marca ira clínicamente significativa', () {
      final respuestas = List.filled(5, 2); // 10 puntos
      respuestas[4] = 4; // 12 puntos
      final r = puntuarInstrumento(dar5Aplicable, respuestas);
      expect(r.total, 12);
      expect(r.rango.etiqueta, 'Clínicamente significativa');
    });
  });
}
