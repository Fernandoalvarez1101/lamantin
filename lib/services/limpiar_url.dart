// Punto de entrada multiplataforma de `limpiarParametrosAuthEnUrl`.
//
// En web se usa la implementación con la API del navegador; en el resto de
// las plataformas, una versión vacía.
export 'limpiar_url_stub.dart'
    if (dart.library.js_interop) 'limpiar_url_web.dart';
