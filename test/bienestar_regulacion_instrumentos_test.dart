import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/erq.dart';
import 'package:lamantin/data/aplicaciones/escala_florecimiento.dart';
import 'package:lamantin/data/aplicaciones/lotr.dart';
import 'package:lamantin/data/aplicaciones/maas.dart';
import 'package:lamantin/data/aplicaciones/panas.dart';
import 'package:lamantin/data/aplicaciones/swls.dart';
import 'package:lamantin/data/aplicaciones/whoqol_bref.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('SWLS', () {
    test('Puntúa en el rango 5-35', () {
      final r = puntuarInstrumento(swlsAplicable, List.filled(5, 1));
      expect(r.total, 5);
      expect(r.rango.etiqueta, 'Muy insatisfecho');

      final r2 = puntuarInstrumento(swlsAplicable, List.filled(5, 7));
      expect(r2.total, 35);
      expect(r2.rango.etiqueta, 'Muy satisfecho');

      final r3 = puntuarInstrumento(swlsAplicable, List.filled(5, 4));
      expect(r3.total, 20);
      expect(r3.rango.etiqueta, 'Neutro');
    });
  });

  group('LOT-R', () {
    test('Omite los ítems de relleno y puntúa los 6 restantes', () {
      expect(lotrAplicable.preguntas.length, 10);
      expect(
        lotrAplicable.preguntas.where((p) => !p.puntuable).length,
        4,
      );

      // Pesimista: positivos a 0 y los invertidos a 4 (invierten a 0).
      final pesimista = List.filled(10, 0);
      pesimista[2] = 4;
      pesimista[6] = 4;
      pesimista[8] = 4;
      final r = puntuarInstrumento(lotrAplicable, pesimista);
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo');

      // Optimista: positivos a 4 y los invertidos a 0 (invierten a 4).
      final optimista = List.filled(10, 0);
      optimista[0] = 4;
      optimista[3] = 4;
      optimista[9] = 4;
      final r2 = puntuarInstrumento(lotrAplicable, optimista);
      expect(r2.total, 24);
      expect(r2.rango.etiqueta, 'Alto');
    });
  });

  group('Escala de Florecimiento', () {
    test('Puntúa en el rango 8-56', () {
      final r = puntuarInstrumento(
        escalaFlorecimientoAplicable,
        List.filled(8, 1),
      );
      expect(r.total, 8);
      expect(r.rango.descriptiva, isTrue);

      final r2 = puntuarInstrumento(
        escalaFlorecimientoAplicable,
        List.filled(8, 7),
      );
      expect(r2.total, 56);
      expect(r2.rango.descriptiva, isTrue);
    });
  });

  group('PANAS', () {
    test('Calcula las subescalas de afecto positivo y negativo', () {
      expect(panasAplicable.preguntas.length, 20);

      // Afecto positivo alto (50), negativo bajo (10).
      final respuestas = List.filled(20, 1);
      for (final i in [0, 2, 4, 8, 9, 11, 13, 15, 16, 18]) {
        respuestas[i] = 5;
      }
      final r = puntuarInstrumento(panasAplicable, respuestas);
      expect(r.subescalas.length, 2);

      final positivo =
          r.subescalas.firstWhere((s) => s.nombre == 'Afecto positivo');
      final negativo =
          r.subescalas.firstWhere((s) => s.nombre == 'Afecto negativo');
      expect(positivo.total, 50);
      expect(positivo.rango.descriptiva, isTrue);
      expect(negativo.total, 10);
      expect(negativo.rango.descriptiva, isTrue);
    });
  });

  group('ERQ', () {
    test('Calcula las subescalas de reevaluación y supresión', () {
      expect(erqAplicable.preguntas.length, 10);

      // Reevaluación al máximo (42), supresión al mínimo (4).
      final respuestas = List.filled(10, 1);
      for (final i in [0, 2, 4, 6, 7, 9]) {
        respuestas[i] = 7;
      }
      final r = puntuarInstrumento(erqAplicable, respuestas);
      expect(r.subescalas.length, 2);

      final reevaluacion =
          r.subescalas.firstWhere((s) => s.nombre == 'Reevaluación cognitiva');
      final supresion =
          r.subescalas.firstWhere((s) => s.nombre == 'Supresión expresiva');
      expect(reevaluacion.total, 42);
      expect(reevaluacion.rango.descriptiva, isTrue);
      expect(supresion.total, 4);
      expect(supresion.rango.descriptiva, isTrue);
    });
  });

  group('MAAS', () {
    test('Puntúa en el rango 15-90', () {
      final r = puntuarInstrumento(maasAplicable, List.filled(15, 1));
      expect(r.total, 15);
      expect(r.rango.descriptiva, isTrue);

      final r2 = puntuarInstrumento(maasAplicable, List.filled(15, 6));
      expect(r2.total, 90);
      expect(r2.rango.descriptiva, isTrue);
    });
  });

  group('WHOQOL-BREF', () {
    test('Transforma cada dominio a la escala 4-20', () {
      expect(whoqolBrefAplicable.preguntas.length, 26);

      // Mejor calidad de vida: todo 5, excepto los invertidos a 1.
      final mejor = List.filled(26, 5);
      mejor[2] = 1;
      mejor[3] = 1;
      mejor[25] = 1;
      final r = puntuarInstrumento(whoqolBrefAplicable, mejor);
      expect(r.subescalas.length, 4);
      for (final dominio in r.subescalas) {
        expect(dominio.total, 20);
        expect(dominio.rango.descriptiva, isTrue);
      }

      // Peor calidad de vida: todo 1, excepto los invertidos a 5.
      final peor = List.filled(26, 1);
      peor[2] = 5;
      peor[3] = 5;
      peor[25] = 5;
      final r2 = puntuarInstrumento(whoqolBrefAplicable, peor);
      for (final dominio in r2.subescalas) {
        expect(dominio.total, 4);
        expect(dominio.rango.descriptiva, isTrue);
      }
    });
  });
}
