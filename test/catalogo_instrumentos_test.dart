import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/catalogo_instrumentos.dart';
import 'package:lamantin/models/categoria_instrumento.dart';

void main() {
  test('El catálogo contiene instrumentos en todas las categorías', () {
    expect(catalogoInstrumentos, isNotEmpty);

    for (final categoria in CategoriaInstrumento.values) {
      expect(
        instrumentosDeCategoria(categoria),
        isNotEmpty,
        reason: 'La categoría ${categoria.nombre} no tiene instrumentos.',
      );
    }
  });

  test('Los identificadores del catálogo son únicos', () {
    final ids = catalogoInstrumentos.map((i) => i.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('Cada instrumento pertenece a una categoría válida', () {
    final categoriasValidas = CategoriaInstrumento.values.toSet();
    for (final instrumento in catalogoInstrumentos) {
      expect(
        categoriasValidas.contains(instrumento.categoria),
        isTrue,
        reason: '${instrumento.id} tiene una categoría no válida.',
      );
    }
  });

  test('PHQ-9 y GAD-7 están disponibles', () {
    final phq9 = catalogoInstrumentos.firstWhere((i) => i.id == 'phq-9');
    final gad7 = catalogoInstrumentos.firstWhere((i) => i.id == 'gad-7');

    expect(phq9.sigla, 'PHQ-9');
    expect(phq9.categoria, CategoriaInstrumento.depresion);
    expect(gad7.sigla, 'GAD-7');
    expect(gad7.categoria, CategoriaInstrumento.ansiedad);
  });

  test('Las categorías críticas incluyen sus instrumentos', () {
    final cSsrs = catalogoInstrumentos.firstWhere((i) => i.id == 'c-ssrs');
    final moca = catalogoInstrumentos.firstWhere((i) => i.id == 'moca');
    final sdq = catalogoInstrumentos.firstWhere((i) => i.id == 'sdq');
    final assist = catalogoInstrumentos.firstWhere((i) => i.id == 'assist-v3');

    expect(cSsrs.categoria, CategoriaInstrumento.riesgoSuicida);
    expect(moca.categoria, CategoriaInstrumento.neurocognitivo);
    expect(sdq.categoria, CategoriaInstrumento.infantoJuvenil);
    expect(assist.categoria, CategoriaInstrumento.adicciones);
  });
}
