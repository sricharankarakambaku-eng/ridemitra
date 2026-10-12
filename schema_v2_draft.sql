-- DRAFT ONLY for a future backend version. Not used by V1.
-- Review and apply RLS policies before connecting any public client.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  phone text,
  role text not null default 'passenger'
    check (role in ('passenger', 'driver', 'admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.rides (
  id uuid primary key default gen_random_uuid(),
  passenger_id uuid not null references public.profiles(id),
  driver_id uuid references public.profiles(id),
  pickup_text text not null,
  destination_text text not null,
  fare_estimate_paise integer check (fare_estimate_paise >= 0),
  status text not null default 'requested'
    check (status in ('requested', 'accepted', 'arriving', 'in_progress', 'completed', 'cancelled')),
  created_at timestamptz not null default now()
);

-- IMPORTANT:
-- Do not deploy these tables to production without explicit RLS policies,
-- role verification, driver approval checks, and server-side authorization.
-- Never let a client assign itself the admin role.
