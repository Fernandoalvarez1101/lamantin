import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/paciente.dart';
import '../paciente_repository.dart';

/// Implementación de [PacienteRepository] sobre Supabase (tabla `pacientes`).
///
/// Las columnas usan snake_case en Postgres y se mapean al modelo Dart.
/// Cada consulta filtra por el profesional autenticado (`profesional_id`)
/// como defensa en profundidad: además, las políticas RLS de la base
/// garantizan que nadie pueda ver ni tocar datos ajenos.
class PacienteRepositorySupabase implements PacienteRepository {
  PacienteRepositorySupabase(this._client);

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
  Future<List<Paciente>> obtenerTodos() async {
    final filas = await _client
        .from('pacientes')
        .select()
        .eq('profesional_id', _profesionalId);
    final pacientes = [
      for (final fila in filas) _pacienteDesdeFila(fila),
    ]..sort((a, b) => a.nombreCompleto.compareTo(b.nombreCompleto));
    return pacientes;
  }

  @override
  Future<Paciente?> obtenerPorId(String id) async {
    final filas = await _client
        .from('pacientes')
        .select()
        .eq('id', id)
        .eq('profesional_id', _profesionalId);
    if (filas.isEmpty) return null;
    return _pacienteDesdeFila(filas.first);
  }

  @override
  Future<void> crear(Paciente paciente) async {
    // profesional_id no se envía: la base lo asigna con auth.uid().
    await _client.from('pacientes').insert(_pacienteAFila(paciente));
  }

  @override
  Future<void> actualizar(Paciente paciente) async {
    await _client
        .from('pacientes')
        .update(_pacienteAFila(paciente))
        .eq('id', paciente.id)
        .eq('profesional_id', _profesionalId);
  }

  @override
  Future<void> eliminar(String id) async {
    await _client
        .from('pacientes')
        .delete()
        .eq('id', id)
        .eq('profesional_id', _profesionalId);
  }
}

Paciente _pacienteDesdeFila(Map<String, dynamic> fila) => Paciente(
      id: fila['id'] as String,
      nombre: fila['nombre'] as String,
      apellido: fila['apellido'] as String,
      fechaNacimiento: fila['fecha_nacimiento'] == null
          ? null
          : DateTime.parse(fila['fecha_nacimiento'] as String),
      sexo: fila['sexo'] as String?,
      notas: fila['notas'] as String?,
      fechaRegistro: DateTime.parse(fila['fecha_registro'] as String),
    );

Map<String, dynamic> _pacienteAFila(Paciente p) => {
      'id': p.id,
      'nombre': p.nombre,
      'apellido': p.apellido,
      'fecha_nacimiento': p.fechaNacimiento?.toIso8601String(),
      'sexo': p.sexo,
      'notas': p.notas,
      'fecha_registro': p.fechaRegistro.toIso8601String(),
    };
