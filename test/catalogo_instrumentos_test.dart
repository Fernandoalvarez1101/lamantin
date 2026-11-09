import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
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

  test('La ansiedad incluye el BAI y el IUS-12, ambos aplicables', () {
    final bai = catalogoInstrumentos.firstWhere((i) => i.id == 'bai');
    final ius = catalogoInstrumentos.firstWhere((i) => i.id == 'ius-12');

    expect(bai.sigla, 'BAI');
    expect(bai.categoria, CategoriaInstrumento.ansiedad);
    expect(bai.numeroItems, 21);
    expect(ius.sigla, 'IUS-12');
    expect(ius.categoria, CategoriaInstrumento.ansiedad);
    expect(ius.numeroItems, 12);

    expect(aplicacionDe('bai'), isNotNull);
    expect(aplicacionDe('ius-12'), isNotNull);
  });

  test('La categoría de creencias incluye Rotter y el GBJWS', () {
    final ids = instrumentosDeCategoria(CategoriaInstrumento.creencias)
        .map((i) => i.id)
        .toList();

    expect(ids, containsAll(<String>['rotter-locus', 'gbjws']));
    expect(aplicacionDe('rotter-locus'), isNotNull);
    expect(aplicacionDe('gbjws'), isNotNull);
  });

  test('Toda aplicación registrada corresponde a un instrumento del catálogo',
      () {
    final idsCatalogo = catalogoInstrumentos.map((i) => i.id).toSet();

    for (final id in aplicacionesDisponibles.keys) {
      expect(
        idsCatalogo.contains(id),
        isTrue,
        reason: 'La aplicación «$id» no existe en el catálogo.',
      );
    }
  });

  test(
      'La categoría de personalidad incluye el MMPI-2 como hoja de '
      'puntuación', () {
    final mmpi = catalogoInstrumentos.firstWhere((i) => i.id == 'mmpi-2');

    expect(mmpi.sigla, 'MMPI-2');
    expect(mmpi.categoria, CategoriaInstrumento.personalidad);
    expect(mmpi.numeroItems, 567);
    expect(mmpi.disponibilidad, contains('licencia'));

    // Instrumento propietario: la app sólo ofrece la hoja de puntuación con
    // el corte T ≥ 65, sin reproducir los ítems ni mostrar un total.
    final aplicacion = aplicacionDe('mmpi-2');
    expect(aplicacion, isNotNull);
    expect(aplicacion!.mostrarPuntuacionTotal, isFalse);
    expect(aplicacion.subescalas, isNotEmpty);
  });
}
