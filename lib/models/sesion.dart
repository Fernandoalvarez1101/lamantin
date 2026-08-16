/// Aplicación de un instrumento de medición a un paciente.
class Sesion {
  const Sesion({
    required this.id,
    required this.idPaciente,
    required this.idInstrumento,
    required this.siglaInstrumento,
    required this.nombreInstrumento,
    required this.fechaAplicacion,
    required this.respuestas,
    required this.resultadoTotal,
    required this.resultadoEtiqueta,
    required this.resultadoDescripcion,
    this.alertas = const [],
    this.subescalas = const [],
  });

  factory Sesion.fromJson(Map<String, dynamic> json) => Sesion(
        id: json['id'] as String,
        idPaciente: json['idPaciente'] as String,
        idInstrumento: json['idInstrumento'] as String,
        siglaInstrumento: json['siglaInstrumento'] as String,
        nombreInstrumento: json['nombreInstrumento'] as String,
        fechaAplicacion: DateTime.parse(json['fechaAplicacion'] as String),
        respuestas: (json['respuestas'] as List<dynamic>).cast<int>(),
        resultadoTotal: json['resultadoTotal'] as int,
        resultadoEtiqueta: json['resultadoEtiqueta'] as String,
        resultadoDescripcion: json['resultadoDescripcion'] as String,
        alertas:
            (json['alertas'] as List<dynamic>? ?? const []).cast<String>(),
        subescalas:
            (json['subescalas'] as List<dynamic>? ?? const []).cast<String>(),
      );

  final String id;
  final String idPaciente;
  final String idInstrumento;
  final String siglaInstrumento;
  final String nombreInstrumento;
  final DateTime fechaAplicacion;

  /// Valores de respuesta a las preguntas puntuables, en orden.
  final List<int> respuestas;

  final int resultadoTotal;
  final String resultadoEtiqueta;
  final String resultadoDescripcion;

  /// Mensajes de las alertas clínicas activadas.
  final List<String> alertas;

  /// Resumen legible de las subescalas (p. ej. «Depresión: 12 (Moderada)»).
  final List<String> subescalas;

  bool get tieneAlertas => alertas.isNotEmpty;

  Map<String, dynamic> toJson() => {
        'id': id,
        'idPaciente': idPaciente,
        'idInstrumento': idInstrumento,
        'siglaInstrumento': siglaInstrumento,
        'nombreInstrumento': nombreInstrumento,
        'fechaAplicacion': fechaAplicacion.toIso8601String(),
        'respuestas': respuestas,
        'resultadoTotal': resultadoTotal,
        'resultadoEtiqueta': resultadoEtiqueta,
        'resultadoDescripcion': resultadoDescripcion,
        'alertas': alertas,
        'subescalas': subescalas,
      };
}
