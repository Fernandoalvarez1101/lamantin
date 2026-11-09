# CLAUDE.md

Contexto operativo del repositorio. El `README.md` explica **qué** es Lamantin;
este archivo explica **cómo trabajar acá sin romper producción**.

## Qué es

App **Flutter web** para psicólogos: catálogo y aplicación de instrumentos de
medición psicológica de uso público. Backend en Supabase (proyecto
`hfvxxngrtayjqbgfsmif`) y publicación como sitio estático en GitHub Pages →
`https://fernandoalvarez1101.github.io/lamantin/`.

## Comandos

```bash
flutter pub get
flutter analyze                          # el CI falla si esto falla
flutter test                             # el CI falla si esto falla
flutter run -d chrome --web-port=8080    # puerto fijo: conserva la sesión al recargar
flutter build web --release --base-href=/lamantin/
```

`.github/workflows/deploy.yml` corre `flutter analyze` y `flutter test` **antes**
de compilar, en cada push a `main`. Si el análisis o los tests fallan, no hay
despliegue: ese es el único gate de calidad, no hay revisión manual.

El `--base-href` debe coincidir con el **nombre del repositorio**: GitHub Pages
sirve el proyecto en `/<repo>/` y sin eso la app queda en blanco.

## ⚠️ Trampas del entorno

### 1. NUNCA ejecutar `supabase config push`

`supabase/config.toml` es una **plantilla de desarrollo generada por el CLI**;
no refleja producción. Comparación real:

| Campo                       | `config.toml` (local)          | Producción (real)                                  |
| --------------------------- | ------------------------------ | -------------------------------------------------- |
| `site_url`                  | `http://127.0.0.1:3000`        | `https://fernandoalvarez1101.github.io/lamantin/`  |
| `additional_redirect_urls`  | `["https://127.0.0.1:3000"]`   | ver sección «Auth» más abajo                        |
| `enable_confirmations`      | `false`                        | **`true`** (en producción `mailer_autoconfirm = false`) |

Un `config push` sobrescribiría producción con esos valores: **apagaría la
confirmación por email** y mandaría los enlaces de los correos a
`127.0.0.1:3000`. Para cambios puntuales usar la Management API (el CLI v2.114.0
no ofrece `pull`, `diff` ni dry-run):

```
GET   / PATCH  https://api.supabase.com/v1/projects/hfvxxngrtayjqbgfsmif/config/auth
```

El `PATCH` es **parcial**: sólo modifica los campos que se envían. Campos útiles:
`site_url` y `uri_allow_list` (lista separada por comas). El token para la API
está en el Administrador de credenciales de Windows, destino
`Supabase CLI:supabase`, porque el CLI ya está autenticado en esta máquina —
**no imprimirlo, no loguearlo, no commitearlo**.

### 2. Git: `http.sslBackend`

El `gitconfig` de sistema fuerza `http.sslBackend=openssl` con un bundle de CA de
`ucrt64` roto, y los `push` fallan por SSL. El repositorio lo sobreescribe a
nivel local (ya aplicado en `.git/config`, no en la config global):

```bash
git config --local http.sslBackend schannel
```

No revertirlo sin motivo. Si hiciera falta: `git config --local --unset http.sslBackend`.

## Auth de Supabase — estado verificado (2026-10-10)

- `site_url` = `https://fernandoalvarez1101.github.io/lamantin/`
- `uri_allow_list` = `https://fernandoalvarez1101.github.io/lamantin/**,http://localhost:8080/**,http://localhost:8081/**`
- `mailer_autoconfirm` = `false` → la confirmación por email **sí** está activa.
- Sin tocar: `disable_signup=false`, `external_email_enabled=true`,
  `security_captcha_enabled=false`, `password_min_length=6`. GoTrue v2.195.0.

### Incidente resuelto (2026-10-10)

Producción nunca tuvo configurada esta sección: `site_url` seguía en el valor por
defecto `http://localhost:3000` y `uri_allow_list` estaba **vacío**. Como la Site
URL es el *fallback* de todos los enlaces de correo, cada enlace de confirmación
de cuenta, recuperación de contraseña y magic link caía en un localhost muerto.

Se corrigió con un `PATCH` parcial por Management API (se verificó con un `GET`
posterior que ningún otro campo cambió). **No hubo que tocar código**: el deploy
ya estaba bien, faltaba sólo esta configuración. Confirmado de punta a punta: el
correo de recuperación ahora llega y el enlace apunta a la URL de Pages.

> **Consecuencia que sigue abierta:** cualquier cuenta creada antes de esa fecha
> puede haber quedado **sin confirmar**, y esos usuarios no pueden iniciar sesión
> (`mailer_autoconfirm = false`). Revisar *Authentication → Users* y reenviar la
> confirmación; ahora el enlace sí funciona.

## Flujo de recuperación de contraseña

Usa **PKCE**: el verificador se guarda en `localStorage`, así que el enlace del
correo debe abrirse en el **mismo navegador** donde se pidió el cambio. Si se
abre en otro, el login muestra el aviso correspondiente.
`lib/services/limpiar_url_web.dart` limpia la barra de direcciones tras el
callback (de ahí la dependencia `web` en `pubspec.yaml`).

## Notas de higiene

- El servidor de desarrollo suele quedar levantado en `localhost:8081`; mientras
  corra mantiene abiertos `flutter_run_log.txt` y `flutter_run_err.txt` (sin
  trackear, no se pueden borrar hasta que se detenga).
- `git push` a `main` redespliega el sitio. Los cambios sólo de documentación
  también disparan un rebuild, inofensivo pero real.
