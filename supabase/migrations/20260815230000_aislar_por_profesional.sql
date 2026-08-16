-- ════════════════════════════════════════════════════════════════
--  Aislamiento de datos por profesional (dueño)
--
--  Cambios:
--   1. Purgar datos de prueba existentes (no tienen dueño asignable).
--   2. Agregar `profesional_id` a `pacientes` y `sesiones` con default
--      `auth.uid()`: la base asigna el dueño automáticamente al insertar,
--      sin que la app tenga que enviarlo.
--   3. Reemplazar las políticas RLS "cualquier autenticado" por políticas
--      que filtran por el dueño real (`auth.uid() = profesional_id`).
-- ════════════════════════════════════════════════════════════════

-- 1) Purga de datos de prueba
truncate table public.sesiones, public.pacientes cascade;

-- 2) Columna de propietario
alter table public.pacientes add column profesional_id uuid not null default auth.uid();
alter table public.sesiones  add column profesional_id uuid not null default auth.uid();

create index if not exists idx_pacientes_profesional
  on public.pacientes (profesional_id);
create index if not exists idx_sesiones_profesional
  on public.sesiones (profesional_id);

-- 3) Políticas por dueño (reemplazan las de "cualquier autenticado")
drop policy if exists "acceso_pacientes_autenticado" on public.pacientes;
drop policy if exists "acceso_sesiones_autenticado" on public.sesiones;

create policy "pacientes_de_mi_consulta"
  on public.pacientes for all
  using (auth.uid() = profesional_id)
  with check (auth.uid() = profesional_id);

create policy "sesiones_de_mi_consulta"
  on public.sesiones for all
  using (auth.uid() = profesional_id)
  with check (auth.uid() = profesional_id);
