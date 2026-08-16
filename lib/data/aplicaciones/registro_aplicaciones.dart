import '../../models/instrumento_aplicable.dart';
import 'asrs.dart';
import 'assist.dart';
import 'audit.dart';
import 'bfi44.dart';
import 'cage.dart';
import 'cesd.dart';
import 'cesdc.dart';
import 'crafft.dart';
import 'cssrs.dart';
import 'cudos.dart';
import 'dar5.dart';
import 'dass21.dart';
import 'dast10.dart';
import 'epds.dart';
import 'erq.dart';
import 'escala_florecimiento.dart';
import 'gad7.dart';
import 'gds15.dart';
import 'iesr.dart';
import 'isi.dart';
import 'ipip_neo120.dart';
import 'k10.dart';
import 'lotr.dart';
import 'maas.dart';
import 'mfq.dart';
import 'moca.dart';
import 'mspss.dart';
import 'onet_ip.dart';
import 'pcl5.dart';
import 'phq9.dart';
import 'panas.dart';
import 'psqi.dart';
import 'pss10.dart';
import 'pswq.dart';
import 'rses.dart';
import 'sbqr.dart';
import 'scared.dart';
import 'sdq.dart';
import 'snap_iv.dart';
import 'spin.dart';
import 'srq20.dart';
import 'swls.dart';
import 'taps.dart';
import 'ucla20.dart';
import 'whoqol_bref.dart';
import 'zung_sas.dart';
import 'zung_sds.dart';

/// Registro de instrumentos con aplicación completa disponible.
///
/// La clave coincide con el identificador del catálogo (`Instrumento.id`).
const Map<String, InstrumentoAplicable> aplicacionesDisponibles = {
  // Depresión
  'phq-9': phq9Aplicable,
  'ces-d': cesdAplicable,
  'gds-15': gds15Aplicable,
  'epds': epdsAplicable,
  'zung-sds': zungSdsAplicable,
  'cudos': cudosAplicable,
  // Ansiedad
  'gad-7': gad7Aplicable,
  'zung-sas': zungSasAplicable,
  'spin': spinAplicable,
  'pswq': pswqAplicable,
  // Estrés
  'pss-10': pss10Aplicable,
  // Trauma y TEPT
  'pcl-5': pcl5Aplicable,
  'ies-r': iesrAplicable,
  'dar-5': dar5Aplicable,
  // Adicciones
  'audit': auditAplicable,
  'cage': cageAplicable,
  'dast-10': dast10Aplicable,
  'crafft': crafftAplicable,
  'taps': tapsAplicable,
  'assist-v3': assistAplicable,
  // Sueño
  'isi': isiAplicable,
  'psqi': psqiAplicable,
  // Bienestar y calidad de vida
  'swls': swlsAplicable,
  'panas': panasAplicable,
  'whoqol-bref': whoqolBrefAplicable,
  'lot-r': lotrAplicable,
  'escala-florecimiento': escalaFlorecimientoAplicable,
  // Regulación emocional
  'erq': erqAplicable,
  'maas': maasAplicable,
  // Infanto-juvenil
  'sdq': sdqAplicable,
  'scared': scaredAplicable,
  'ces-dc': cesdcAplicable,
  'mfq': mfqAplicable,
  'snap-iv': snapIvAplicable,
  // Riesgo suicida
  'c-ssrs': cSsrsAplicable,
  'sbq-r': sbqRAplicable,
  // Vocacional
  'onet-ip': onetIpAplicable,
  // Autoestima
  'rses': rsesAplicable,
  // Personalidad
  'bfi-44': bfi44Aplicable,
  'ipip-neo-120': ipipNeo120Aplicable,
  // Atención y concentración
  'asrs-v1-1': asrsAplicable,
  // Neurocognitivo
  'moca': mocaAplicable,
  // Salud mental general
  'k10': k10Aplicable,
  'srq-20': srq20Aplicable,
  'dass-21': dass21Aplicable,
  // Apoyo social y soledad
  'ucla-20': ucla20Aplicable,
  'mspss': mspssAplicable,
};

/// Devuelve la aplicación del instrumento [id], o `null` si aún no está
/// disponible.
InstrumentoAplicable? aplicacionDe(String id) => aplicacionesDisponibles[id];
