import 'package:web/web.dart' as web;

/// Quita los parámetros (y el fragmento) de la barra de direcciones sin
/// recargar la página.
///
/// Supabase devuelve el enlace de recuperación con un código de un solo uso en
/// la URL. Una vez canjeado, conviene limpiarla: así la dirección queda
/// prolija y un refresco no vuelve a intentar usar el mismo código.
void limpiarParametrosAuthEnUrl() {
  final base = Uri.base;
  web.window.history.replaceState(null, '', '${base.origin}${base.path}');
}
