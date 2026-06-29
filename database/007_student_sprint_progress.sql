-- ==========================================
-- Student Sprint Progress Table
-- ==========================================
create table student_sprint_progress (
    -- Primary Key
    id uuid primary key default gen_random_uuid(),
    -- Student
    student_id uuid not null references profiles(id) on delete cascade,
    -- Sprint
    sprint_id uuid not null references sprints(id) on delete cascade,
    -- Available hints for this sprint
    initial_hints integer not null default 0,
    -- Remaining hints for this sprint    
    remaining_hints integer not null default 0,
    -- Timestamps
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    -- Validation
    constraint chk_remaining_hints check (remaining_hints >= 0),
    -- One record per student per sprint
    constraint uq_student_sprint_progress unique(student_id, sprint_id)
);

-- ==========================================
-- Indexes
-- ==========================================
create index idx_student_sprint_progress_student on student_sprint_progress(student_id);

create index idx_student_sprint_progress_sprint on student_sprint_progress(sprint_id);

-- ==========================================
-- Trigger
-- ==========================================
create trigger trg_student_sprint_progress_updated_at before
update
    on student_sprint_progress for each row execute function update_updated_at_column();