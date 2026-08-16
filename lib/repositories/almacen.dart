import '../config/supabase_config.dart';
import 'local/database_factory.dart';
import 'local/paciente_repository_local.dart';
import 'local/sesion_repository_local.dart';
import 'memoria/paciente_repository_memoria.dart';
import 'memoria/sesion_repository_memoria.dart';
import 'paciente_repository.dart';
import 'sesion_repository.dart';
import 'supabase/supabase_cliente.dart';

/// Punto de acceso a los repositorios de la aplicación.
///
/// Por defecto usa implementaciones en memoria (ideales para pruebas).
/// [inicializarLocal] usa el almacenamiento local (sembast) y
/// [inicializarSupabase] conecta a la base en la nube.
class AppRepositorios {
  static PacienteRepository paciente = PacienteRepositoryMemoria();
  static SesionRepository sesion = SesionRepositoryMemoria();

  static bool _inicializado = false;

  /// Abre la base de datos local y usa sus repositorios.
  static Future<void> inicializarLocal() async {
    if (_inicializado) return;
    final db = await abrirBaseLocal();
    paciente = PacienteRepositoryLocal(db);
    sesion = SesionRepositoryLocal(db);
    _inicializado = true;
  }

  /// Conecta a Supabase y usa sus repositorios.
  static Future<void> inicializarSupabase() async {
    final repos = await conectarSupabase();
    paciente = repos.pacientes;
    sesion = repos.sesiones;
    _inicializado = true;
  }

  /// Inicializa según la configuración: Supabase si está configurada,
  /// si no la base local.
  static Future<void> inicializar() async {
    if (SupabaseConfig.estaConfigurado) {
      await inicializarSupabase();
    } else {
      await inicializarLocal();
    }
  }

  /// Restablece los repositorios en memoria (útil en pruebas).
  static void reiniciarEnMemoria() {
    paciente = PacienteRepositoryMemoria();
    sesion = SesionRepositoryMemoria();
    _inicializado = false;
  }
}

