import 'instrumento_aplicable.dart';

/// Puntuación de una subescala de un instrumento.
class Subpuntuacion {
  const Subpuntuacion({
    required this.nombre,
    required this.total,
    required this.rango,
    required this.cantidadItems,
    this.descripcion,
  });

  /// Nombre visible de la subescala.
  final String nombre;

  /// Puntuación obtenida en la subescala.
  final int total;

  /// Banda de interpretación en la que cae la puntuación.
  final RangoPuntuacion rango;

  /// Cantidad de ítems de la subescala (para calcular la media por ítem).
  final int cantidadItems;

  /// Aclaración clínica sobre la subescala.
  final String? descripcion;
}

/// Resultado de la aplicación de un instrumento.
class ResultadoAplicacion {
  const ResultadoAplicacion({
    required this.total,
    required this.rango,
    required this.alertasActivadas,
    this.subescalas = const [],
  });

  /// Puntuación total obtenida.
  final int total;

  /// Banda de interpretación en la que cae la puntuación.
  final RangoPuntuacion rango;

  /// Mensajes de las alertas clínicas que se activaron.
  final List<String> alertasActivadas;

  /// Puntuaciones de las subescalas del instrumento (si las tiene).
  final List<Subpuntuacion> subescalas;

  /// Indica si se activó alguna alerta clínica.
  bool get tieneAlertas => alertasActivadas.isNotEmpty;
}
