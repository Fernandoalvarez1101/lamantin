import 'package:flutter/foundation.dart';
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
    //
    // En web se desactiva la detección automática de la URL: el SDK procesa el
    // callback durante `Supabase.initialize()`, antes de que exista cualquier
    // listener, y el evento de recuperación de contraseña se perdería. La app
    // lo canjea por su cuenta (ver `RecuperacionPassword.procesarCallbackWeb`).
    // En móvil y escritorio se mantiene activa: ahí los deep links llegan
    // después de inicializar y sí se reciben como eventos.
    authOptions: const FlutterAuthClientOptions(
      persistSession: true,
      detectSessionInUri: !kIsWeb,
    ),
  );
  final client = Supabase.instance.client;
  return (
    pacientes: PacienteRepositorySupabase(client),
    sesiones: SesionRepositorySupabase(client),
  );
}
