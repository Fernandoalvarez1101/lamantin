import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/models/paciente.dart';
import 'package:lamantin/models/sesion.dart';
import 'package:lamantin/repositories/almacen.dart';
import 'package:lamantin/screens/resultados/informe_paciente_screen.dart';
import 'package:lamantin/services/informe_pdf.dart';
import 'package:lamantin/services/informe_texto.dart';

void main() {
  setUp(AppRepositorios.reiniciarEnMemoria);

  final paciente = Paciente(
    id: 'p1',
    nombre: 'Ana',
    apellido: 'García',
    sexo: 'Femenino',
    fechaRegistro: DateTime(2026, 1, 5),
  );

  List<Sesion> sesiones = [
    Sesion(
      id: 's1',
      idPaciente: 'p1',
      idInstrumento: 'phq-9',
      siglaInstrumento: 'PHQ-9',
      nombreInstrumento: 'Patient Health Questionnaire-9',
      fechaAplicacion: DateTime(2026, 1, 10),
      respuestas: const [],
      resultadoTotal: 10,
      resultadoEtiqueta: 'Moderada',
      resultadoDescripcion: 'Depresión moderada.',
    ),
    Sesion(
      id: 's2',
      idPaciente: 'p1',
      idInstrumento: 'phq-9',
      siglaInstrumento: 'PHQ-9',
      nombreInstrumento: 'Patient Health Questionnaire-9',
      fechaAplicacion: DateTime(2026, 2, 10),
      respuestas: const [],
      resultadoTotal: 14,
      resultadoEtiqueta: 'Moderada',
      resultadoDescripcion: 'Depresión moderada.',
    ),
  ];

  test('generarInformePdf produce un PDF válido', () async {
    final bytes = await generarInformePdf(
      paciente: paciente,
      sesiones: sesiones,
    );
    expect(bytes, isNotEmpty);
    // Un PDF válido comienza con la cabecera %PDF.
    expect(String.fromCharCodes(bytes.take(4)), '%PDF');
  });

  test('generarInformeTexto incluye datos del paciente y evolución', () {
    final texto = generarInformeTexto(paciente: paciente, sesiones: sesiones);
    expect(texto, contains('Ana García'));
    expect(texto, contains('PHQ-9'));
    expect(texto, contains('Evolución'));
    expect(texto, contains('Variación: +4'));
  });

  testWidgets('El informe permite exportar y copiar el texto',
      (tester) async {
    await AppRepositorios.paciente.crear(paciente);
    for (final sesion in sesiones) {
      await AppRepositorios.sesion.crear(sesion);
    }

    // Mock del portapapeles para que Clipboard.setData complete en el test.
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async => null,
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null);
    });

    await tester.pumpWidget(
      MaterialApp(home: InformePacienteScreen(paciente: paciente)),
    );
    await tester.pumpAndSettle();

    // Abrir el menú de exportación.
    await tester.tap(find.byIcon(Icons.ios_share));
    await tester.pumpAndSettle();

    expect(find.text('Descargar informe en PDF'), findsOneWidget);
    expect(find.text('Copiar informe como texto'), findsOneWidget);

    // Copiar como texto: muestra la confirmación.
    await tester.tap(find.text('Copiar informe como texto'));
    await tester.pumpAndSettle();

    expect(
      find.text('Informe copiado al portapapeles'),
      findsOneWidget,
    );
  });
}
