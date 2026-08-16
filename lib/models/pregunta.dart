/// Opción de respuesta de una pregunta, con su valor de puntuación.
class OpcionRespuesta {
  const OpcionRespuesta({required this.etiqueta, required this.valor});

  /// Texto visible de la opción.
  final String etiqueta;

  /// Valor numérico que aporta a la puntuación.
  final int valor;
}

/// Pregunta de un instrumento con sus opciones de respuesta.
class Pregunta {
  const Pregunta({
    required this.texto,
    required this.opciones,
    this.invertida = false,
    this.puntuable = true,
  });

  /// Enunciado de la pregunta.
  final String texto;

  /// Opciones de respuesta en orden de presentación.
  final List<OpcionRespuesta> opciones;

  /// Indica que la puntuación se invierte al calcular el total.
  ///
  /// Se usa en ítems formulados en positivo dentro de escalas de síntomas
  /// (p. ej. la CES-D o la Zung SDS), donde responder «frecuentemente»
  /// a un ítem positivo no debe sumar puntos.
  final bool invertida;

  /// Indica si la pregunta forma parte de la puntuación.
  ///
  /// Los ítems de relleno (p. ej. los 4 del LOT-R) se presentan al
  /// paciente pero no se puntúan.
  final bool puntuable;
}
