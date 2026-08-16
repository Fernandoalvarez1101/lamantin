import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/models/paciente.dart';
import 'package:lamantin/models/sesion.dart';
import 'package:lamantin/repositories/almacen.dart';
import 'package:lamantin/screens/resultados/informe_paciente_screen.dart';
import 'package:lamantin/screens/resultados/lista_resultados_screen.dart';
import 'package:lamantin/widgets/evolucion_chart.dart';

void main() {
  setUp(AppRepositorios.reiniciarEnMemoria);

  Future<void> sembrarDatos() async {
    await AppRepositorios.paciente.crear(
      Paciente(
        id: 'p1',
        nombre: 'Ana',
        apellido: 'García',
        fechaNacimiento: DateTime(1990, 5, 14),
        sexo: 'Femenino',
        fechaRegistro: DateTime(2026, 1, 5),
      ),
    );
    await AppRepositorios.sesion.crear(
      _sesion('s1', DateTime(2026, 1, 10), 10),
    );
    await AppRepositorios.sesion.crear(
      _sesion('s2', DateTime(2026, 2, 10), 12),
    );
    await AppRepositorios.sesion.crear(
      _sesion('s3', DateTime(2026, 3, 10), 14),
    );
    await AppRepositorios.sesion.crear(
      _sesion('s4', DateTime(2026, 2, 20), 8, sigla: 'GAD-7',
          idInstrumento: 'gad-7'),
    );
  }

  testWidgets('El listado muestra el resumen de cada paciente',
      (tester) async {
    await sembrarDatos();

    await tester.pumpWidget(
      const MaterialApp(home: ListaResultadosScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ana García'), findsOneWidget);
    expect(find.textContaining('4 sesión(es)'), findsOneWidget);
    expect(find.textContaining('2 instrumento(s)'), findsOneWidget);
  });

  testWidgets('El informe muestra evolución con gráfica cuando hay 2+ sesiones',
      (tester) async {
    await sembrarDatos();

    await tester.pumpWidget(
      const MaterialApp(home: ListaResultadosScreen()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ana García'));
    await tester.pumpAndSettle();

    // Cabecera e informe.
    expect(find.text('Informe'), findsOneWidget);
    expect(find.text('Ana García'), findsOneWidget);

    // PHQ-9 con 3 sesiones: sección de evolución con gráfica y delta.
    expect(find.text('PHQ-9'), findsOneWidget);
    expect(find.text('Evolución'), findsOneWidget);
    expect(find.byType(EvolucionChart), findsOneWidget);
    expect(find.textContaining('Δ +4'), findsOneWidget);

    // GAD-7 con una sola sesión: sin evolución, pero con su fila.
    // (Está más abajo en el informe: hay que desplazarse hasta ella.)
    await tester.scrollUntilVisible(find.text('GAD-7'), 200);
    expect(find.text('GAD-7'), findsOneWidget);
    expect(find.textContaining('Puntuación: 8'), findsOneWidget);
  });

  testWidgets('El informe sin sesiones muestra el estado vacío',
      (tester) async {
    final paciente = Paciente(
      id: 'p1',
      nombre: 'Ana',
      apellido: 'García',
      fechaRegistro: DateTime(2026, 1, 5),
    );
    await AppRepositorios.paciente.crear(paciente);

    await tester.pumpWidget(
      MaterialApp(home: InformePacienteScreen(paciente: paciente)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sin sesiones guardadas.'), findsOneWidget);
  });
}

/// Construye una sesión de prueba de un instrumento con total dado.
Sesion _sesion(
  String id,
  DateTime fecha,
  int total, {
  String sigla = 'PHQ-9',
  String idInstrumento = 'phq-9',
}) {
  return Sesion(
    id: id,
    idPaciente: 'p1',
    idInstrumento: idInstrumento,
    siglaInstrumento: sigla,
    nombreInstrumento: 'Test de prueba',
    fechaAplicacion: fecha,
    respuestas: const [],
    resultadoTotal: total,
    resultadoEtiqueta: 'Moderada',
    resultadoDescripcion: 'Descripción.',
  );
}
