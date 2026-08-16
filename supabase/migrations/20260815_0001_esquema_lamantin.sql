-- ════════════════════════════════════════════════════════════════
--  Esquema de Lamantin para Supabase (Postgres)
-- ════════════════════════════════════════════════════════════════
--  Cómo ejecutarlo:
--    Opción A) Dashboard de Supabase → SQL Editor → pegar y Run.
--    Opción B) CLI:  supabase db push   (con el proyecto vinculado)
--
--  Las columnas usan snake_case (convención Postgres); la app mapea
--  a los modelos Dart (camelCase).

-- ── Tabla: pacientes ─────────────────────────────────────────────
create table if not exists public.pacientes (
  id text primary key,
  nombre text not null,
  apellido text not null,
  fecha_nacimiento date,
  sexo text,
  notas text,
  fecha_registro timestamptz not null default now()
);

-- ── Tabla: sesiones ──────────────────────────────────────────────
create table if not exists public.sesiones (
  id text primary key,
  id_paciente text not null
      references public.pacientes(id) on delete cascade,
  id_instrumento text not null,
  sigla_instrumento text not null,
  nombre_instrumento text not null,
  fecha_aplicacion timestamptz not null,
  respuestas jsonb not null default '[]',
  resultado_total integer not null,
  resultado_etiqueta text,
  resultado_descripcion text,
  alertas jsonb not null default '[]',
  subescalas jsonb not null default '[]'
);

create index if not exists idx_sesiones_paciente
  on public.sesiones (id_paciente);

create index if not exists idx_sesiones_instrumento
  on public.sesiones (id_instrumento);

-- ── Seguridad (RLS) ──────────────────────────────────────────────
-- Recomendado: activar RLS y exigir autenticación. Requiere la pantalla
-- de login (próximo paso). Hasta entonces, descomentando la sección
-- «SIN RLS» la app funciona con la clave anon.
alter table public.pacientes enable row level security;
alter table public.sesiones enable row level security;

create policy "acceso_pacientes_autenticado"
  on public.pacientes for all
  using (auth.uid() is not null)
  with check (auth.uid() is not null);

create policy "acceso_sesiones_autenticado"
  on public.sesiones for all
  using (auth.uid() is not null)
  with check (auth.uid() is not null);

-- ─────────────────────────────────────────────────────────────────
--  OPCIÓN TEMPORAL (solo para probar sin login):
--  Comenta las líneas de arriba (enable rls + policies) y ejecuta:
--    alter table public.pacientes disable row level security;
--    alter table public.sesiones  disable row level security;
--  ⚠️ Con RLS desactivado, cualquiera con la clave anon puede leer y
--     escribir. No usar con datos reales de pacientes.
-- ─────────────────────────────────────────────────────────────────
