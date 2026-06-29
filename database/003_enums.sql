-- ==========================================
-- Sprint Status
-- ==========================================
create type sprint_status as enum (
    'draft',
    'active',
    'completed',
    'archived'
);

-- ==========================================
-- Submission Type
-- ==========================================
create type submission_type as enum ('code', 'file', 'link');

-- ==========================================
-- Task Status
-- ==========================================
create type task_status as enum (
    'not_started',
    'submitted',
    'skipped'
);