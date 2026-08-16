import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del GDS-15 (sí/no).
const List<OpcionRespuesta> _opcionesGds = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// GDS-15: Escala de Depresión Geriátrica, versión corta
/// (Yesavage y Sheikh, 1986).
///
/// Cribado de depresión en adultos mayores. Los ítems formulados en
/// positivo (1, 5, 7, 11 y 13) se puntúan de forma invertida.
const InstrumentoAplicable gds15Aplicable = InstrumentoAplicable(
  id: 'gds-15',
  sigla: 'GDS-15',
  titulo: 'Escala de Depresión Geriátrica (versión corta)',
  instrucciones: 'Responda sí o no según cómo se haya sentido durante la '
      'última semana.',
  preguntas: [
    Pregunta(
        texto: '¿Está usted básicamente satisfecho(a) con su vida?',
        opciones: _opcionesGds,
        invertida: true),
    Pregunta(
        texto: '¿Ha abandonado muchas de sus actividades e intereses?',
        opciones: _opcionesGds),
    Pregunta(texto: '¿Siente que su vida está vacía?', opciones: _opcionesGds),
    Pregunta(
        texto: '¿Se siente aburrido(a) con frecuencia?',
        opciones: _opcionesGds),
    Pregunta(
        texto: '¿Se encuentra de buen ánimo la mayor parte del tiempo?',
        opciones: _opcionesGds,
        invertida: true),
    Pregunta(
        texto: '¿Teme que algo malo le vaya a pasar?', opciones: _opcionesGds),
    Pregunta(
        texto: '¿Se siente feliz la mayor parte del tiempo?',
        opciones: _opcionesGds,
        invertida: true),
    Pregunta(
        texto: '¿Se siente con frecuencia desamparado(a), sin esperanza?',
        opciones: _opcionesGds),
    Pregunta(
        texto:
            '¿Prefiere quedarse en casa en vez de salir a hacer cosas nuevas?',
        opciones: _opcionesGds),
    Pregunta(
        texto:
            '¿Cree que tiene más problemas de memoria que la mayoría de la gente?',
        opciones: _opcionesGds),
    Pregunta(
        texto: '¿Piensa que es maravilloso estar vivo(a)?',
        opciones: _opcionesGds,
        invertida: true),
    Pregunta(
        texto: '¿Se siente inútil como está ahora?', opciones: _opcionesGds),
    Pregunta(
        texto: '¿Se siente lleno(a) de energía?',
        opciones: _opcionesGds,
        invertida: true),
    Pregunta(
        texto: '¿Siente que su situación es desesperada?',
        opciones: _opcionesGds),
    Pregunta(
        texto: '¿Piensa que la mayoría de la gente está mejor que usted?',
        opciones: _opcionesGds),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 4,
      etiqueta: 'Normal',
      descripcion: 'Sin indicadores de depresión.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 5,
      maximo: 8,
      etiqueta: 'Leve',
      descripcion: 'Indicadores de depresión leve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 9,
      maximo: 11,
      etiqueta: 'Moderada',
      descripcion: 'Indicadores de depresión moderada.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 12,
      maximo: 15,
      etiqueta: 'Severa',
      descripcion: 'Indicadores de depresión severa.',
    ),
  ],
  nota: 'El GDS-15 es una herramienta de cribado, no un diagnóstico. '
      'La escala original está en dominio público. Los ítems 1, 5, 7, 11 '
      'y 13 se puntúan de forma invertida.',
);
