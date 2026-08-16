import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/cesd.dart';
import 'package:lamantin/data/aplicaciones/cudos.dart';
import 'package:lamantin/data/aplicaciones/epds.dart';
import 'package:lamantin/data/aplicaciones/gds15.dart';
import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/data/aplicaciones/zung_sds.dart';
import 'package:lamantin/data/catalogo_instrumentos.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  test('Todas las aplicaciones registradas existen en el catálogo', () {
    expect(aplicacionesDisponibles.length, greaterThanOrEqualTo(6));
    for (final id in aplicacionesDisponibles.keys) {
      expect(
        catalogoInstrumentos.any((instrumento) => instrumento.id == id),
        isTrue,
        reason: 'El id $id no existe en el catálogo.',
      );
    }
  });

  group('CES-D', () {
    test('Tiene 20 preguntas con 4 ítems invertidos', () {
      expect(cesdAplicable.preguntas.length, 20);
      expect(
        cesdAplicable.preguntas.where((p) => p.invertida).length,
        4,
      );
    });

    test('Puntúa correctamente los ítems invertidos', () {
      // Patrón sin síntomas: 0 en negativos, 3 en los positivos.
      final respuestas = List.filled(20, 0);
      for (final i in [3, 7, 11, 15]) {
        respuestas[i] = 3;
      }
      final r = puntuarInstrumento(cesdAplicable, respuestas);
      expect(r.total, 0);

      // Patrón de máxima sintomatología: 3 en negativos, 0 en positivos.
      final altas = List.filled(20, 3);
      for (final i in [3, 7, 11, 15]) {
        altas[i] = 0;
      }
      final r2 = puntuarInstrumento(cesdAplicable, altas);
      expect(r2.total, 60);
      expect(r2.rango.etiqueta, 'Síntomas clínicamente significativos');
    });
  });

  group('GDS-15', () {
    test('Puntúa correctamente los ítems invertidos', () {
      // Sin síntomas: «No» en negativos y «Sí» en los positivos.
      final respuestas = List.filled(15, 0);
      for (final i in [0, 4, 6, 10, 12]) {
        respuestas[i] = 1;
      }
      final r = puntuarInstrumento(gds15Aplicable, respuestas);
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Normal');

      // Todo «Sí»: los positivos no suman (se invierten).
      final r2 = puntuarInstrumento(gds15Aplicable, List.filled(15, 1));
      expect(r2.total, 10);
      expect(r2.rango.etiqueta, 'Moderada');
    });
  });

  group('Zung SDS', () {
    test('Puntúa en el rango 20-80 con inversión de 10 ítems', () {
      // Mínimo (20): negativos «rara vez», positivos «casi siempre».
      final minimo = List.filled(20, 1);
      for (final i in [1, 4, 5, 10, 11, 13, 15, 16, 17, 19]) {
        minimo[i] = 4;
      }
      final r = puntuarInstrumento(zungSdsAplicable, minimo);
      expect(r.total, 20);
      expect(r.rango.etiqueta, 'Normal');

      // Máximo (80): negativos «siempre», positivos «rara vez».
      final maximo = List.filled(20, 4);
      for (final i in [1, 4, 5, 10, 11, 13, 15, 16, 17, 19]) {
        maximo[i] = 1;
      }
      final r2 = puntuarInstrumento(zungSdsAplicable, maximo);
      expect(r2.total, 80);
      expect(r2.rango.etiqueta, 'Grave');
    });
  });

  group('EPDS', () {
    test('Puntúa y activa alerta en el ítem 10', () {
      final r = puntuarInstrumento(epdsAplicable, List.filled(10, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Baja');

      final respuestas = List.filled(10, 0);
      respuestas[9] = 1;
      final r2 = puntuarInstrumento(epdsAplicable, respuestas);
      expect(r2.tieneAlertas, isTrue);
      expect(r2.alertasActivadas.single, contains('ítem 10'));
    });
  });

  group('CUDOS', () {
    test('Puntúa y activa alertas en los ítems de riesgo', () {
      expect(cudosAplicable.preguntas.length, 18);

      final r = puntuarInstrumento(cudosAplicable, List.filled(18, 0));
      expect(r.total, 0);
      expect(r.rango.etiqueta, 'Mínima');

      final respuestas = List.filled(18, 0);
      respuestas[8] = 2; // ítem 9
      respuestas[16] = 1; // ítem 17
      final r2 = puntuarInstrumento(cudosAplicable, respuestas);
      expect(r2.alertasActivadas.length, 2);
    });
  });
}
