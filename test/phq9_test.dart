import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/phq9.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  test('PHQ-9 tiene 9 preguntas con 4 opciones cada una', () {
    expect(phq9Aplicable.preguntas.length, 9);
    for (final pregunta in phq9Aplicable.preguntas) {
      expect(pregunta.opciones.length, 4);
      expect(pregunta.opciones.first.valor, 0);
      expect(pregunta.opciones.last.valor, 3);
    }
  });

  test('Las bandas de severidad cubren el rango completo 0-27', () {
    expect(phq9Aplicable.rangos.first.minimo, 0);
    expect(phq9Aplicable.rangos.last.maximo, 27);
  });

  test('Incluye la pregunta 10 de deterioro funcional sin puntuarla', () {
    expect(phq9Aplicable.preguntasComplementarias.length, 1);
    final pregunta10 = phq9Aplicable.preguntasComplementarias.single;
    expect(pregunta10.opciones.length, 4);
    expect(pregunta10.opciones.first.etiqueta, 'Nada difícil');

    // La puntuación solo considera las 9 preguntas puntuables.
    final resultado = puntuarInstrumento(phq9Aplicable, List.filled(9, 1));
    expect(resultado.total, 9);
  });

  test('Todo en 0 da total 0 y severidad mínima', () {
    final resultado = puntuarInstrumento(phq9Aplicable, List.filled(9, 0));
    expect(resultado.total, 0);
    expect(resultado.rango.etiqueta, 'Mínima');
    expect(resultado.tieneAlertas, isFalse);
  });

  test('Todo en 3 da total 27 y severidad grave', () {
    final resultado = puntuarInstrumento(phq9Aplicable, List.filled(9, 3));
    expect(resultado.total, 27);
    expect(resultado.rango.etiqueta, 'Grave');
  });

  test('Una suma de 10 cae en la banda moderada', () {
    final respuestas = [1, 1, 1, 1, 1, 1, 1, 1, 2];
    final resultado = puntuarInstrumento(phq9Aplicable, respuestas);
    expect(resultado.total, 10);
    expect(resultado.rango.etiqueta, 'Moderada');
  });

  test('Se activa alerta de riesgo si el ítem 9 es mayor que 0', () {
    final respuestas = List.filled(9, 0);
    respuestas[8] = 1;
    final resultado = puntuarInstrumento(phq9Aplicable, respuestas);
    expect(resultado.total, 1);
    expect(resultado.tieneAlertas, isTrue);
    expect(resultado.alertasActivadas.single, contains('ítem 9'));
  });

  test('Se lanza error si la cantidad de respuestas es incorrecta', () {
    expect(
      () => puntuarInstrumento(phq9Aplicable, [0, 1]),
      throwsArgumentError,
    );
  });
}
