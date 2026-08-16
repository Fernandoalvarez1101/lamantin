import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/supabase_config.dart';
import '../paciente_repository.dart';
import '../sesion_repository.dart';
import 'paciente_repository_supabase.dart';
import 'sesion_repository_supabase.dart';

/// Inicializa el cliente de Supabase y devuelve los repositorios
/// configurados para usarlo.
Future<({PacienteRepository pacientes, SesionRepository sesiones})>
    conectarSupabase() async {
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
    // Persiste la sesión entre reinicios: en web usa window.localStorage y en
    // mobile/desktop shared_preferences (ambos por defecto). Se declara
    // explícito para que la sesión del profesional no se pierda al recargar.
    authOptions: const FlutterAuthClientOptions(persistSession: true),
  );
  final client = Supabase.instance.client;
  return (
    pacientes: PacienteRepositorySupabase(client),
    sesiones: SesionRepositorySupabase(client),
  );
}
