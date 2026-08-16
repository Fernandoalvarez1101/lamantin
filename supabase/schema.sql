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
  fecha_registro timestamptz not null default now(),
  -- Dueño: la base lo asigna al insertar con auth.uid()
  profesional_id uuid not null default auth.uid()
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
  subescalas jsonb not null default '[]',
  -- Dueño: la base lo asigna al insertar con auth.uid()
  profesional_id uuid not null default auth.uid()
);

create index if not exists idx_sesiones_paciente
  on public.sesiones (id_paciente);

create index if not exists idx_sesiones_instrumento
  on public.sesiones (id_instrumento);

create index if not exists idx_pacientes_profesional
  on public.pacientes (profesional_id);
create index if not exists idx_sesiones_profesional
  on public.sesiones (profesional_id);

-- ── Seguridad (RLS) ──────────────────────────────────────────────
-- Cada profesional solo ve/edita/borra sus propios registros:
-- auth.uid() debe coincidir con profesional_id.
alter table public.pacientes enable row level security;
alter table public.sesiones enable row level security;

create policy "pacientes_de_mi_consulta"
  on public.pacientes for all
  using (auth.uid() = profesional_id)
  with check (auth.uid() = profesional_id);

create policy "sesiones_de_mi_consulta"
  on public.sesiones for all
  using (auth.uid() = profesional_id)
  with check (auth.uid() = profesional_id);

-- ─────────────────────────────────────────────────────────────────
--  OPCIÓN TEMPORAL (solo para probar sin login):
--  Comenta las líneas de arriba (enable rls + policies) y ejecuta:
--    alter table public.pacientes disable row level security;
--    alter table public.sesiones  disable row level security;
--  ⚠️ Con RLS desactivado, cualquiera con la clave anon puede leer y
--     escribir. No usar con datos reales de pacientes.
-- ─────────────────────────────────────────────────────────────────
