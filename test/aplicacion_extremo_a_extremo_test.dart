import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/bai.dart';
import 'package:lamantin/data/aplicaciones/gbjws.dart';
import 'package:lamantin/data/aplicaciones/ius12.dart';
import 'package:lamantin/data/aplicaciones/mmpi2.dart';
import 'package:lamantin/data/aplicaciones/mmpi2_respuestas.dart';
import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/data/aplicaciones/rotter_locus.dart';
import 'package:lamantin/data/aplicaciones/rses.dart';
import 'package:lamantin/models/instrumento_aplicable.dart';
import 'package:lamantin/screens/aplicacion/aplicacion_instrumento_screen.dart';
import 'package:lamantin/screens/instrumentos/lista_instrumentos_screen.dart';

/// Aplica un instrumento de principio a fin eligiendo siempre la opción de
/// mayor valor de cada pregunta y comprueba que se llega a la pantalla de
/// resultado con la puntuación total esperada.
///
/// En Rotter I-E la alternativa de mayor valor no siempre es la «B»: la
/// externa puede ir en cualquiera de las dos posiciones del par.
Future<void> _aplicarDePrincipioAFin(
  WidgetTester tester,
  InstrumentoAplicable instrumento,
  int totalEsperado,
) async {
  await tester.pumpWidget(
    MaterialApp(home: AplicacionInstrumentoScreen(instrumento: instrumento)),
  );

  expect(find.text(instrumento.titulo), findsOneWidget);

  await tester.tap(find.text('Comenzar'));
  await tester.pumpAndSettle();

  for (var i = 0; i < instrumento.totalPreguntas; i++) {
    final pregunta = instrumento.preguntas[i];
    final elegida = pregunta.opciones.reduce(
      (a, b) => a.valor >= b.valor ? a : b,
    );
    final opcion = find.text(elegida.etiqueta);

    await tester.ensureVisible(opcion);
    await tester.pumpAndSettle();
    await tester.tap(opcion);
    await tester.pump();

    final esUltima = i == instrumento.totalPreguntas - 1;
    await tester.tap(find.text(esUltima ? 'Ver resultados' : 'Siguiente'));
    await tester.pumpAndSettle();
  }

  expect(find.text('Resultado'), findsOneWidget);
  expect(find.text('Puntuación total'), findsOneWidget);
  expect(find.text('$totalEsperado'), findsOneWidget);
}

/// Desplaza la lista hasta que [finder] quede construido y visible.
///
/// Las listas de instrumentos usan `ListView` (construcción perezosa), así
/// que los instrumentos que quedan fuera de pantalla aún no existen en el
/// árbol de widgets y hay que desplazarse hasta ellos.
Future<void> _localizarEnLista(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('Aplicación de punta a punta de los instrumentos nuevos', () {
    testWidgets('BAI llega al resultado con 63 puntos', (tester) async {
      await _aplicarDePrincipioAFin(tester, baiAplicable, 63);
      expect(find.text('Grave'), findsOneWidget);
    });

    testWidgets('IUS-12 llega al resultado con 60 puntos', (tester) async {
      await _aplicarDePrincipioAFin(tester, ius12Aplicable, 60);
      expect(find.text('Rango: 12–60'), findsOneWidget);
    });

    testWidgets('Rotter I-E llega al resultado con 23 puntos', (tester) async {
      await _aplicarDePrincipioAFin(tester, rotterLocusAplicable, 23);
      expect(find.text('Rango: 0–23'), findsOneWidget);
    });

    testWidgets('GBJWS llega al resultado con 42 puntos', (tester) async {
      await _aplicarDePrincipioAFin(tester, gbjwsAplicable, 42);
      expect(find.text('Rango: 7–42'), findsOneWidget);
    });

    testWidgets('RSES llega al resultado con 25 puntos', (tester) async {
      await _aplicarDePrincipioAFin(tester, rsesAplicable, 25);
      expect(find.text('Rango: 10–40'), findsOneWidget);
    });

    testWidgets('MMPI-2 llega al resultado con sus 62 escalas elevadas',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AplicacionInstrumentoScreen(instrumento: mmpi2Aplicable),
        ),
      );

      expect(find.text(mmpi2Aplicable.titulo), findsOneWidget);

      await tester.tap(find.text('Comenzar'));
      await tester.pumpAndSettle();

      for (var i = 0; i < mmpi2Aplicable.totalPreguntas; i++) {
        // Hoja de puntuación: el profesional marca «Sí (T ≥ 65)» en cada
        // escala trasladando el resultado del informe oficial.
        final opcion = find.text('Sí (T ≥ 65)');
        await tester.ensureVisible(opcion);
        await tester.pumpAndSettle();
        await tester.tap(opcion);
        await tester.pump();

        final esUltima = i == mmpi2Aplicable.totalPreguntas - 1;
        await tester.tap(find.text(esUltima ? 'Ver resultados' : 'Siguiente'));
        await tester.pumpAndSettle();
      }

      expect(find.text('Resultado'), findsOneWidget);

      // El perfil se lee escala por escala: no hay tarjeta de total.
      expect(find.text('Puntuación total'), findsNothing);
      expect(find.text('Puntuaciones'), findsOneWidget);

      for (final subescala in mmpi2Aplicable.subescalas) {
        expect(
          find.text(subescala.nombre),
          findsOneWidget,
          reason: '${subescala.nombre} no aparece en el resultado',
        );
      }
      expect(
        find.text('Elevación clínica'),
        findsNWidgets(mmpi2Aplicable.subescalas.length),
      );
    });

    testWidgets('La hoja de respuestas del MMPI-2 pide los 567 ítems V/F',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AplicacionInstrumentoScreen(
            instrumento: mmpi2RespuestasAplicable,
          ),
        ),
      );

      expect(find.text(mmpi2RespuestasAplicable.titulo), findsOneWidget);

      await tester.ensureVisible(find.text('Comenzar'));
      await tester.tap(find.text('Comenzar'));
      await tester.pumpAndSettle();

      expect(find.text('Pregunta 1 de 567'), findsOneWidget);
      expect(find.text('Ítem 1'), findsOneWidget);
      expect(find.text('V · Verdadero'), findsOneWidget);
      expect(find.text('F · Falso'), findsOneWidget);

      await tester.tap(find.text('V · Verdadero'));
      await tester.pump();
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();

      expect(find.text('Pregunta 2 de 567'), findsOneWidget);
      expect(find.text('Ítem 2'), findsOneWidget);
    });
  });

  testWidgets(
      'Desde el catálogo se abre la aplicación de cada instrumento nuevo',
      (WidgetTester tester) async {
    const esperados = <String, List<String>>{
      'Ansiedad': ['BAI', 'IUS-12'],
      'Creencias y esquemas cognitivos': ['Rotter I-E', 'GBJWS'],
      'Personalidad': ['MMPI-2', 'MMPI-2 · respuestas'],
    };

    await tester.pumpWidget(
      const MaterialApp(home: ListaInstrumentosScreen()),
    );

    for (final entrada in esperados.entries) {
      final categoria = find.text(entrada.key);
      await _localizarEnLista(tester, categoria);
      await tester.tap(categoria);
      await tester.pumpAndSettle();

      for (final sigla in entrada.value) {
        final tarjeta = find.text(sigla);
        await _localizarEnLista(tester, tarjeta);
        await tester.tap(tarjeta);
        await tester.pumpAndSettle();

        // La ficha solo ofrece «Aplicar» si el id del catálogo está
        // registrado en `aplicacionesDisponibles`.
        final aplicar = find.text('Aplicar instrumento');
        await _localizarEnLista(tester, aplicar);
        expect(aplicar, findsOneWidget, reason: '$sigla no es aplicable');
        await tester.tap(aplicar);
        await tester.pumpAndSettle();

        expect(
          find.text('Comenzar'),
          findsOneWidget,
          reason: '$sigla no abre la pantalla de aplicación',
        );

        await tester.pageBack();
        await tester.pumpAndSettle();
      }

      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });

  test('Los cinco instrumentos están registrados para aplicarse', () {
    for (final id in const [
      'bai',
      'ius-12',
      'rotter-locus',
      'gbjws',
      'rses',
    ]) {
      expect(
        aplicacionesDisponibles.containsKey(id),
        isTrue,
        reason: 'El instrumento $id no está registrado en la app',
      );
    }
  });
}
