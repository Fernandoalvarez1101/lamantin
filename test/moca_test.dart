import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  final moca = aplicacionDe('moca')!;

  test('MoCA: 28 ítems puntuables, 7 subescalas y máximo 30', () {
    expect(moca, isNotNull);
    expect(moca.preguntas, hasLength(28));
    expect(moca.subescalas, hasLength(7));
    // 28 puntuables + 1 complementaria (ajuste educacional).
    expect(moca.totalPreguntas, 29);

    // Máximo teórico = suma de la opción de mayor valor de cada ítem.
    final totalMaximo = moca
        .preguntas
        .map((p) => p.opciones.last.valor)
        .reduce((a, b) => a + b);
    expect(totalMaximo, 30);
  });

  test('MoCA: puntuación perfecta cae en "Dentro de lo esperado"', () {
    final respuestas = [
      for (final p in moca.preguntas) p.opciones.last.valor,
    ];
    final resultado = puntuarInstrumento(moca, respuestas);
    expect(resultado.total, 30);
    expect(resultado.rango.etiqueta, 'Dentro de lo esperado');
  });

  test('MoCA: puntuación 0 cae en "Por debajo del punto de corte"', () {
    final respuestas = List<int>.filled(28, 0);
    final resultado = puntuarInstrumento(moca, respuestas);
    expect(resultado.total, 0);
    expect(resultado.rango.etiqueta, 'Por debajo del punto de corte');
  });

  test('MoCA: la subescala de orientación suma sus 6 ítems', () {
    final respuestas = List<int>.filled(28, 0);
    // Orientación: índices 22..27.
    for (var i = 22; i <= 27; i++) {
      respuestas[i] = 1;
    }
    final resultado = puntuarInstrumento(moca, respuestas);
    final orientacion =
        resultado.subescalas.firstWhere((s) => s.nombre == 'Orientación');
    expect(orientacion.total, 6);
    expect(resultado.total, 6);
  });

  test('MoCA: la puntuación por dominios suma correctamente', () {
    final respuestas = [
      // 0-4 visuoespacial, 5-7 denominación, 8-12 memoria,
      // 13-16 atención, 17-19 lenguaje, 20-21 abstracción, 22-27 orientación.
      for (var i = 0; i < 28; i++) i < 16 ? 1 : 0,
    ];
    final resultado = puntuarInstrumento(moca, respuestas);
    // 16 Sí + serie de 7 (0) = 16 puntos.
    expect(resultado.total, 16);
    expect(resultado.rango.etiqueta, 'Por debajo del punto de corte');
  });
}
