-- ==========================================
-- Sprints Table
-- ==========================================
create table sprints (
    -- Primary Key
    id uuid primary key default gen_random_uuid(),
    -- Sprint title
    title text not null,
    -- Optional description
    description text,
    -- Sprint start date
    starts_at timestamptz not null,
    -- Submission deadline
    deadline timestamptz not null,
    -- Sprint status
    status sprint_status not null default 'active',
    -- Admin who created the sprint
    created_by uuid not null references profiles(id) on delete restrict,
    -- Timestamps
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    -- Validation
    constraint chk_sprint_dates check (deadline > starts_at)
);

-- ==========================================
-- Indexes
-- ==========================================
create index idx_sprints_status on sprints(status);

create index idx_sprints_deadline on sprints(deadline);

-- ==========================================
-- Trigger
-- ==========================================
create trigger trg_sprints_updated_at before
update
    on sprints for each row execute function update_updated_at_column();