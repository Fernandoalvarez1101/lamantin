import 'package:sembast/sembast.dart';

import '../../models/sesion.dart';
import '../sesion_repository.dart';

/// Implementación de [SesionRepository] sobre sembast.
class SesionRepositoryLocal implements SesionRepository {
  SesionRepositoryLocal(this._db);

  final Database _db;
  final _store = stringMapStoreFactory.store('sesiones');

  Future<List<Sesion>> _consultar({String? idPaciente}) async {
    var registros = await _store.find(_db);
    if (idPaciente != null) {
      registros = registros
          .where((r) => r.value['idPaciente'] == idPaciente)
          .toList();
    }
    final sesiones = registros
        .map((r) => Sesion.fromJson(Map<String, dynamic>.from(r.value)))
        .toList()
      ..sort((a, b) => b.fechaAplicacion.compareTo(a.fechaAplicacion));
    return sesiones;
  }

  @override
  Future<List<Sesion>> obtenerTodas() => _consultar();

  @override
  Future<List<Sesion>> obtenerPorPaciente(String idPaciente) =>
      _consultar(idPaciente: idPaciente);

  @override
  Future<void> crear(Sesion sesion) async {
    await _store.record(sesion.id).put(_db, sesion.toJson());
  }

  @override
  Future<void> eliminar(String id) async {
    await _store.record(id).delete(_db);
  }
}
