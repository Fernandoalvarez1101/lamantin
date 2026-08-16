import '../models/paciente.dart';

/// Acceso a los datos de pacientes.
///
/// Esta interfaz permite intercambiar la implementación (local, Firestore,
/// etc.) sin modificar las pantallas.
abstract class PacienteRepository {
  /// Devuelve todos los pacientes ordenados por nombre.
  Future<List<Paciente>> obtenerTodos();

  /// Devuelve el paciente con [id], o null si no existe.
  Future<Paciente?> obtenerPorId(String id);

  /// Guarda un paciente nuevo.
  Future<void> crear(Paciente paciente);

  /// Actualiza un paciente existente.
  Future<void> actualizar(Paciente paciente);

  /// Elimina un paciente por su [id].
  Future<void> eliminar(String id);
}
