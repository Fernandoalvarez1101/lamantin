import 'package:sembast_web/sembast_web.dart';

/// Abre la base de datos local en web (almacenada en IndexedDB).
Future<Database> abrirBaseLocal() async {
  return databaseFactoryWeb.openDatabase('lamantin.db');
}
