import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/assist.dart';
import 'package:lamantin/data/aplicaciones/audit.dart';
import 'package:lamantin/data/aplicaciones/cage.dart';
import 'package:lamantin/data/aplicaciones/crafft.dart';
import 'package:lamantin/data/aplicaciones/dast10.dart';
import 'package:lamantin/data/aplicaciones/isi.dart';
import 'package:lamantin/data/aplicaciones/psqi.dart';
import 'package:lamantin/data/aplicaciones/taps.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('AUDIT', () {
    test('Tiene 10 preguntas y puntúa en el rango 0-40', () {
      expect(auditAplicable.preguntas.length, 10);

      final r = puntuarInstrumento(auditAplicable, List.filled(10, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo riesgo');

      // 8 primeros a 4 (32) + 2 últimos a 4 (8) = 40.
      final maximo = [...List.filled(8, 4), 4, 4];
      final r2 = puntuarInstrumento(auditAplicable, maximo);
      expect(r2.total, 40);
      expect(r2.rango.etiqueta, 'Posible dependencia');
    });

    test('La suma de 8 cae en la zona de riesgo', () {
      final r = puntuarInstrumento(
        auditAplicable,
        [1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
      );
      expect(r.total, 8);
      expect(r.rango.etiqueta, 'Riesgo');
    });
  });

  group('CAGE', () {
    test('Puntúa 0-4 y usa el corte de 2', () {
      final r = puntuarInstrumento(cageAplicable, [1, 0, 0, 0]);
      expect(r.total, 1);
      expect(r.rango.etiqueta, 'Sin indicadores');

      final r2 = puntuarInstrumento(cageAplicable, [1, 1, 0, 0]);
      expect(r2.total, 2);
      expect(r2.rango.etiqueta, 'Probable problema');
    });
  });

  group('DAST-10', () {
    test('Puntúa con 2 ítems invertidos', () {
      // Sin problemas: «no» en todo, pero «sí» en los ítems 4 y 5.
      final sinProblemas = List.filled(10, 0);
      sinProblemas[3] = 1;
      sinProblemas[4] = 1;
      final r = puntuarInstrumento(dast10Aplicable, sinProblemas);
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Sin indicadores');

      // Máximo (10): «sí» en todo excepto en los invertidos.
      final maximo = List.filled(10, 1);
      maximo[3] = 0;
      maximo[4] = 0;
      final r2 = puntuarInstrumento(dast10Aplicable, maximo);
      expect(r2.total, 10);
      expect(r2.rango.etiqueta, 'Severo');
    });
  });

  group('CRAFFT', () {
    test('Puntúa 0-6 y usa el corte de 2', () {
      final r = puntuarInstrumento(crafftAplicable, List.filled(6, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Bajo riesgo');

      final r2 = puntuarInstrumento(crafftAplicable, [1, 1, 0, 0, 0, 0]);
      expect(r2.total, 2);
      expect(r2.rango.etiqueta, 'Riesgo alto');
    });
  });

  group('TAPS', () {
    test('Cualquier consumo positivo activa TAPS-2', () {
      final r = puntuarInstrumento(tapsAplicable, List.filled(4, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Sin consumo');

      final r2 = puntuarInstrumento(tapsAplicable, [0, 1, 0, 0]);
      expect(r2.total, 1);
      expect(r2.rango.etiqueta, 'Consumo positivo');
    });
  });

  group('ASSIST', () {
    test('Puntúa con los pesos de la OMS', () {
      final r = puntuarInstrumento(assistAplicable, List.filled(6, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Riesgo bajo');

      // Frecuencia a diario (6) y resto en 0 → riesgo moderado.
      final r2 = puntuarInstrumento(
        assistAplicable,
        [6, 0, 0, 0, 0, 0],
      );
      expect(r2.total, 6);
      expect(r2.rango.etiqueta, 'Riesgo moderado');

      // Todo al máximo (6) → 36 → riesgo alto.
      final r3 = puntuarInstrumento(assistAplicable, List.filled(6, 6));
      expect(r3.total, 36);
      expect(r3.rango.etiqueta, 'Riesgo alto');
    });
  });

  group('ISI', () {
    test('Puntúa en el rango 0-28', () {
      final r = puntuarInstrumento(isiAplicable, List.filled(7, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'No significativo');

      final r2 = puntuarInstrumento(isiAplicable, List.filled(7, 4));
      expect(r2.total, 28);
      expect(r2.rango.etiqueta, 'Severo');

      final r3 = puntuarInstrumento(isiAplicable, [3, 2, 2, 2, 2, 2, 2]);
      expect(r3.total, 15);
      expect(r3.rango.etiqueta, 'Moderado');
    });
  });

  group('PSQI', () {
    test('Usa el calculador personalizado de componentes', () {
      expect(psqiAplicable.preguntas.length, 17);
      expect(psqiAplicable.calcularPuntuacionPersonalizada, isNotNull);

      // Sueño bueno: todo en 0.
      final bueno = puntuarInstrumento(psqiAplicable, List.filled(17, 0));
      expect(bueno.total, 0);
      expect(bueno.rango.etiqueta, 'Buena calidad');

      // Sueño malo: todo en 3 → 7 componentes a 3 = 21.
      final malo = puntuarInstrumento(psqiAplicable, List.filled(17, 3));
      expect(malo.total, 21);
      expect(malo.rango.etiqueta, 'Mala calidad');
    });

    test('Calcula correctamente el componente de latencia', () {
      // Latencia: 16-30 min (1) + frecuencia «una o dos veces» (2) → 3 → C2 = 2.
      final r = [
        1, // calidad
        1, // latencia 16-30 min
        2, // frecuencia conciliar
        1, // duración 6-7 h
        0, // eficiencia
        ...List.filled(9, 0), // disturbios
        0, // medicación
        0, // despierto durante el día
        0, // ánimo
      ];
      final resultado = puntuarInstrumento(psqiAplicable, r);
      expect(resultado.total, 4); // C1(1) + C2(2) + C3(1) + resto 0
    });
  });
}
