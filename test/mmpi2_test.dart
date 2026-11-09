import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/models/instrumento_aplicable.dart';
import 'package:lamantin/screens/aplicacion/resultado_aplicacion_screen.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  final mmpi = aplicacionDe('mmpi-2')!;
  final hoja = aplicacionDe('mmpi-2-respuestas')!;

  group('MMPI-2 · hoja de puntuación', () {
    test('62 ítems puntuables y 62 subescalas (una por escala)', () {
      expect(mmpi.preguntas, hasLength(62));
      expect(mmpi.subescalas, hasLength(62));
      expect(mmpi.totalPreguntas, 62);

      // El perfil se lee escala por escala: la puntuación total no se muestra.
      expect(mmpi.mostrarPuntuacionTotal, isFalse);
      expect(mmpi.mostrarPlantillaRespuestas, isFalse);
      expect(mmpi.rangos.single.etiqueta, 'Ver subescalas');
      expect(mmpi.rangos.single.maximo, 62);

      // Cada escala es una subescala de un solo ítem y entre todas cubren
      // las 62 escalas sin repetir.
      final indices = mmpi.subescalas.expand((s) => s.indicesPregunta).toList()
        ..sort();
      expect(indices, List<int>.generate(62, (i) => i));
    });

    test('registra las escalas de los seis grupos del perfil', () {
      final siglas =
          mmpi.subescalas.map((s) => s.nombre.split(' · ').first).toList();

      expect(siglas, hasLength(62));
      expect(
        siglas,
        containsAll(<String>[
          // Validez
          'L', 'F', 'K', 'Fb', 'Fp', 'Fs', 'VRIN', 'TRIN',
          // Clínicas básicas
          'Hs', 'D', 'Hy', 'Pd', 'Mf', 'Pa', 'Pt', 'Sc', 'Ma', 'Si',
          // Restructuradas (RC)
          'RCd', 'RC1', 'RC2', 'RC3', 'RC4', 'RC6', 'RC7', 'RC8', 'RC9',
          // PSY-5
          'AGGR', 'PSYC', 'DISC', 'NEGE', 'INTR',
          // Contenido
          'ANX', 'FRS', 'OBS', 'DEP', 'HEA', 'BIZ', 'ANG', 'CYN', 'ASP',
          'TPA', 'LSE', 'SOD', 'FAM', 'WRK', 'TRT',
          // Suplementarias
          'A', 'R', 'Es', 'Do', 'Re', 'Mt', 'PK', 'PS', 'MAC-R', 'AAS',
          'APS', 'MDS', 'Ho', 'O-H', 'S',
        ]),
      );
    });

    test('los identificadores de las subescalas son únicos', () {
      final ids = mmpi.subescalas.map((s) => s.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('cada escala declara el grupo del perfil al que pertenece', () {
      final conteo = <String, int>{};
      for (final subescala in mmpi.subescalas) {
        final grupo = subescala.descripcion!.split(' · ').first;
        conteo[grupo] = (conteo[grupo] ?? 0) + 1;
      }

      expect(conteo, <String, int>{
        'Validez': 8,
        'Clínicas básicas': 10,
        'Restructuradas (RC)': 9,
        'PSY-5': 5,
        'Contenido': 15,
        'Suplementarias': 15,
      });
    });

    test('cada ítem es una marca de elevación (T ≥ 65)', () {
      for (final pregunta in mmpi.preguntas) {
        expect(pregunta.opciones, hasLength(2));
        expect(pregunta.opciones.first.valor, 0);
        expect(pregunta.opciones.first.etiqueta, 'No (T < 65)');
        expect(pregunta.opciones.last.valor, 1);
        expect(pregunta.opciones.last.etiqueta, 'Sí (T ≥ 65)');
        expect(pregunta.texto, endsWith('¿la puntuación T es ≥ 65?'));
      }
    });

    test('sin elevaciones no se activa ninguna alerta', () {
      final resultado = puntuarInstrumento(mmpi, List<int>.filled(62, 0));

      expect(resultado.total, 0);
      expect(resultado.tieneAlertas, isFalse);
      for (final subescala in resultado.subescalas) {
        expect(subescala.rango.etiqueta, 'Sin elevación');
      }
    });

    test('todas las escalas elevadas activan las 6 alertas de validez', () {
      final resultado = puntuarInstrumento(mmpi, List<int>.filled(62, 1));

      expect(resultado.total, 62);
      expect(resultado.alertasActivadas, hasLength(6));
      expect(resultado.alertasActivadas.first, contains('Escala F elevada'));
      expect(resultado.alertasActivadas.last, contains('TRIN'));
      for (final subescala in resultado.subescalas) {
        expect(subescala.rango.etiqueta, 'Elevación clínica');
      }
    });

    test('las alertas apuntan a las escalas de validez correctas', () {
      final siglasAlertadas = mmpi.alertas
          .map(
            (alerta) => mmpi
                .preguntas[alerta.numeroPregunta - 1]
                .texto
                .split(' · ')
                .first,
          )
          .toList();

      expect(siglasAlertadas, <String>['F', 'Fb', 'Fp', 'Fs', 'VRIN', 'TRIN']);
    });

    test('solo la escala F elevada dispara su alerta', () {
      final respuestas = List<int>.filled(62, 0);
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
  });

  group('MMPI-2 · hoja de respuestas', () {
    test('567 ítems Verdadero/Falso numerados', () {
      expect(hoja.preguntas, hasLength(567));
      expect(hoja.totalPreguntas, 567);

      expect(hoja.preguntas.first.texto, 'Ítem 1');
      expect(hoja.preguntas.last.texto, 'Ítem 567');

      for (final pregunta in hoja.preguntas) {
        expect(pregunta.opciones, hasLength(2));
        expect(pregunta.opciones.first.etiqueta, 'V · Verdadero');
        expect(pregunta.opciones.first.valor, 1);
        expect(pregunta.opciones.last.etiqueta, 'F · Falso');
        expect(pregunta.opciones.last.valor, 0);
      }
    });

    test('no puntúa en la app y muestra la plantilla de respuestas', () {
      expect(hoja.mostrarPuntuacionTotal, isFalse);
      expect(hoja.mostrarPlantillaRespuestas, isTrue);
      expect(hoja.subescalas, isEmpty);
      expect(hoja.alertas, isEmpty);
      expect(hoja.rangos.single.etiqueta, 'Ver plantilla');
      expect(hoja.rangos.single.maximo, 567);

      final todasVerdadero =
          puntuarInstrumento(hoja, List<int>.filled(567, 1));
      expect(todasVerdadero.total, 567);
      expect(todasVerdadero.subescalas, isEmpty);
      expect(todasVerdadero.tieneAlertas, isFalse);

      final todasFalso = puntuarInstrumento(hoja, List<int>.filled(567, 0));
      expect(todasFalso.total, 0);
    });
  });

  group('MMPI-2 · plantilla de respuestas en pantalla', () {
    /// Copia reducida de la hoja de respuestas para no recorrer 567 ítems en
    /// la prueba de interfaz.
    InstrumentoAplicable hojaReducida() => InstrumentoAplicable(
          id: hoja.id,
          sigla: hoja.sigla,
          titulo: hoja.titulo,
          instrucciones: hoja.instrucciones,
          preguntas: hoja.preguntas.take(12).toList(),
          rangos: hoja.rangos,
          nota: hoja.nota,
          mostrarPuntuacionTotal: hoja.mostrarPuntuacionTotal,
          mostrarPlantillaRespuestas: hoja.mostrarPlantillaRespuestas,
        );

    testWidgets('lista cada ítem con su marca V o F', (tester) async {
      final instrumento = hojaReducida();
      final respuestas = <int>[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0];

      await tester.pumpWidget(
        MaterialApp(
          home: ResultadoAplicacionScreen(
            instrumento: instrumento,
            resultado: puntuarInstrumento(instrumento, respuestas),
            respuestas: respuestas,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Plantilla de respuestas'), findsOneWidget);
      expect(find.text('12 ítems registrados'), findsOneWidget);
      expect(find.text('Copiar plantilla'), findsOneWidget);

      final plantilla = tester.widget<SelectableText>(
        find.byType(SelectableText),
      );
      final lineas = plantilla.data!.split('\n');
      expect(lineas, hasLength(2));
      expect(lineas.first, '  1 V      2 F      3 V      4 F      5 V      6 F');
      expect(lineas.last, '  7 V      8 F      9 V     10 F     11 V     12 F');
    });

    testWidgets('no aparece cuando el instrumento no la declara',
        (tester) async {
      final instrumento = InstrumentoAplicable(
        id: 'sin-plantilla',
        sigla: 'DEMO',
        titulo: 'Instrumento de demostración',
        instrucciones: 'Sin plantilla.',
        preguntas: hoja.preguntas.take(2).toList(),
        rangos: hoja.rangos,
        nota: 'Demo.',
        mostrarPuntuacionTotal: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ResultadoAplicacionScreen(
            instrumento: instrumento,
            resultado: puntuarInstrumento(instrumento, <int>[1, 0]),
            respuestas: const <int>[1, 0],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Plantilla de respuestas'), findsNothing);
      expect(find.byType(SelectableText), findsNothing);
    });
  });
}
