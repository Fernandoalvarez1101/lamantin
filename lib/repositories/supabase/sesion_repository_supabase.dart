import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/sesion.dart';
import '../sesion_repository.dart';

/// Implementación de [SesionRepository] sobre Supabase (tabla `sesiones`).
///
/// Las columnas usan snake_case en Postgres y se mapean al modelo Dart.
/// Cada consulta filtra por el profesional autenticado (`profesional_id`)
/// como defensa en profundidad: además, las políticas RLS de la base
/// garantizan que nadie pueda ver ni tocar datos ajenos.
class SesionRepositorySupabase implements SesionRepository {
  SesionRepositorySupabase(this._client);

  final SupabaseClient _client;

  /// Id del profesional logueado; lanza si no hay sesión activa.
  String get _profesionalId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw StateError('No hay sesión de profesional activa.');
    }
    return id;
  }

  @override
  Future<List<Sesion>> obtenerTodas() async {
    final filas = await _client
        .from('sesiones')
        .select()
        .eq('profesional_id', _profesionalId)
        .order('fecha_aplicacion', ascending: false);
    return [for (final fila in filas) _sesionDesdeFila(fila)];
  }

  @override
  Future<List<Sesion>> obtenerPorPaciente(String idPaciente) async {
    final filas = await _client
        .from('sesiones')
        .select()
        .eq('id_paciente', idPaciente)
        .eq('profesional_id', _profesionalId)
        .order('fecha_aplicacion', ascending: false);
    return [for (final fila in filas) _sesionDesdeFila(fila)];
  }

  @override
  Future<void> crear(Sesion sesion) async {
    // profesional_id no se envía: la base lo asigna con auth.uid().
    await _client.from('sesiones').insert(_sesionAFila(sesion));
  }

  @override
  Future<void> eliminar(String id) async {
    await _client
        .from('sesiones')
        .delete()
        .eq('id', id)
        .eq('profesional_id', _profesionalId);
  }
}

Sesion _sesionDesdeFila(Map<String, dynamic> fila) => Sesion(
      id: fila['id'] as String,
      idPaciente: fila['id_paciente'] as String,
      idInstrumento: fila['id_instrumento'] as String,
      siglaInstrumento: fila['sigla_instrumento'] as String,
      nombreInstrumento: fila['nombre_instrumento'] as String,
      fechaAplicacion: DateTime.parse(fila['fecha_aplicacion'] as String),
      respuestas:
          (fila['respuestas'] as List<dynamic>? ?? const []).cast<int>(),
      resultadoTotal: fila['resultado_total'] as int,
      resultadoEtiqueta: fila['resultado_etiqueta'] as String? ?? '',
      resultadoDescripcion: fila['resultado_descripcion'] as String? ?? '',
      alertas:
          (fila['alertas'] as List<dynamic>? ?? const []).cast<String>(),
      subescalas:
          (fila['subescalas'] as List<dynamic>? ?? const []).cast<String>(),
    );

Map<String, dynamic> _sesionAFila(Sesion s) => {
      'id': s.id,
      'id_paciente': s.idPaciente,
      'id_instrumento': s.idInstrumento,
      'sigla_instrumento': s.siglaInstrumento,
      'nombre_instrumento': s.nombreInstrumento,
      'fecha_aplicacion': s.fechaAplicacion.toIso8601String(),
      'respuestas': s.respuestas,
      'resultado_total': s.resultadoTotal,
      'resultado_etiqueta': s.resultadoEtiqueta,
      'resultado_descripcion': s.resultadoDescripcion,
      'alertas': s.alertas,
      'subescalas': s.subescalas,
    };
