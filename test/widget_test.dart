import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/main.dart';

void main() {
  testWidgets('El dashboard muestra las secciones principales',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    expect(find.text('Panel de control'), findsOneWidget);
    expect(find.text('Instrumentos'), findsOneWidget);
    expect(find.text('Pacientes'), findsOneWidget);
    expect(find.text('Sesiones'), findsOneWidget);
    expect(find.text('Resultados'), findsOneWidget);
  });

  testWidgets('El módulo Instrumentos muestra las categorías de clasificación',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    await tester.tap(find.text('Instrumentos'));
    await tester.pumpAndSettle();

    expect(find.text('Clasificación por categoría'), findsOneWidget);
    expect(find.text('Depresión'), findsOneWidget);
    expect(find.text('Ansiedad'), findsOneWidget);
    expect(find.text('Estrés'), findsOneWidget);
    expect(find.text('Vocacional'), findsOneWidget);
  });

  testWidgets('Al elegir una categoría se muestran sus instrumentos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    await tester.tap(find.text('Instrumentos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Depresión'));
    await tester.pumpAndSettle();

    expect(find.text('PHQ-9'), findsOneWidget);
    expect(find.text('Patient Health Questionnaire-9'), findsOneWidget);
    // El título de la pantalla corresponde a la categoría elegida.
    expect(find.text('Depresión'), findsOneWidget);
  });

  testWidgets('El módulo Resultados navega al listado de informes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    await tester.tap(find.text('Resultados'));
    await tester.pumpAndSettle();

    expect(find.text('Informes de pacientes'), findsOneWidget);
    expect(find.text('Aún no hay informes para mostrar.'), findsOneWidget);
  });

  testWidgets('El módulo Pacientes permite registrar un paciente',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    await tester.tap(find.text('Pacientes'));
    await tester.pumpAndSettle();

    // Estado vacío inicial.
    expect(find.text('Aún no hay pacientes registrados.'), findsOneWidget);

    // Alta del primer paciente.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Ana');
    await tester.enterText(find.byType(TextFormField).at(1), 'García');
    await tester.ensureVisible(find.text('Guardar paciente'));
    await tester.tap(find.text('Guardar paciente'));
    await tester.pumpAndSettle();

    expect(find.text('Ana García'), findsOneWidget);
    expect(find.text('Aún no hay pacientes registrados.'), findsNothing);
  });
}
