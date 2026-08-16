# Lamantin 🦭

Aplicación para psicólogos profesionales que permite aplicar **instrumentos de
medición psicológica de uso público** (tests y cuestionarios de dominio público
o de libre uso clínico).

## Estado del proyecto

Fase inicial. Actualmente incluye:

- Temas claro y oscuro con la paleta de marca (púrpura/violeta).
- **Dashboard principal** con navegación hacia los módulos de la aplicación.
- **Módulo Instrumentos**: catálogo de **47 instrumentos de uso público**
  clasificados en 17 categorías (Depresión, Ansiedad, Estrés, Trauma y TEPT,
  Vocacional, Autoestima, Sueño, Adicciones, Personalidad, Bienestar, Atención,
  Salud mental general, Riesgo suicida, Infanto-juvenil, Apoyo social y soledad,
  Regulación emocional y Neurocognitivo), con ficha completa de cada
  instrumento.
- **Aplicación de instrumentos**: flujo completo de aplicación para
  **45 instrumentos** de las categorías **Depresión** (PHQ-9, CES-D, GDS-15,
  EPDS, Zung SDS, CUDOS), **Ansiedad** (GAD-7, Zung SAS, SPIN, PSWQ),
  **Estrés** (PSS-10), **Trauma y TEPT** (PCL-5, IES-R, DAR-5),
  **Adicciones** (AUDIT, CAGE, DAST-10, CRAFFT, TAPS, ASSIST), **Sueño**
  (ISI, PSQI), **Bienestar y calidad de vida** (SWLS, PANAS, WHOQOL-BREF,
  LOT-R, FS), **Regulación emocional** (ERQ, MAAS), **Infanto-juvenil**
  (SDQ, SCARED, CES-DC, MFQ, SNAP-IV), **Riesgo suicida** (C-SSRS, SBQ-R),
  **Vocacional** (O*NET IP), **Autoestima** (RSES), **Personalidad**
  (BFI-44), **Atención** (ASRS), **Salud mental general** (K10, SRQ-20,
  DASS-21) y **Apoyo social** (UCLA-20, MSPSS). El flujo incluye:
  instrucciones, preguntas una a una con barra de progreso, puntuación
  (ítems invertidos, pesos por opción, componentes, subescalas y totales
  personalizados), bandas de severidad, alertas clínicas y nota de
  «cribado, no diagnóstico». Los instrumentos con puntos de corte
  publicados muestran bandas categóricas con su fuente; los que carecen de
  normas publicadas (BFI-44, RSES, UCLA-20, MAAS, FS, PANAS, ERQ, MSPSS,
  O*NET IP, dominios del WHOQOL-BREF y subescalas del SCARED) se muestran
  en **modo descriptivo**: puntuación bruta, rango de escala y media por
  ítem, **sin etiqueta categórica**.

  *El **MoCA** está disponible como **hoja de puntuación** administrada por
  el profesional (no reproduce el material oficial), y el **IPIP-NEO-120**
  incluye los 120 ítems originales del IPIP en inglés (dominio público), con
  30 facetas y 5 dominios en modo descriptivo.*

## Arquitectura (roadmap)

```
lib/
├── main.dart                      # Punto de entrada (LamantinApp)
├── theme.dart                     # Paleta de marca (LamantinColors) y temas
├── models/
│   ├── categoria_instrumento.dart # Categorías de clasificación
│   └── instrumento.dart           # Modelo de instrumento
├── data/
│   └── catalogo_instrumentos.dart # Catálogo de instrumentos de uso público
├── screens/
│   ├── dashboard_screen.dart      # Dashboard con módulos de navegación
│   ├── instrumentos/
│   │   ├── lista_instrumentos_screen.dart        # Clasificación por categorías
│   │   └── instrumentos_por_categoria_screen.dart # Lista por categoría + ficha
│   └── placeholders/
│       └── en_construccion_screen.dart  # Plantilla para secciones futuras
└── widgets/                       # (futuro) Componentes reutilizables
```

## Módulos planificados

- **Instrumentos** *(en curso)*: catálogo de tests de uso público (PHQ-9,
  GAD-7, PSS-10, AUDIT, PCL-5, O*NET IP, etc.) y aplicación de instrumentos.
- **Pacientes**: fichas y gestión de pacientes.
- **Sesiones**: historial de aplicaciones realizadas.
- **Resultados**: puntuaciones e interpretaciones clínicas.

## Desarrollo

```bash
flutter pub get
flutter run
flutter test
```

