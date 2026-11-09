import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/services/parser_reactivos.dart';

void main() {
  group('parsearReactivosCsv', () {
    test('parsea filas «numero,texto» e ignora el encabezado', () {
      final textos = parsearReactivosCsv(
        'numero,texto\n1,Primer ítem\n2,Segundo ítem',
      );

      expect(textos, <int, String>{1: 'Primer ítem', 2: 'Segundo ítem'});
    });

    test('conserva las comas dentro del texto', () {
      final textos = parsearReactivosCsv('7,Me gusta, a veces, leer');

      expect(textos, <int, String>{7: 'Me gusta, a veces, leer'});
    });

    test('ignora líneas en blanco, inválidas y textos vacíos', () {
      final textos = parsearReactivosCsv(
        'numero,texto\n\nno-un-numero,ignorado\n3,texto tres\n4,\n'
        '5,texto cinco',
      );

      expect(textos, <int, String>{3: 'texto tres', 5: 'texto cinco'});
    });

    test('tolera saltos de línea Windows y espacios sobrantes', () {
      final textos = parsearReactivosCsv(
        '1,   primer ítem   \r\n2,segundo ítem',
      );

      expect(textos, <int, String>{1: 'primer ítem', 2: 'segundo ítem'});
    });
  });
}
