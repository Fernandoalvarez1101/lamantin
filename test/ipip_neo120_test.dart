import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  final ipip = aplicacionDe('ipip-neo-120')!;

  test('IPIP-NEO-120: 120 ítems Likert 1-5, 30 facetas y 5 dominios', () {
    expect(ipip, isNotNull);
    expect(ipip.preguntas, hasLength(120));
    // 30 facetas + 5 dominios.
    expect(ipip.subescalas, hasLength(35));
    // Todos los ítems son puntuables y la escala es 1-5.
    expect(ipip.preguntas.every((p) => p.puntuable), isTrue);
    expect(ipip.preguntas.first.opciones.first.valor, 1);
    expect(ipip.preguntas.first.opciones.last.valor, 5);
    // 55 ítems invertidos (clave del IPIP-NEO-120).
    expect(ipip.preguntas.where((p) => p.invertida), hasLength(55));
  });

  test(
      'IPIP-NEO-120: cada ítem pertenece a una única faceta y un único '
      'dominio', () {
    final facetas =
        ipip.subescalas.where((s) => s.indicesPregunta.length == 4).toList();
    final dominios =
        ipip.subescalas.where((s) => s.indicesPregunta.length == 24).toList();
    expect(facetas, hasLength(30));
    expect(dominios, hasLength(5));

    // Las 30 facetas cubren los 120 ítems, cada uno exactamente una vez.
    final enFacetas = <int>[];
    for (final f in facetas) {
      enFacetas.addAll(f.indicesPregunta);
    }
    expect(enFacetas.length, 120);
    for (var i = 0; i < 120; i++) {
      expect(enFacetas.where((idx) => idx == i), hasLength(1));
    }

    // Los 5 dominios también cubren los 120 ítems exactamente una vez.
    final enDominios = <int>[];
    for (final d in dominios) {
      enDominios.addAll(d.indicesPregunta);
    }
    expect(enDominios.length, 120);
    for (var i = 0; i < 120; i++) {
      expect(enDominios.where((idx) => idx == i), hasLength(1));
    }
  });

  test('IPIP-NEO-120: suma correcta de la faceta Ansiedad (N1)', () {
    final respuestas = List<int>.filled(120, 1);
    final resultado = puntuarInstrumento(ipip, respuestas);
    // N1 = índices 0, 30, 60, 90 (todos directos, valor 1 → 4).
    final ansiedad =
        resultado.subescalas.firstWhere((s) => s.nombre == 'Ansiedad');
    expect(ansiedad.total, 4);
  });

  test('IPIP-NEO-120: los ítems invertidos se puntúan invertidos', () {
    final respuestas = List<int>.filled(120, 1);
    expect(ipip.preguntas[8].invertida, isTrue); // Use others for my own ends
    expect(ipip.preguntas[9].invertida, isFalse); // Like to tidy up

    final resultado = puntuarInstrumento(ipip, respuestas);
    // 65 directos (1) + 55 invertidos (1 → 5) = 65 + 275 = 340.
    expect(resultado.total, 340);
  });

  test('IPIP-NEO-120: respuesta neutra (3) no se altera por la inversión', () {
    final respuestas = List<int>.filled(120, 3);
    final resultado = puntuarInstrumento(ipip, respuestas);
    expect(resultado.total, 360);
  });
}
