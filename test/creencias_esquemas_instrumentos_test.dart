import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/gbjws.dart';
import 'package:lamantin/data/aplicaciones/rotter_locus.dart';
import 'package:lamantin/screens/aplicacion/aplicacion_instrumento_screen.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('Rotter I-E', () {
    test('Tiene 29 pares y 6 de relleno (1, 8, 14, 19, 24 y 27)', () {
      expect(rotterLocusAplicable.preguntas.length, 29);
      for (final pregunta in rotterLocusAplicable.preguntas) {
        expect(pregunta.opciones.length, 2);
      }

      for (final indice in [0, 7, 13, 18, 23, 26]) {
        expect(
          rotterLocusAplicable.preguntas[indice].puntuable,
          isFalse,
          reason: 'El par ${indice + 1} debe ser de relleno.',
        );
      }
      expect(
        rotterLocusAplicable.preguntas.where((p) => p.puntuable).length,
        23,
      );
    });

    test('Cada par puntuable ofrece una alternativa interna y una externa', () {
      for (final pregunta
          in rotterLocusAplicable.preguntas.where((p) => p.puntuable)) {
        final valores = pregunta.opciones.map((o) => o.valor).toList();
        expect(valores.where((v) => v == 1).length, 1);
        expect(valores.where((v) => v == 0).length, 1);
      }
    });

    test('Las dos opciones de cada par son distinguibles en la interfaz', () {
      for (final pregunta in rotterLocusAplicable.preguntas) {
        final valores = pregunta.opciones.map((o) => o.valor).toSet();
        expect(valores.length, pregunta.opciones.length);
      }
    });

    testWidgets('La pantalla de aplicación marca solo la alternativa elegida',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AplicacionInstrumentoScreen(
            instrumento: rotterLocusAplicable,
          ),
        ),
      );
      await tester.tap(find.text('Comenzar'));
      await tester.pumpAndSettle();

      // Primer par: se elige la alternativa B.
      final opciones = rotterLocusAplicable.preguntas.first.opciones;
      await tester.tap(find.text(opciones.last.etiqueta));
      await tester.pump();

      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_off), findsOneWidget);
    });

    test('Puntúa de 0 a 23 según la elección interna o externa', () {
      final internas = rotterLocusAplicable.preguntas
          .map((p) => p.opciones.map((o) => o.valor).reduce(min))
          .toList();
      final externas = rotterLocusAplicable.preguntas
          .map((p) => p.opciones.map((o) => o.valor).reduce(max))
          .toList();

      final r = puntuarInstrumento(rotterLocusAplicable, internas);
      expect(r.total, 0);
      expect(r.rango.descriptiva, isTrue);

      final r2 = puntuarInstrumento(rotterLocusAplicable, externas);
      expect(r2.total, 23);
      expect(r2.rango.descriptiva, isTrue);
      expect(r2.rango.etiqueta, 'Descriptivo');
    });
  });

  group('GBJWS', () {
    test('Tiene 7 preguntas con 6 opciones de acuerdo', () {
      expect(gbjwsAplicable.preguntas.length, 7);
      for (final pregunta in gbjwsAplicable.preguntas) {
        expect(pregunta.opciones.length, 6);
        expect(pregunta.opciones.first.valor, 1);
        expect(pregunta.opciones.last.valor, 6);
      }
    });

    test('Puntúa en el rango 7-42 en modo descriptivo', () {
      final r = puntuarInstrumento(gbjwsAplicable, List.filled(7, 1));
      expect(r.total, 7);
      expect(r.rango.descriptiva, isTrue);

      final r2 = puntuarInstrumento(gbjwsAplicable, List.filled(7, 6));
      expect(r2.total, 42);
      expect(r2.rango.descriptiva, isTrue);

      final r3 = puntuarInstrumento(gbjwsAplicable, List.filled(7, 4));
      expect(r3.total, 28);
      expect(r3.rango.descriptiva, isTrue);
    });
  });
}
