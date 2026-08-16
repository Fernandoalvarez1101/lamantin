import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

import 'package:lamantin/data/aplicaciones/registro_aplicaciones.dart';
import 'package:lamantin/models/paciente.dart';
import 'package:lamantin/models/sesion.dart';
import 'package:lamantin/repositories/almacen.dart';
import 'package:lamantin/repositories/local/paciente_repository_local.dart';
import 'package:lamantin/repositories/local/sesion_repository_local.dart';
import 'package:lamantin/repositories/memoria/paciente_repository_memoria.dart';
import 'package:lamantin/repositories/memoria/sesion_repository_memoria.dart';
import 'package:lamantin/screens/aplicacion/resultado_aplicacion_screen.dart';
import 'package:lamantin/services/guardar_resultado.dart';
import 'package:lamantin/services/puntuacion.dart';

void main() {
  group('Repositorios en memoria', () {
    test('PacienteRepositoryMemoria: crear, consultar, actualizar y eliminar',
        () async {
      final repo = PacienteRepositoryMemoria();
      expect(await repo.obtenerTodos(), isEmpty);

      final p = Paciente(
        id: 'p1',
        nombre: 'Ana',
        apellido: 'García',
        fechaRegistro: DateTime(2026, 1, 10),
      );
      await repo.crear(p);
      expect((await repo.obtenerPorId('p1'))!.nombreCompleto, 'Ana García');
      expect(await repo.obtenerPorId('inexistente'), isNull);

      final editado = Paciente(
        id: 'p1',
        nombre: 'Ana',
        apellido: 'López',
        fechaRegistro: DateTime(2026, 1, 10),
      );
      await repo.actualizar(editado);
      expect((await repo.obtenerPorId('p1'))!.apellido, 'López');

      await repo.eliminar('p1');
      expect(await repo.obtenerPorId('p1'), isNull);
    });

    test('SesionRepositoryMemoria: ordena de más reciente a más antigua',
        () async {
      final repo = SesionRepositoryMemoria();
      await repo.crear(_sesion('s1', 'p1', DateTime(2026, 1, 1)));
      await repo.crear(_sesion('s2', 'p1', DateTime(2026, 3, 1)));
      await repo.crear(_sesion('s3', 'p2', DateTime(2026, 2, 1)));

      final todas = await repo.obtenerTodas();
      expect(todas.map((s) => s.id), ['s2', 's3', 's1']);

      final deP1 = await repo.obtenerPorPaciente('p1');
      expect(deP1.map((s) => s.id), ['s2', 's1']);

      await repo.eliminar('s2');
      expect(await repo.obtenerPorPaciente('p1'), hasLength(1));
    });
  });

  group('Repositorios locales (sembast)', () {
    test('PacienteRepositoryLocal: persiste todos los campos', () async {
      final db = await databaseFactoryMemory.openDatabase('pacientes.db');
      final repo = PacienteRepositoryLocal(db);

      final p = Paciente(
        id: 'p1',
        nombre: 'Ana',
        apellido: 'García',
        fechaNacimiento: DateTime(1990, 5, 14),
        sexo: 'Femenino',
        notas: 'Motivo de consulta: ansiedad.',
        fechaRegistro: DateTime(2026, 1, 10, 9, 30),
      );
      await repo.crear(p);

      final recuperado = await repo.obtenerPorId('p1');
      expect(recuperado, isNotNull);
      expect(recuperado!.nombreCompleto, 'Ana García');
      expect(recuperado.fechaNacimiento, DateTime(1990, 5, 14));
      expect(recuperado.sexo, 'Femenino');
      expect(recuperado.notas, 'Motivo de consulta: ansiedad.');
      expect(recuperado.fechaRegistro, DateTime(2026, 1, 10, 9, 30));

      await db.close();
    });

    test('SesionRepositoryLocal: guarda y filtra por paciente', () async {
      final db = await databaseFactoryMemory.openDatabase('sesiones.db');
      final repo = SesionRepositoryLocal(db);

      await repo.crear(_sesion('s1', 'p1', DateTime(2026, 1, 1)));
      await repo.crear(_sesion('s2', 'p1', DateTime(2026, 3, 1)));
      await repo.crear(_sesion('s3', 'p2', DateTime(2026, 2, 1)));

      expect(await repo.obtenerPorPaciente('p1'), hasLength(2));
      expect(await repo.obtenerPorPaciente('p2'), hasLength(1));
      expect(await repo.obtenerTodas(), hasLength(3));

      // Se preservan los campos de detalle de la sesión.
      final guardada = (await repo.obtenerPorPaciente('p2')).single;
      expect(guardada.siglaInstrumento, 'GAD-7');
      expect(guardada.resultadoTotal, 8);
      expect(guardada.alertas, ['Alerta de prueba']);
      expect(guardada.subescalas, ['Subescala: 5 (Media)']);

      await db.close();
    });
  });

  group('Guardado de resultados', () {
    setUp(AppRepositorios.reiniciarEnMemoria);

    test('guardarResultadoEnPaciente guarda una sesión completa', () async {
      final instrumento = aplicacionDe('phq-9')!;
      final respuestas = List<int>.filled(9, 1);
      final resultado = puntuarInstrumento(instrumento, respuestas);

      await guardarResultadoEnPaciente(
        instrumento: instrumento,
        resultado: resultado,
        respuestas: respuestas,
        idPaciente: 'p1',
      );

      final sesiones = await AppRepositorios.sesion.obtenerTodas();
      expect(sesiones, hasLength(1));
      final s = sesiones.single;
      expect(s.idPaciente, 'p1');
      expect(s.idInstrumento, 'phq-9');
      expect(s.siglaInstrumento, 'PHQ-9');
      expect(s.resultadoTotal, resultado.total);
      expect(s.resultadoEtiqueta, resultado.rango.etiqueta);
      expect(s.respuestas, respuestas);
    });

    testWidgets('La pantalla de resultado guarda en el paciente indicado',
        (tester) async {
      await AppRepositorios.paciente.crear(
        Paciente(
          id: 'p1',
          nombre: 'Ana',
          apellido: 'García',
          fechaRegistro: DateTime(2026, 1, 1),
        ),
      );
      final instrumento = aplicacionDe('phq-9')!;
      final respuestas = List<int>.filled(9, 1);
      final resultado = puntuarInstrumento(instrumento, respuestas);

      await tester.pumpWidget(
        MaterialApp(
          home: ResultadoAplicacionScreen(
            instrumento: instrumento,
            resultado: resultado,
            respuestas: respuestas,
            idPaciente: 'p1',
            nombrePaciente: 'Ana García',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Guardar en Ana García'), findsOneWidget);
      await tester.ensureVisible(find.text('Guardar en Ana García'));
      await tester.tap(find.text('Guardar en Ana García'));
      await tester.pumpAndSettle();

      expect(find.text('Resultado guardado en Ana García'), findsOneWidget);
      final sesiones = await AppRepositorios.sesion.obtenerTodas();
      expect(sesiones, hasLength(1));
      expect(sesiones.single.idPaciente, 'p1');
    });

    testWidgets('Se elige el paciente desde la hoja al guardar', (tester) async {
      await AppRepositorios.paciente.crear(
        Paciente(
          id: 'p1',
          nombre: 'Ana',
          apellido: 'García',
          fechaRegistro: DateTime(2026, 1, 1),
        ),
      );
      final instrumento = aplicacionDe('phq-9')!;
      final respuestas = List<int>.filled(9, 1);
      final resultado = puntuarInstrumento(instrumento, respuestas);

      await tester.pumpWidget(
        MaterialApp(
          home: ResultadoAplicacionScreen(
            instrumento: instrumento,
            resultado: resultado,
            respuestas: respuestas,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Guardar en un paciente…'));
      await tester.tap(find.text('Guardar en un paciente…'));
      await tester.pumpAndSettle();

      expect(find.text('Ana García'), findsOneWidget);
      await tester.tap(find.text('Ana García'));
      await tester.pumpAndSettle();

      expect(find.text('Resultado guardado en Ana García'), findsOneWidget);
      expect(await AppRepositorios.sesion.obtenerTodas(), hasLength(1));
    });
  });
}

/// Construye una sesión de prueba con valores determinados.
Sesion _sesion(String id, String idPaciente, DateTime fecha) {
  return Sesion(
    id: id,
    idPaciente: idPaciente,
    idInstrumento: 'gad-7',
    siglaInstrumento: 'GAD-7',
    nombreInstrumento: 'Escala de Ansiedad Generalizada',
    fechaAplicacion: fecha,
    respuestas: const [1, 1, 1, 1, 1, 1, 1, 1],
    resultadoTotal: 8,
    resultadoEtiqueta: 'Moderada',
    resultadoDescripcion: 'Ansiedad moderada.',
    alertas: ['Alerta de prueba'],
    subescalas: ['Subescala: 5 (Media)'],
  );
}
