import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones genéricas del WHOQOL-BREF (escala 1-5).
const List<OpcionRespuesta> _opcionesWhoqol = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 1),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 2),
  OpcionRespuesta(etiqueta: 'Moderado', valor: 3),
  OpcionRespuesta(etiqueta: 'Bastante', valor: 4),
  OpcionRespuesta(etiqueta: 'Totalmente', valor: 5),
];

/// Bandas descriptivas de los dominios (4-20).
const List<RangoPuntuacion> _bandasDominio = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 4,
    maximo: 20,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte clínicos publicados.',
    descriptiva: true,
  ),
];

/// WHOQOL-BREF: Cuestionario de Calidad de Vida de la OMS (versión
/// abreviada, 1996).
///
/// Evalúa la calidad de vida percibida en cuatro dominios (físico,
/// psicológico, relaciones sociales y ambiente). Los ítems 3, 4 y 26 se
/// puntúan de forma invertida y cada dominio se transforma a una escala
/// de 4 a 20.
const InstrumentoAplicable whoqolBrefAplicable = InstrumentoAplicable(
  id: 'whoqol-bref',
  sigla: 'WHOQOL-BREF',
  titulo: 'Cuestionario de Calidad de Vida de la OMS (versión abreviada)',
  instrucciones: 'Las siguientes preguntas se refieren a cómo percibe su '
      'calidad de vida, su salud y otras áreas de su vida.',
  preguntas: [
    Pregunta(
        texto: '¿Cómo calificaría su calidad de vida?',
        opciones: _opcionesWhoqol,
        puntuable: false),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está con su salud?',
        opciones: _opcionesWhoqol,
        puntuable: false),
    Pregunta(
        texto:
            '¿Hasta qué punto el dolor (físico) le impide hacer lo que necesita?',
        opciones: _opcionesWhoqol,
        invertida: true),
    Pregunta(
        texto:
            '¿Cuánto necesita de cualquier tratamiento médico para funcionar en su vida diaria?',
        opciones: _opcionesWhoqol,
        invertida: true),
    Pregunta(texto: '¿Cuánto disfruta de la vida?', opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿En qué medida siente que su vida tiene sentido?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Qué tan bien es capaz de concentrarse?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Qué tan segura se siente en su vida diaria?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Qué tan saludable es el ambiente físico a su alrededor?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Tiene suficiente energía para la vida diaria?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Acepta usted su apariencia física?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Tiene suficiente dinero para cubrir sus necesidades?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto:
            '¿Qué tan disponible tiene la información que necesita en su vida diaria?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto:
            '¿En qué medida tiene oportunidad de realizar actividades de ocio?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Qué tan bien es capaz de desplazarse de un lugar a otro?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está con su sueño?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto:
            '¿Cuán satisfecho(a) está con su habilidad para realizar sus actividades de la vida diaria?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está con su capacidad de trabajo?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está consigo mismo(a)?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está con sus relaciones personales?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está con su vida sexual?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto:
            '¿Cuán satisfecho(a) está con el apoyo que recibe de sus amigos?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto:
            '¿Cuán satisfecho(a) está con las condiciones del lugar donde vive?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Tiene suficiente acceso a los servicios de salud?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto: '¿Cuán satisfecho(a) está con su medio de transporte?',
        opciones: _opcionesWhoqol),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiene sentimientos negativos, tales como tristeza, desesperanza, ansiedad o depresión?',
        opciones: _opcionesWhoqol,
        invertida: true),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 26,
      maximo: 130,
      etiqueta: 'Ver dominios',
      descripcion: 'Este instrumento se interpreta por dominios.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'fisico',
      nombre: 'Dominio físico',
      descripcion: 'Dolor, energía, sueño, movilidad y actividades diarias.',
      indicesPregunta: [2, 3, 9, 14, 15, 16, 17],
      rangos: _bandasDominio,
      calcularPuntuacion: _transformarDominio,
    ),
    SubescalaPuntuacion(
      id: 'psicologico',
      nombre: 'Dominio psicológico',
      descripcion: 'Emociones, autoestima, concentración y sentido de la vida.',
      indicesPregunta: [4, 5, 6, 10, 18, 25],
      rangos: _bandasDominio,
      calcularPuntuacion: _transformarDominio,
    ),
    SubescalaPuntuacion(
      id: 'social',
      nombre: 'Relaciones sociales',
      descripcion: 'Relaciones personales, apoyo social y vida sexual.',
      indicesPregunta: [19, 20, 21],
      rangos: _bandasDominio,
      calcularPuntuacion: _transformarDominio,
    ),
    SubescalaPuntuacion(
      id: 'ambiente',
      nombre: 'Ambiente',
      descripcion: 'Seguridad, recursos, información, ocio y entorno.',
      indicesPregunta: [7, 8, 11, 12, 13, 22, 23, 24],
      rangos: _bandasDominio,
      calcularPuntuacion: _transformarDominio,
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El WHOQOL-BREF es una medida descriptiva de la calidad de vida, '
      'sin puntos de corte clínicos. Cada dominio se transforma a una '
      'escala de 4 a 20. Los ítems 3, 4 y 26 se puntúan invertidos. '
      'Gratuito con registro en la OMS.',
);

/// Transforma la suma bruta de un dominio a la escala 4-20 de la OMS.
///
/// Los ítems 3, 4 y 26 (índices 2, 3 y 25) se puntúan de forma invertida.
int _transformarDominio(List<int> respuestas, List<int> indices) {
  var raw = 0;
  for (final indice in indices) {
    var valor = respuestas[indice];
    if (indice == 2 || indice == 3 || indice == 25) {
      valor = 6 - valor;
    }
    raw += valor;
  }
  final cantidad = indices.length;
  return (((raw - cantidad) / (4 * cantidad)) * 16 + 4).round();
}
