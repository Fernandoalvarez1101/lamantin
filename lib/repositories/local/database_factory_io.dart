import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

/// Abre la base de datos local en dispositivos nativos (archivo en el
/// directorio de documentos de la aplicación).
Future<Database> abrirBaseLocal() async {
  final directorio = await getApplicationDocumentsDirectory();
  return databaseFactoryIo.openDatabase(
    p.join(directorio.path, 'lamantin.db'),
  );
}
