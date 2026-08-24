import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

const _dbKeyName = 'lamantin_local_db_key';

Future<String> _obtenerClaveEncriptacion() async {
  const storage = FlutterSecureStorage();
  final clave = await storage.read(key: _dbKeyName);
  if (clave != null && clave.isNotEmpty) {
    return clave;
  }

  final bytes = List<int>.generate(32, (_) => Random.secure().nextInt(256));
  final nuevaClave = base64Encode(bytes);
  await storage.write(key: _dbKeyName, value: nuevaClave);
  return nuevaClave;
}

class _EncryptedSembastEncoder extends Converter<Object?, String> {
  const _EncryptedSembastEncoder(this._base64Key);

  final String _base64Key;

  @override
  String convert(Object? input) {
    final iv = IV.fromSecureRandom(16);
    final key = Key.fromBase64(_base64Key);
    final encrypted = Encrypter(AES(key, mode: AESMode.cbc))
        .encrypt(jsonEncode(input), iv: iv);
    return base64Encode(iv.bytes + encrypted.bytes);
  }
}

class _EncryptedSembastDecoder extends Converter<String, Object?> {
  const _EncryptedSembastDecoder(this._base64Key);

  final String _base64Key;

  @override
  Object? convert(String input) {
    final bytes = base64Decode(input);
    if (bytes.length < 17) {
      throw const FormatException('Datos cifrados corruptos.');
    }

    final iv = IV(bytes.sublist(0, 16));
    final encrypted = Encrypted(bytes.sublist(16));
    final key = Key.fromBase64(_base64Key);
    final plaintext = Encrypter(AES(key, mode: AESMode.cbc)).decrypt(
      encrypted,
      iv: iv,
    );
    return jsonDecode(plaintext);
  }
}

class _EncryptedSembastCodec extends Codec<Object?, String> {
  _EncryptedSembastCodec(this._base64Key);

  final String _base64Key;

  @override
  Converter<Object?, String> get encoder =>
      _EncryptedSembastEncoder(_base64Key);

  @override
  Converter<String, Object?> get decoder =>
      _EncryptedSembastDecoder(_base64Key);

  @override
  String encode(Object? input) => encoder.convert(input);

  @override
  Object? decode(String input) => decoder.convert(input);
}

/// Abre la base de datos local en dispositivos nativos (archivo en el
/// directorio de documentos de la aplicación) cifrada en reposo.
Future<Database> abrirBaseLocal() async {
  final directorio = await getApplicationDocumentsDirectory();
  final clave = await _obtenerClaveEncriptacion();
  return databaseFactoryIo.openDatabase(
    p.join(directorio.path, 'lamantin.db'),
    codec: SembastCodec(
      signature: 'lamantin_local_v1',
      codec: _EncryptedSembastCodec(clave),
    ),
  );
}
