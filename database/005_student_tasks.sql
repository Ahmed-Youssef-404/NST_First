-- ==========================================
-- Student Tasks Table
-- ==========================================
create table student_tasks (
    -- Primary Key
    id uuid primary key default gen_random_uuid(),
    -- Student
    student_id uuid not null references profiles(id) on delete cascade,
    -- Sprint
    sprint_id uuid not null references sprints(id) on delete cascade,
    -- Task order in the UI
    display_order integer not null default 1,
    -- Task title
    title text not null,
    -- Task description
    description text not null,
    -- Required language
    -- NULL = Any language is allowed
    language text,
    -- Current task status
    status task_status not null default 'not_started',
    -- Admin who created the task
    created_by_id uuid not null references profiles(id) on delete restrict,
    -- Timestamps
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    -- Validation
    constraint chk_display_order check (display_order > 0),
    constraint uq_student_task_order
    unique (student_id, sprint_id, display_order)
);

-- ==========================================
-- Indexes
-- ==========================================
create index idx_student_tasks_student on student_tasks(student_id);

create index idx_student_tasks_sprint on student_tasks(sprint_id);

create index idx_student_tasks_status on student_tasks(status);

create index idx_student_tasks_display_order on student_tasks(student_id, sprint_id, display_order);

-- ==========================================
-- Trigger
-- ==========================================
create trigger trg_student_tasks_updated_at before
update
    on student_tasks for each row execute function update_updated_at_column();