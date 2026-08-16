import '../models/paciente.dart';
import '../models/sesion.dart';
import '../utils/formato.dart';
import 'reporte_paciente.dart';

/// Genera el informe clínico del paciente como texto plano (para copiar o
/// compartir).
String generarInformeTexto({
  required Paciente paciente,
  required List<Sesion> sesiones,
}) {
  final grupos = agruparSesionesPorInstrumento(sesiones);
  final conAlertas = sesiones.where((s) => s.tieneAlertas).length;
  final buffer = StringBuffer();

  buffer.writeln('========================================');
  buffer.writeln('LAMANTIN · INFORME CLÍNICO DEL PACIENTE');
  buffer.writeln('========================================');
  buffer.writeln();
  buffer.writeln('Paciente: ${paciente.nombreCompleto}');
  if (paciente.edad != null) buffer.writeln('Edad: ${paciente.edad} años');
  if (paciente.sexo != null) buffer.writeln('Sexo: ${paciente.sexo}');
  if (paciente.fechaNacimiento != null) {
    buffer.writeln(
      'Fecha de nacimiento: ${formatearFecha(paciente.fechaNacimiento!)}',
    );
  }
  buffer.writeln('Fecha de alta: ${formatearFecha(paciente.fechaRegistro)}');
  if (paciente.notas != null) buffer.writeln('Notas: ${paciente.notas}');
  buffer.writeln();

  buffer.writeln('RESUMEN');
  buffer.writeln('--------');
  buffer.writeln('Total de sesiones: ${sesiones.length}');
  buffer.writeln('Instrumentos aplicados: ${grupos.length}');
  buffer.writeln('Sesiones con alertas: $conAlertas');
  buffer.writeln();

  for (final grupo in grupos) {
    buffer.writeln('${grupo.sigla} · ${grupo.nombre}');
    buffer.writeln('-' * (grupo.sigla.length + grupo.nombre.length + 3));
    for (final sesion in grupo.sesiones) {
      final etiqueta = sesion.resultadoEtiqueta.isEmpty
          ? ''
          : ' (${sesion.resultadoEtiqueta})';
      final alerta = sesion.tieneAlertas ? '  [ALERTA]' : '';
      buffer.writeln(
        '  ${formatearFechaHora(sesion.fechaAplicacion)}: '
        '${sesion.resultadoTotal}$etiqueta$alerta',
      );
    }
    if (grupo.sesiones.length >= 2) {
      final primera = grupo.sesiones.first;
      final ultima = grupo.sesiones.last;
      final delta = ultima.resultadoTotal - primera.resultadoTotal;
      final etiquetaPrimera = primera.resultadoEtiqueta.isEmpty
          ? 'bruto'
          : primera.resultadoEtiqueta;
      final etiquetaUltima = ultima.resultadoEtiqueta.isEmpty
          ? 'bruto'
          : ultima.resultadoEtiqueta;
      buffer.writeln(
        '  Evolución: ${primera.resultadoTotal} ($etiquetaPrimera) -> '
        '${ultima.resultadoTotal} ($etiquetaUltima) · '
        'Variación: ${delta >= 0 ? '+' : ''}$delta puntos',
      );
    }
    buffer.writeln();
  }

  buffer.writeln('----------------------------------------');
  buffer.writeln('Generado el ${formatearFechaHora(DateTime.now())}.');
  buffer.writeln('Los resultados no sustituyen una evaluación profesional.');
  return buffer.toString();
}
