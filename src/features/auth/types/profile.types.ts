export type UserRole = "student" | "admin";

export interface Profile {
    id: string;

    email: string;

    full_name: string;

    username: string | null;

    avatar_url: string | null;

    role: UserRole;

    created_at: string;

    updated_at: string;
}