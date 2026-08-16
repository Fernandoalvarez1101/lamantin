import 'categoria_instrumento.dart';

/// Instrumento de medición psicológica de uso público.
///
/// Representa un test o cuestionario disponible en el catálogo de Lamantin,
/// con la información relevante para que el profesional decida su uso.
class Instrumento {
  const Instrumento({
    required this.id,
    required this.nombre,
    required this.sigla,
    required this.categoria,
    required this.descripcion,
    required this.autor,
    required this.anio,
    required this.numeroItems,
    required this.tiempo,
    required this.disponibilidad,
    this.poblacion,
    this.nota,
  });

  /// Identificador único del instrumento.
  final String id;

  /// Nombre completo del instrumento.
  final String nombre;

  /// Sigla o acrónimo por el que se conoce comúnmente.
  final String sigla;

  /// Categoría clínica que mide el instrumento.
  final CategoriaInstrumento categoria;

  /// Qué mide y para qué se utiliza.
  final String descripcion;

  /// Autor(es) que desarrollaron el instrumento.
  final String autor;

  /// Año de publicación original.
  final int anio;

  /// Cantidad de ítems o preguntas.
  final int numeroItems;

  /// Tiempo aproximado de aplicación.
  final String tiempo;

  /// Condición de uso público (dominio público, libre uso, etc.).
  final String disponibilidad;

  /// Población a la que está dirigido.
  final String? poblacion;

  /// Nota adicional (p. ej. sobre la versión o la puntuación).
  final String? nota;
}
