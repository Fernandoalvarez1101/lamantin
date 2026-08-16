import 'package:sembast/sembast.dart';

import '../../models/paciente.dart';
import '../paciente_repository.dart';

/// Implementación de [PacienteRepository] sobre sembast.
class PacienteRepositoryLocal implements PacienteRepository {
  PacienteRepositoryLocal(this._db);

  final Database _db;
  final _store = stringMapStoreFactory.store('pacientes');

  @override
  Future<List<Paciente>> obtenerTodos() async {
    final registros = await _store.find(_db);
    final pacientes = registros
        .map((r) => Paciente.fromJson(Map<String, dynamic>.from(r.value)))
        .toList()
      ..sort((a, b) => a.nombreCompleto.compareTo(b.nombreCompleto));
    return pacientes;
  }

  @override
  Future<Paciente?> obtenerPorId(String id) async {
    final registro = await _store.record(id).get(_db);
    if (registro == null) return null;
    return Paciente.fromJson(Map<String, dynamic>.from(registro));
  }

  @override
  Future<void> crear(Paciente paciente) async {
    await _store.record(paciente.id).put(_db, paciente.toJson());
  }

  @override
  Future<void> actualizar(Paciente paciente) async {
    await _store.record(paciente.id).put(_db, paciente.toJson());
  }

  @override
  Future<void> eliminar(String id) async {
    await _store.record(id).delete(_db);
  }
}
