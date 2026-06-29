-- ==========================================
-- Submissions Table
-- ==========================================
create table submissions (
    -- Primary Key
    id uuid primary key default gen_random_uuid(),
    -- Related task
    task_id uuid not null references student_tasks(id) on delete cascade,
    -- Submission type
    submission_type submission_type not null,
    -- Programming language used
    language text,
    -- Submitted content (code, SQL, text, etc.)
    submission_text text,
    -- File or external link
    submission_url text,
    -- Optional notes from the student
    notes text,
    -- Admin feedback
    feedback text,
    -- Rating (1 - 10)
    rating smallint,
    -- Submission timestamp
    submitted_at timestamptz not null default now(),
    -- Review timestamp
    reviewed_at timestamptz,
    -- Timestamps
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    -- One submission per task
    constraint uq_submission_task unique (task_id),
    -- Rating validation
    constraint chk_rating check (
        rating is null
        or rating between 1
        and 10
    )
);

-- ==========================================
-- Indexes
-- ==========================================
create index idx_submissions_task on submissions(task_id);

create index idx_submissions_submitted_at on submissions(submitted_at);

-- ==========================================
-- Trigger
-- ==========================================
create trigger trg_submissions_updated_at before
update
    on submissions for each row execute function update_updated_at_column();