-- ==========================================
-- Task Hints Table
-- ==========================================
create table task_hints (
    -- Primary Key
    id uuid primary key default gen_random_uuid(),
    -- Related task
    task_id uuid not null references student_tasks(id) on delete cascade,
    -- Hint order
    display_order integer not null,
    -- Hint content
    content text not null,
    -- Has the student revealed this hint?
    is_revealed boolean not null default false,
    -- Timestamps
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    -- Validation
    constraint chk_hint_display_order check (display_order > 0),
    -- Prevent duplicate hint order
    constraint uq_task_hint_order unique(task_id, display_order)
);

-- ==========================================
-- Indexes
-- ==========================================
create index idx_task_hints_task on task_hints(task_id);

-- ==========================================
-- Trigger
-- ==========================================
create trigger trg_task_hints_updated_at before
update
    on task_hints for each row execute function update_updated_at_column();