// auth.api.ts

import type {
    Subscription,
    Session,
    User,
} from "@supabase/supabase-js";

import { supabase } from "@/lib/supabase";

import type {
    AuthStateChangeCallback,
    ResetPasswordPayload,
    SignInCredentials,
    SignUpCredentials,
    UpdatePasswordPayload,
} from "../types/auth.types";

export const authApi = {
    async getSession(): Promise<Session | null> {
        const { data, error } = await supabase.auth.getSession();

        if (error) throw error;

        return data.session;
    },

    async getCurrentUser(): Promise<User | null> {
        const { data, error } = await supabase.auth.getUser();

        if (error) throw error;

        return data.user;
    },

    async signUp(credentials: SignUpCredentials) {
        const { data, error } = await supabase.auth.signUp(credentials);

        if (error) throw error;

        return data;
    },

    async signIn(credentials: SignInCredentials) {
        const { data, error } =
            await supabase.auth.signInWithPassword(credentials);

        if (error) throw error;

        return data;
    },

    async signOut() {
        const { error } = await supabase.auth.signOut();

        if (error) throw error;
    },

    async resetPassword({
        email,
    }: ResetPasswordPayload) {
        const { error } =
            await supabase.auth.resetPasswordForEmail(email);

        if (error) throw error;
    },

    async updatePassword({
        password,
    }: UpdatePasswordPayload) {
        const { data, error } =
            await supabase.auth.updateUser({
                password,
            });

        if (error) throw error;

        return data;
    },

    onAuthStateChange(
        callback: AuthStateChangeCallback
    ): Subscription {
        const {
            data: { subscription },
        } = supabase.auth.onAuthStateChange(callback);

        return subscription;
    },
};