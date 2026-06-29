// auth.types.ts

import type {
    AuthChangeEvent,
    Session,
    User,
} from "@supabase/supabase-js";

import type { Profile } from "./profile.types";

export interface AuthState {
    authUser: User | null;
    profile: Profile | null;

    isAuthenticated: boolean;

    isLoading: boolean;

    isInitialized: boolean;
}

export interface SignInCredentials {
    email: string;
    password: string;
}

export interface SignUpCredentials {
    email: string;
    password: string;
}

export interface ResetPasswordPayload {
    email: string;
}

export interface UpdatePasswordPayload {
    password: string;
}

export type AuthStateChangeCallback = (
    event: AuthChangeEvent,
    session: Session | null
) => void;