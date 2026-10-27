-- Execute no Supabase: SQL Editor > New query > Run
create table if not exists public.jogadores (
  id bigint generated always as identity primary key,
  nome text not null,
  numero int,
  posicao text not null default 'Ala',
  foto_url text,
  ativo boolean not null default true,
  criado_em timestamptz default now()
);

create table if not exists public.contato (
  id int primary key check (id = 1),
  email text, telefone text, whatsapp text, instagram text,
  endereco text, treinos text
);
insert into public.contato (id, treinos) values (1, 'Terças e quintas, 20h') on conflict do nothing;

alter table public.jogadores enable row level security;
alter table public.contato enable row level security;

-- Qualquer pessoa lê (área externa)
create policy "leitura publica jogadores" on public.jogadores for select using (true);
create policy "leitura publica contato" on public.contato for select using (true);

-- Só usuários autenticados (admin) escrevem
create policy "admin escreve jogadores" on public.jogadores for all to authenticated using (true) with check (true);
create policy "admin escreve contato" on public.contato for all to authenticated using (true) with check (true);
