# Lamantin 🦭

Aplicación para psicólogos profesionales que permite aplicar **instrumentos de
medición psicológica de uso público** (tests y cuestionarios de dominio público
o de libre uso clínico).

## Estado del proyecto

Fase inicial. Actualmente incluye:

- Temas claro y oscuro con la paleta de marca (púrpura/violeta).
- **Dashboard principal** con navegación hacia los módulos de la aplicación.
- **Módulo Instrumentos**: catálogo de **53 instrumentos de uso público**
  clasificados en 18 categorías (Depresión, Ansiedad, Estrés, Trauma y TEPT,
  Vocacional, Autoestima, Creencias y esquemas cognitivos, Sueño, Adicciones,
  Personalidad, Bienestar, Atención, Salud mental general, Riesgo suicida,
  Infanto-juvenil, Apoyo social y soledad, Regulación emocional y
  Neurocognitivo), con ficha completa de cada instrumento.
- **Aplicación de instrumentos**: flujo completo de aplicación para
  **53 instrumentos** de las categorías **Depresión** (PHQ-9, CES-D, GDS-15,
  EPDS, Zung SDS, CUDOS), **Ansiedad** (GAD-7, Zung SAS, SPIN, PSWQ, BAI,
  IUS-12), **Estrés** (PSS-10), **Trauma y TEPT** (PCL-5, IES-R, DAR-5),
  **Adicciones** (AUDIT, CAGE, DAST-10, CRAFFT, TAPS, ASSIST), **Sueño**
  (ISI, PSQI), **Bienestar y calidad de vida** (SWLS, PANAS, WHOQOL-BREF,
  LOT-R, FS), **Regulación emocional** (ERQ, MAAS), **Infanto-juvenil**
  (SDQ, SCARED, CES-DC, MFQ, SNAP-IV), **Riesgo suicida** (C-SSRS, SBQ-R),
  **Vocacional** (O*NET IP), **Autoestima** (RSES), **Creencias y esquemas
  cognitivos** (Rotter I-E, GBJWS), **Personalidad** (BFI-44, IPIP-NEO-120,
  MMPI-2, MMPI-2 · respuestas), **Atención** (ASRS), **Salud mental general**
  (K10, SRQ-20, DASS-21) y **Apoyo social** (UCLA-20, MSPSS). El flujo incluye:
  instrucciones, preguntas una a una con barra de progreso, puntuación
  (ítems invertidos, pesos por opción, componentes, subescalas y totales
  personalizados), bandas de severidad, alertas clínicas y nota de
  «cribado, no diagnóstico». Los instrumentos con puntos de corte
  publicados muestran bandas categóricas con su fuente; los que carecen de
  normas publicadas (BFI-44, RSES, UCLA-20, MAAS, FS, PANAS, ERQ, MSPSS,
  IUS-12, Rotter I-E, GBJWS, O*NET IP, dominios del WHOQOL-BREF y subescalas
  del SCARED) se muestran en **modo descriptivo**: puntuación bruta, rango de
  escala y media por ítem, **sin etiqueta categórica**.

  *El **MoCA** y el **MMPI-2** están disponibles como **hoja de puntuación**
  administrada por el profesional (no reproducen el material oficial). Del
  MMPI-2 se ofrecen dos piezas complementarias: la **hoja de respuestas**, con
  los 567 ítems numerados Verdadero/Falso —el evaluado lee cada reactivo en el
  cuadernillo licenciado y la app entrega al final la plantilla completa de
  respuestas, ítem por ítem, para calificar con la clave del editor—; y la
  **hoja de puntuación**, donde se registra el corte T ≥ 65 de las 62 escalas
  del perfil (8 de validez, 10 clínicas básicas, 9 RC, 5 PSY-5, 15 de contenido
  y 15 suplementarias), con alertas cuando se elevan F, Fb, Fp, Fs, VRIN o
  TRIN. El **IPIP-NEO-120** incluye los 120 ítems originales del IPIP en
  inglés (dominio público), con 30 facetas y 5 dominios en modo descriptivo.*

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

## Próximos pasos

1. **MMPI-2-RF (338 ítems) y MMPI-A (478 ítems)**: replicar el par de piezas ya
   disponible para el MMPI-2 (hoja de respuestas numerada + hoja de puntuación
   por escala), con las escalas propias de cada versión.
2. **Subescalas del MMPI-2**: Harris-Lingoes (D1-D5, Hy1-Hy5, Pd1-Pd5, Pa1-Pa3,
   Sc1-Sc6, Ma1-Ma4, Si1-Si4), subescalas de contenido y subescalas de Si, como
   subescalas opcionales de la hoja de puntuación.
3. **Comentario por escala**: campo de texto libre en cada escala elevada para
   registrar la interpretación del profesional, útil en prácticas y en el
   informe de la sesión.
4. **Control de omisiones**: al terminar la hoja de respuestas de 567 ítems,
   listar los ítems sin responder antes de generar la plantilla, porque el
   MMPI-2 penaliza las omisiones en las escalas de validez.
5. **Exportación**: descargar la plantilla de respuestas en CSV o PDF y el
   perfil de escalas en PDF, además del botón «Copiar plantilla» actual.
6. **Revisión clínica de la lista de escalas**: contrastar siglas y nombres en
   español de las 62 escalas con el manual antes de usarla en docencia.

## Importar reactivos propios (MMPI-2)

La hoja de respuestas del MMPI-2 no incluye los 567 reactivos (material
propietario de Pearson / University of Minnesota Press). Si el profesional
cuenta con licencia, puede ver el texto en su **copia local** sin publicarlo:

1. Copiar `mmpi2_reactivos_plantilla.csv` como `mmpi2_reactivos.csv` (este
   último está en `.gitignore` y no se sube al repositorio).
2. Rellenar la columna `texto` con el contenido de cada reactivo de su
   cuadernillo.
3. En la app, al abrir **MMPI-2 · respuestas**, pulsar **Importar reactivos
   (CSV)** y pegar el contenido del archivo. El texto se muestra en cada ítem
   sólo en esa sesión y en ese navegador: no se sube ni se guarda en Supabase.

## Desarrollo

```bash
flutter pub get
flutter run
flutter test
```

## Despliegue (GitHub Pages)

La base de datos y la autenticación viven en Supabase (proyecto
`hfvxxngrtayjqbgfsmif`). La app web se publica como sitio estático en
GitHub Pages mediante el workflow de `.github/workflows/deploy.yml`.

Pasos (la primera vez):

1. Crear el repositorio **`lamantin`** en GitHub (público → Pages gratuito).
   Si el repositorio se llama distinto, ajustar el `--base-href` del workflow
   (la URL de Pages será `https://<usuario>.github.io/<repositorio>/`).
2. Vincular y subir:

   ```bash
   git remote add origin https://github.com/<usuario>/lamantin.git
   git push -u origin main
   ```

3. Activar Pages: **Settings → Pages → Source: *GitHub Actions***. El workflow
   compila (`flutter build web --release --base-href=/lamantin/`) y publica
   `build/web` automáticamente en cada push a `main`.
4. En Supabase: **Authentication → URL Configuration** (ya configurado en el
   proyecto `hfvxxngrtayjqbgfsmif`):

   - **Site URL** = `https://fernandoalvarez1101.github.io/lamantin/`
   - **Redirect URLs** = `https://fernandoalvarez1101.github.io/lamantin/**`,
     `http://localhost:8080/**` y `http://localhost:8081/**`.

   > ⚠️ Cuidado con la **Site URL**: es el *fallback* de todos los enlaces de
   > correo. Si el `redirect_to` no está en la allowlist, Supabase **no da
   > error**: lo ignora y usa la Site URL. Con el valor por defecto de un
   > proyecto nuevo (`http://localhost:3000`) los enlaces de confirmación de
   > cuenta y de recuperación de contraseña llegan a un sitio muerto, así que
   > conviene revisarla al crear el proyecto. Se puede consultar y corregir sin
   > abrir el dashboard con `GET`/`PATCH` a
   > `https://api.supabase.com/v1/projects/<ref>/config/auth`, que acepta los
   > campos `site_url` y `uri_allow_list` (lista separada por comas) y **solo**
   > modifica esos campos.
5. Abrir la URL publicada, registrarse, confirmar el correo y probar el flujo
   completo (paciente → instrumento → sesión → informe).

Notas:

- El proyecto está pensado para ejecutarse en **web**; para recargar la app en
  desarrollo y conservar la sesión, usar puerto fijo:
  `flutter run -d chrome --web-port=8080`.
- Los datos de los pacientes están aislados por profesional (RLS por
  `profesional_id` en Supabase) y la sesión persiste en el navegador
  (`localStorage`).
- La recuperación de contraseña usa el flujo PKCE, así que el enlace del correo
  debe abrirse en el **mismo navegador** donde se pidió el cambio (el verificador
  se guarda en `localStorage`). Si se abre en otro, el login muestra el aviso
  correspondiente.


