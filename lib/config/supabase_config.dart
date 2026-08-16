/// Configuración de Supabase.
///
/// Completar con los datos del proyecto en el dashboard de Supabase
/// (Project Settings → API):
/// - [url]: la URL del proyecto.
/// - [publishableKey]: la clave pública (`anon` / `publishable`).
class SupabaseConfig {
  const SupabaseConfig._();

  static const String url = 'https://hfvxxngrtayjqbgfsmif.supabase.co';
  static const String publishableKey =
      'sb_publishable_FGeBGwE_M1TZ_qF-Vds-Ag_ac-Ccs0I';

  /// Indica si las credenciales ya fueron configuradas.
  static bool get estaConfigurado =>
      !url.startsWith('REEMPLAZAR') && !publishableKey.startsWith('REEMPLAZAR');
}
