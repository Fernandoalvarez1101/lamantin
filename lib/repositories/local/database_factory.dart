// Fábrica de base de datos local según la plataforma.
//
// En dispositivos nativos (Android/iOS/desktop) usa un archivo; en web
// usa IndexedDB (sembast_web).
export 'database_factory_io.dart'
    if (dart.library.html) 'database_factory_web.dart'
    if (dart.library.js_interop) 'database_factory_web.dart';
