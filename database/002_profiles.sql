-- ==========================================
-- User Role Enum
-- ==========================================

create type user_role as enum (
    'admin',
    'student'
);

-- ==========================================
-- Profiles Table
-- ==========================================

create table profiles (

    -- Same ID as auth.users.id
    id uuid
        primary key
        references auth.users(id)
        on delete cascade,

    -- Login username (ex: NST001)
    login_id citext not null unique,

    -- Full name
    full_name text not null,

    -- Admin or Student
    user_role user_role not null,

    -- Optional info
    phone text,

    academic_year text,

    avatar_url text,

    -- Soft delete / disable account
    is_active boolean not null default true,

    -- Timestamps
    created_at timestamptz not null default now(),

    updated_at timestamptz not null default now()
);

-- ==========================================
-- Indexes
-- ==========================================

create index idx_profiles_user_role
on profiles(user_role);

-- ==========================================
-- Trigger
-- ==========================================

create trigger trg_profiles_updated_at
before update on profiles
for each row
execute function update_updated_at_column();