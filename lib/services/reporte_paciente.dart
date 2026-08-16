import '../models/sesion.dart';

/// Grupo de sesiones de un mismo instrumento, ordenadas de la más antigua a
/// la más reciente.
class GrupoInstrumento {
  const GrupoInstrumento({
    required this.idInstrumento,
    required this.sigla,
    required this.nombre,
    required this.sesiones,
  });

  final String idInstrumento;
  final String sigla;
  final String nombre;
  final List<Sesion> sesiones;
}

/// Agrupa las sesiones por instrumento (en el orden de primera aparición) y
/// ordena cada grupo de más antigua a más reciente.
///
/// Es la fuente de verdad que comparten la pantalla de informe y los
/// exportadores (PDF y texto).
List<GrupoInstrumento> agruparSesionesPorInstrumento(List<Sesion> sesiones) {
  final orden = <String>[];
  final mapa = <String, List<Sesion>>{};
  for (final sesion in sesiones) {
    mapa.putIfAbsent(sesion.idInstrumento, () {
      orden.add(sesion.idInstrumento);
      return <Sesion>[];
    }).add(sesion);
  }

  return [
    for (final id in orden)
      GrupoInstrumento(
        idInstrumento: id,
        sigla: mapa[id]!.first.siglaInstrumento,
        nombre: mapa[id]!.first.nombreInstrumento,
        sesiones: mapa[id]!
          ..sort((a, b) => a.fechaAplicacion.compareTo(b.fechaAplicacion)),
      ),
  ];
}
