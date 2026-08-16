import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/main.dart';

void main() {
  testWidgets('Flujo PHQ-9: aplicar, responder las 9 preguntas y ver resultado',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    // Navegar: Instrumentos → Depresión → ficha del PHQ-9.
    await tester.tap(find.text('Instrumentos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Depresión'));
    await tester.pumpAndSettle();

    // Los instrumentos de la categoría Depresión son aplicables.
    expect(find.text('Aplicable'), findsWidgets);
    await tester.tap(find.text('PHQ-9'));
    await tester.pumpAndSettle();

    // Iniciar la aplicación desde la ficha.
    await tester.ensureVisible(find.text('Aplicar instrumento'));
    await tester.tap(find.text('Aplicar instrumento'));
    await tester.pumpAndSettle();

    // Introducción del instrumento.
    expect(find.text('Cuestionario de Salud del Paciente-9'), findsOneWidget);
    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    // Responder las 9 preguntas puntuables con la opción de valor 0.
    for (var i = 0; i < 9; i++) {
      final opcion = find.text('Nada en absoluto');
      await tester.ensureVisible(opcion);
      await tester.tap(opcion);
      await tester.pump();
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();
    }

    // Pregunta 10: información clínica adicional (no se puntúa).
    expect(
      find.text('Información clínica adicional (no se puntúa)'),
      findsOneWidget,
    );
    await tester.tap(find.text('Nada difícil'));
    await tester.pump();
    await tester.tap(find.text('Ver resultados'));
    await tester.pumpAndSettle();

    // Resultado: total 0, severidad mínima e información complementaria.
    expect(find.text('Puntuación total'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Mínima'), findsOneWidget);
    expect(find.text('Información clínica adicional'), findsOneWidget);
  });

  testWidgets('El PHQ-9 muestra la alerta clínica si el ítem 9 es positivo',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LamantinApp());

    await tester.tap(find.text('Instrumentos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Depresión'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PHQ-9'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Aplicar instrumento'));
    await tester.tap(find.text('Aplicar instrumento'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    // Responder 0 en las primeras 8 preguntas.
    for (var i = 0; i < 8; i++) {
      await tester.tap(find.text('Nada en absoluto'));
      await tester.pump();
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();
    }

    // Ítem 9 positivo: respuestas 0 en 8 preguntas + 1 aquí.
    await tester.tap(find.text('Varios días'));
    await tester.pump();
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();

    // Pregunta 10 (complementaria, no puntúa).
    await tester.tap(find.text('Nada difícil'));
    await tester.pump();
    await tester.tap(find.text('Ver resultados'));
    await tester.pumpAndSettle();

    expect(find.text('Atención clínica'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });
}
