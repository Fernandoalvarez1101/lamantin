import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'limpiar_url.dart';

/// Estado y utilidades del flujo de recuperación de contraseña.
///
/// El enlace que Supabase envía por correo vuelve a la app con la sesión de
/// recuperación dentro de la URL (flujo PKCE: `?code=...`; flujo implícito:
/// `#access_token=...&type=recovery`).
///
/// En web `Supabase.initialize()` procesa esa URL *antes* de que exista ningún
/// listener de `onAuthStateChange`, por lo que el evento
/// [AuthChangeEvent.passwordRecovery] se pierde y el profesional entraría al
/// dashboard con una sesión temporal. Para evitarlo, en web la app canjea el
/// callback por su cuenta con [procesarCallbackWeb] y guarda el resultado en
/// [pendiente]; en móvil y escritorio el evento sí llega después de inicializar
/// y lo captura el listener de `AuthGate`.
class RecuperacionPassword {
  RecuperacionPassword._();

  /// `true` cuando el profesional volvió desde el enlace del correo y hay que
  /// pedirle una contraseña nueva antes de entrar a la app.
  static bool pendiente = false;

  /// Motivo por el que no se pudo usar el enlace del correo, si falló.
  ///
  /// El caso más común es abrir el enlace en otro navegador: el código PKCE se
  /// guarda en el almacenamiento local del navegador donde se pidió el cambio.
  /// `AuthGate` lo muestra una sola vez en la pantalla de ingreso.
  static String? error;

  /// URL a la que Supabase redirige después del enlace del correo.
  ///
  /// En web se usa la URL actual del navegador, así que funciona igual en
  /// desarrollo (`http://localhost:8081/`) y en producción
  /// (`https://fernandoalvarez1101.github.io/lamantin/`). En el resto de las
  /// plataformas devuelve `null` para que Supabase use la «Site URL».
  static String? get urlRetorno {
    if (!kIsWeb) return null;
    final base = Uri.base;
    return '${base.origin}${base.path}';
  }

  /// Indica si [uri] trae parámetros de un callback de autenticación.
  ///
  /// Se usa el mismo criterio que el SDK de Supabase para reconocer deep links:
  /// los parámetros pueden venir en la query (`?code=...`) o en el fragmento
  /// (`#access_token=...`).
  static bool esCallbackAuth(Uri uri) {
    final fragmento = Uri.splitQueryString(uri.fragment);
    bool tiene(String clave) =>
        uri.queryParameters.containsKey(clave) ||
        fragmento.containsKey(clave);
    return tiene('access_token') ||
        tiene('code') ||
        tiene('error') ||
        tiene('error_code') ||
        tiene('error_description');
  }

  /// Canjea el callback que dejó Supabase en la URL (sólo en web).
  ///
  /// Se llama una única vez, al arrancar la app. Devuelve `true` si el enlace
  /// era de recuperación de contraseña. Los errores se ignoran a propósito: un
  /// enlace vencido o ya usado no debe impedir que la app abra normalmente.
  static Future<bool> procesarCallbackWeb() async {
    if (!kIsWeb) return false;

    final uri = Uri.base;
    if (!esCallbackAuth(uri)) return false;

    pendiente = false;
    error = null;
    try {
      final respuesta =
          await Supabase.instance.client.auth.getSessionFromUrl(uri);
      final tipo = respuesta.redirectType;
      // PKCE guarda el tipo como `passwordRecovery`; el flujo implícito lo
      // devuelve como `recovery`.
      pendiente = tipo == 'recovery' || tipo == 'passwordRecovery';
    } on AuthException {
      // Enlace vencido, ya usado o abierto en otro navegador: se avisa en el
      // login en lugar de dejar al profesional sin explicación.
      error = 'El enlace del correo ya venció o se abrió en otro navegador. '
          'Pedí uno nuevo desde «¿Olvidaste tu contraseña?».';
    } catch (_) {
      // Sin red o respuesta inesperada: el login mostrará el error al entrar.
    } finally {
      // La URL ya se consumió (o el código es inválido): se limpia siempre
      // para que un refresco no vuelva a intentar el canje.
      limpiarParametrosAuthEnUrl();
    }
    return pendiente;
  }

  /// Cierra el flujo (contraseña actualizada o cancelado por el profesional).
  static void finalizar() {
    pendiente = false;
  }
}

