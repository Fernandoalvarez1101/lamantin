/// Categorías que agrupan los instrumentos según el constructo que miden.
///
/// Cada categoría corresponde a un área de evaluación psicológica y sirve
/// como clasificación para navegar el catálogo de instrumentos.
enum CategoriaInstrumento {
  depresion('Depresión'),
  ansiedad('Ansiedad'),
  estres('Estrés'),
  trauma('Trauma y TEPT'),
  vocacional('Vocacional'),
  autoestima('Autoestima y autoconcepto'),
  sueno('Sueño'),
  adicciones('Adicciones'),
  personalidad('Personalidad'),
  bienestar('Bienestar y calidad de vida'),
  atencion('Atención y concentración'),
  saludMentalGeneral('Salud mental general'),
  riesgoSuicida('Riesgo suicida'),
  infantoJuvenil('Infanto-juvenil'),
  apoyoSocialSoledad('Apoyo social y soledad'),
  regulacionEmocional('Regulación emocional'),
  neurocognitivo('Neurocognitivo');

  const CategoriaInstrumento(this.nombre);

  /// Nombre legible para mostrar en la interfaz.
  final String nombre;
}
