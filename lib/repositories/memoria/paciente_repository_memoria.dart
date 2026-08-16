import '../../models/paciente.dart';
import '../paciente_repository.dart';

/// Implementación en memoria de [PacienteRepository].
///
/// Útil para pruebas y como estado por defecto antes de inicializar el
/// almacenamiento local.
class PacienteRepositoryMemoria implements PacienteRepository {
  final Map<String, Paciente> _pacientes = {};

  @override
  Future<List<Paciente>> obtenerTodos() async {
    final lista = _pacientes.values.toList()
      ..sort((a, b) => a.nombreCompleto.compareTo(b.nombreCompleto));
    return lista;
  }

  @override
  Future<Paciente?> obtenerPorId(String id) async => _pacientes[id];

  @override
  Future<void> crear(Paciente paciente) async {
    _pacientes[paciente.id] = paciente;
  }

  @override
  Future<void> actualizar(Paciente paciente) async {
    _pacientes[paciente.id] = paciente;
  }

  @override
  Future<void> eliminar(String id) async {
    _pacientes.remove(id);
  }
}
