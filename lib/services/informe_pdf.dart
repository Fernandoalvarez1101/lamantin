import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/paciente.dart';
import '../models/sesion.dart';
import '../utils/formato.dart';
import 'reporte_paciente.dart';

/// Genera el informe clínico del paciente en PDF (A4).
///
/// Incluye datos del paciente, resumen general, y por cada instrumento la
/// tabla de sesiones con su evolución.
Future<Uint8List> generarInformePdf({
  required Paciente paciente,
  required List<Sesion> sesiones,
}) async {
  final grupos = agruparSesionesPorInstrumento(sesiones);
  final doc = pw.Document();
  final ahora = DateTime.now();

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      header: (context) => pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 6),
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(color: PdfColors.purple700, width: 1.5),
          ),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Lamantin',
              style: const pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
                color: PdfColors.purple700,
              ),
            ),
            pw.Text(
              'Informe clínico · ${formatearFecha(ahora)}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ),
      ),
      footer: (context) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 8),
        child: pw.Text(
          'Generado por Lamantin. Los resultados no sustituyen una '
          'evaluación profesional.',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          textAlign: pw.TextAlign.center,
        ),
      ),
      build: (context) => [
        pw.Header(level: 0, child: pw.Text(paciente.nombreCompleto)),
        _datosPaciente(paciente),
        pw.SizedBox(height: 16),
        pw.Header(level: 1, child: pw.Text('Resumen')),
        _tablaResumen(sesiones, grupos),
        pw.SizedBox(height: 16),
        for (final grupo in grupos) ...[
          pw.Header(level: 1, child: pw.Text(grupo.sigla)),
          pw.Paragraph(text: grupo.nombre),
          pw.SizedBox(height: 6),
          _tablaSesiones(grupo.sesiones),
          if (grupo.sesiones.length >= 2) ...[
            pw.SizedBox(height: 6),
            _evolucion(grupo.sesiones),
          ],
          pw.SizedBox(height: 12),
        ],
      ],
    ),
  );

  return doc.save();
}

pw.Widget _datosPaciente(Paciente p) {
  final filas = <List<String>>[
    ['Nombre', p.nombreCompleto],
    if (p.fechaNacimiento != null)
      [
        'Nacimiento',
        '${formatearFecha(p.fechaNacimiento!)}'
            '${p.edad != null ? ' (${p.edad} años)' : ''}',
      ],
    if (p.sexo != null) ['Sexo', p.sexo!],
    ['Fecha de alta', formatearFecha(p.fechaRegistro)],
    if (p.notas != null) ['Notas', p.notas!],
  ];

  return pw.TableHelper.fromTextArray(
    headers: const ['Dato', 'Valor'],
    data: filas,
    columnWidths: {0: const pw.FixedColumnWidth(100)},
    cellPadding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    headerStyle: const pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.white,
    ),
    headerDecoration: const pw.BoxDecoration(color: PdfColors.purple700),
    cellStyle: const pw.TextStyle(fontSize: 10),
  );
}

pw.Widget _tablaResumen(List<Sesion> sesiones, List<GrupoInstrumento> grupos) {
  final conAlertas = sesiones.where((s) => s.tieneAlertas).length;
  return pw.TableHelper.fromTextArray(
    headers: const ['Total de sesiones', 'Instrumentos', 'Sesiones con alertas'],
    data: [
      ['${sesiones.length}', '${grupos.length}', '$conAlertas'],
    ],
    cellPadding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    headerStyle: const pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.white,
    ),
    headerDecoration: const pw.BoxDecoration(color: PdfColors.grey800),
    cellStyle: const pw.TextStyle(fontSize: 10),
  );
}

pw.Widget _tablaSesiones(List<Sesion> grupo) {
  return pw.TableHelper.fromTextArray(
    headers: const ['Fecha', 'Puntuación', 'Interpretación', 'Alerta'],
    data: [
      for (final s in grupo.reversed)
        [
          formatearFechaHora(s.fechaAplicacion),
          '${s.resultadoTotal}',
          s.resultadoEtiqueta.isEmpty ? '-' : s.resultadoEtiqueta,
          s.tieneAlertas ? 'Sí' : 'No',
        ],
    ],
    cellPadding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    headerStyle: const pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.purple700,
    ),
    headerDecoration: const pw.BoxDecoration(
      color: PdfColors.purple50,
    ),
    cellStyle: const pw.TextStyle(fontSize: 10),
  );
}

pw.Widget _evolucion(List<Sesion> grupo) {
  final primera = grupo.first;
  final ultima = grupo.last;
  final delta = ultima.resultadoTotal - primera.resultadoTotal;
  final etiquetaPrimera =
      primera.resultadoEtiqueta.isEmpty ? 'bruto' : primera.resultadoEtiqueta;
  final etiquetaUltima =
      ultima.resultadoEtiqueta.isEmpty ? 'bruto' : ultima.resultadoEtiqueta;

  return pw.Text(
    'Evolución: ${primera.resultadoTotal} ($etiquetaPrimera) -> '
    '${ultima.resultadoTotal} ($etiquetaUltima) · '
    'Variación: ${delta >= 0 ? '+' : ''}$delta puntos',
    style: const pw.TextStyle(
      fontSize: 10,
      color: PdfColors.grey800,
      fontStyle: pw.FontStyle.italic,
    ),
  );
}
