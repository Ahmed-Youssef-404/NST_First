-- ==========================================
-- Enable required extensions
-- ==========================================

create extension if not exists "pgcrypto";
create extension if not exists "citext";

-- ==========================================
-- Function: update_updated_at_column
-- ==========================================

create or replace function update_updated_at_column()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;