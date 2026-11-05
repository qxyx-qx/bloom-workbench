-- 我的工作台云同步数据表
-- 在 Supabase 控制台 SQL Editor 中运行本脚本

create table if not exists public.workbench_data (
  workspace_id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.workbench_data enable row level security;

-- 允许匿名客户端按 workspace_id 读写数据。
-- 个人访问码会在前端转换为哈希 workspace_id，不会明文写入数据库。
-- 请不要在此工作台存放身份证号、银行卡号等高敏感信息。
drop policy if exists workbench_select on public.workbench_data;
create policy workbench_select on public.workbench_data
for select to anon
using (true);

drop policy if exists workbench_insert on public.workbench_data;
create policy workbench_insert on public.workbench_data
for insert to anon
with check (true);

drop policy if exists workbench_update on public.workbench_data;
create policy workbench_update on public.workbench_data
for update to anon
using (true)
with check (true);

-- 开启 Realtime：在 Supabase 控制台 Database > Replication 中确认 workbench_data 表已加入实时发布。
