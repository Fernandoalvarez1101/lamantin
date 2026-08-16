import '../models/sesion.dart';

/// Acceso a las sesiones (aplicaciones de instrumentos).
///
/// Esta interfaz permite intercambiar la implementación (local, Firestore,
/// etc.) sin modificar las pantallas.
abstract class SesionRepository {
  /// Devuelve todas las sesiones ordenadas de más reciente a más antigua.
  Future<List<Sesion>> obtenerTodas();

  /// Devuelve las sesiones de un paciente, de más reciente a más antigua.
  Future<List<Sesion>> obtenerPorPaciente(String idPaciente);

  /// Guarda una sesión nueva.
  Future<void> crear(Sesion sesion);

  /// Elimina una sesión por su [id].
  Future<void> eliminar(String id);
}
