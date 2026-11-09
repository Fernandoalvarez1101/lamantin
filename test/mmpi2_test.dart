import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  final mmpi = aplicacionDe('mmpi-2')!;

  test('MMPI-2: 14 ítems puntuables y 14 subescalas (una por escala)', () {
    expect(mmpi.preguntas, hasLength(14));
    expect(mmpi.subescalas, hasLength(14));
    expect(mmpi.totalPreguntas, 14);

    // El perfil se lee escala por escala: la puntuación total no se muestra.
    expect(mmpi.mostrarPuntuacionTotal, isFalse);
    expect(mmpi.rangos.first.etiqueta, 'Ver subescalas');

    // Cada escala es una subescala de un solo ítem y entre todas cubren
    // los 14 ítems sin repetir.
    final indices = mmpi.subescalas.expand((s) => s.indicesPregunta).toList()
      ..sort();
    expect(indices, List<int>.generate(14, (i) => i));
  });

  test('MMPI-2: cada ítem es una marca de elevación (T ≥ 65)', () {
    for (final pregunta in mmpi.preguntas) {
      expect(pregunta.opciones, hasLength(2));
      expect(pregunta.opciones.first.valor, 0);
      expect(pregunta.opciones.last.valor, 1);
      expect(pregunta.opciones.last.etiqueta, contains('T ≥ 65'));
    }

    final totalMaximo = mmpi.preguntas
        .map((p) => p.opciones.last.valor)
        .reduce((a, b) => a + b);
    expect(totalMaximo, 14);
  });

  test('MMPI-2: incluye las 4 escalas de validez y las 10 clínicas', () {
    final nombres = mmpi.subescalas.map((s) => s.nombre.split(' · ').first);

    expect(
      nombres,
      containsAll(<String>[
        'L',
        'F',
        'K',
        'VRIN / TRIN',
        'Hs',
        'D',
        'Hy',
        'Pd',
        'Mf',
        'Pa',
        'Pt',
        'Sc',
        'Ma',
        'Si',
      ]),
    );
  });

  test('MMPI-2: sin elevaciones no se activa ninguna alerta', () {
    final respuestas = List<int>.filled(14, 0);
    final resultado = puntuarInstrumento(mmpi, respuestas);

    expect(resultado.total, 0);
    expect(resultado.tieneAlertas, isFalse);
    for (final subescala in resultado.subescalas) {
      expect(subescala.rango.etiqueta, 'Sin elevación');
    }
  });

  test('MMPI-2: todas las escalas elevadas activan las alertas de validez', () {
    final respuestas = List<int>.filled(14, 1);
    final resultado = puntuarInstrumento(mmpi, respuestas);

    expect(resultado.total, 14);
    expect(resultado.tieneAlertas, isTrue);
    expect(resultado.alertasActivadas, hasLength(2));
    expect(resultado.alertasActivadas.first, contains('Escala F elevada'));
    expect(resultado.alertasActivadas.last, contains('VRIN/TRIN'));

    for (final subescala in resultado.subescalas) {
      expect(subescala.rango.etiqueta, 'Elevación clínica');
    }
  });

  test('MMPI-2: solo la escala F elevada dispara su alerta', () {
    final respuestas = List<int>.filled(14, 0);
    respuestas[1] = 1; // F (Infrecuencia)
    final resultado = puntuarInstrumento(mmpi, respuestas);

    expect(resultado.total, 1);
    expect(resultado.alertasActivadas, hasLength(1));
    expect(resultado.alertasActivadas.single, contains('Escala F elevada'));

    final escalaF =
        resultado.subescalas.firstWhere((s) => s.nombre.startsWith('F · '));
    expect(escalaF.total, 1);
    expect(escalaF.rango.etiqueta, 'Elevación clínica');

    final escalaD =
        resultado.subescalas.firstWhere((s) => s.nombre.startsWith('D · '));
    expect(escalaD.total, 0);
    expect(escalaD.rango.etiqueta, 'Sin elevación');
  });
}
