import '../../models/sesion.dart';
import '../sesion_repository.dart';

/// Implementación en memoria de [SesionRepository].
///
/// Útil para pruebas y como estado por defecto antes de inicializar el
/// almacenamiento local.
class SesionRepositoryMemoria implements SesionRepository {
  final List<Sesion> _sesiones = [];

  @override
  Future<List<Sesion>> obtenerTodas() async {
    final lista = List<Sesion>.of(_sesiones)
      ..sort((a, b) => b.fechaAplicacion.compareTo(a.fechaAplicacion));
    return lista;
  }

  @override
  Future<List<Sesion>> obtenerPorPaciente(String idPaciente) async {
    final lista = _sesiones
        .where((s) => s.idPaciente == idPaciente)
        .toList()
      ..sort((a, b) => b.fechaAplicacion.compareTo(a.fechaAplicacion));
    return lista;
  }

  @override
  Future<void> crear(Sesion sesion) async {
    _sesiones.add(sesion);
  }

  @override
  Future<void> eliminar(String id) async {
    _sesiones.removeWhere((s) => s.id == id);
  }
}
