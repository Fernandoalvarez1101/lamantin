-- Verificación de aislamiento por profesional (Lamantin)
select '1_columna' as check, table_name, column_name, data_type
from information_schema.columns
where table_schema = 'public'
  and table_name in ('pacientes', 'sesiones')
  and column_name = 'profesional_id'
order by table_name;

select '2_politicas' as check, tablename, policyname, cmd, qual, with_check
from pg_policies
where schemaname = 'public' and tablename in ('pacientes', 'sesiones')
order by tablename, policyname;

select '3_purga' as check, 'pacientes' as tabla, count(*) as total from public.pacientes
union all
select '3_purga', 'sesiones', count(*) from public.sesiones;

select '4_privilegios' as check, table_name, grantee, privilege_type
from information_schema.role_table_grants
where table_schema = 'public'
  and table_name in ('pacientes', 'sesiones')
  and grantee in ('anon', 'authenticated')
order by table_name, grantee, privilege_type;

select '5_aislamiento' as check, 'insert como usuario A' as paso;

set role authenticated;
set request.jwt.claim.sub = '11111111-1111-1111-1111-111111111111';
insert into public.pacientes (id, nombre, apellido, notas)
values ('a-test-1', 'Ana', 'Pérez', 'datos de la cuenta A');
select '5_aislamiento' as check, 'usuario A inserto, profesional_id asignado:' as paso, id, profesional_id
from public.pacientes where id = 'a-test-1';

set request.jwt.claim.sub = '22222222-2222-2222-2222-222222222222';
select '5_aislamiento' as check, 'usuario B ve pacientes del A:' as paso, count(*) as total
from public.pacientes;

set request.jwt.claim.sub = '11111111-1111-1111-1111-111111111111';
delete from public.pacientes where id = 'a-test-1';
reset role;
select '5_aislamiento' as check, 'limpieza hecha' as paso;

