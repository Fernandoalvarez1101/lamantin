import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta de la Escala de Florecimiento (acuerdo 1-7).
const List<OpcionRespuesta> _opcionesFs = [
  OpcionRespuesta(etiqueta: 'Muy en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'Ligeramente en desacuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Ni de acuerdo ni en desacuerdo', valor: 4),
  OpcionRespuesta(etiqueta: 'Ligeramente de acuerdo', valor: 5),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 6),
  OpcionRespuesta(etiqueta: 'Muy de acuerdo', valor: 7),
];

/// Escala de Florecimiento (Diener et al., 2009).
///
/// Mide el bienestar psicológico y social percibido (éxito, relaciones,
/// propósito y optimismo).
const InstrumentoAplicable escalaFlorecimientoAplicable = InstrumentoAplicable(
  id: 'escala-florecimiento',
  sigla: 'FS',
  titulo: 'Escala de Florecimiento',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
        texto: 'Llevo una vida con propósito y sentido', opciones: _opcionesFs),
    Pregunta(
        texto: 'Mis relaciones sociales me apoyan y son gratificantes',
        opciones: _opcionesFs),
    Pregunta(
        texto:
            'Estoy comprometido(a) e interesado(a) en mis actividades diarias',
        opciones: _opcionesFs),
    Pregunta(
        texto:
            'Contribuyo activamente a la felicidad y el bienestar de los demás',
        opciones: _opcionesFs),
    Pregunta(
        texto:
            'Soy competente y capaz en las actividades que son importantes para mí',
        opciones: _opcionesFs),
    Pregunta(
        texto: 'Soy una buena persona y vivo una buena vida',
        opciones: _opcionesFs),
    Pregunta(
        texto: 'Soy optimista respecto a mi futuro', opciones: _opcionesFs),
    Pregunta(texto: 'La gente me respeta', opciones: _opcionesFs),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 8,
      maximo: 56,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte clínicos normativos publicados.',
      descriptiva: true,
    ),
  ],
  nota: 'La Escala de Florecimiento es una medida descriptiva del '
      'bienestar. No existen puntos de corte clínicos publicados. Libre '
      'uso no comercial.',
);
