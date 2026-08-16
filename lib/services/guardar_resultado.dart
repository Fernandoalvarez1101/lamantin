import '../models/instrumento_aplicable.dart';
import '../models/resultado_aplicacion.dart';
import '../models/sesion.dart';
import '../repositories/almacen.dart';

/// Construye y guarda una [Sesion] a partir de una aplicación terminada.
///
/// Devuelve la sesión guardada para que la pantalla pueda mostrar la
/// confirmación o navegar al detalle.
Future<Sesion> guardarResultadoEnPaciente({
  required InstrumentoAplicable instrumento,
  required ResultadoAplicacion resultado,
  required List<int> respuestas,
  required String idPaciente,
}) async {
  final sesion = Sesion(
    id: 's${DateTime.now().microsecondsSinceEpoch}',
    idPaciente: idPaciente,
    idInstrumento: instrumento.id,
    siglaInstrumento: instrumento.sigla,
    nombreInstrumento: instrumento.titulo,
    fechaAplicacion: DateTime.now(),
    respuestas: respuestas,
    resultadoTotal: resultado.total,
    resultadoEtiqueta: resultado.rango.descriptiva
        ? ''
        : resultado.rango.etiqueta,
    resultadoDescripcion: resultado.rango.descripcion,
    alertas: resultado.alertasActivadas,
    subescalas: resultado.subescalas
        .map((s) =>
            '${s.nombre}: ${s.total} (${s.rango.descriptiva ? 'bruto' : s.rango.etiqueta})')
        .toList(),
  );

  await AppRepositorios.sesion.crear(sesion);
  return sesion;
}
