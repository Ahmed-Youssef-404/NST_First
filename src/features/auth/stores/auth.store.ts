import { create } from "zustand";
import type { User } from "@supabase/supabase-js";
import type { Profile } from "../types/profile.types";

export interface AuthStoreState {
    authUser: User | null;
    profile: Profile | null;

    isAuthenticated: boolean;
    isLoading: boolean;
    isInitialized: boolean;
}

export interface AuthStoreActions {
    setAuthState: (state: Partial<AuthStoreState>) => void;

    setAuthUser: (user: User | null) => void;

    setProfile: (profile: Profile | null) => void;

    setLoading: (loading: boolean) => void;

    setInitialized: (initialized: boolean) => void;

    reset: () => void;
}

export type AuthStore = AuthStoreState & AuthStoreActions;

const initialState: AuthStoreState = {
    authUser: null,
    profile: null,

    isAuthenticated: false,

    isLoading: true,

    isInitialized: false,
};

export const useAuthStore = create<AuthStore>((set) => ({
    ...initialState,

    setAuthState: (state) =>
        set((currentState) => ({
            ...currentState,
            ...state,
        })),

    setAuthUser: (authUser) =>
        set({
            authUser,
        }),

    setProfile: (profile) =>
        set({
            profile,
        }),

    setLoading: (isLoading) =>
        set({
            isLoading,
        }),

    setInitialized: (isInitialized) =>
        set({
            isInitialized,
        }),

    reset: () =>
        set({
            ...initialState,
            isLoading: false,
            isInitialized: true,
        }),
}));