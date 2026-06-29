// auth.service.ts

import { authApi } from "@/features/auth/services/auth-api";
import { profileApi } from "@/features/auth/services/profile-api";


export const authService = {
    ...authApi,

    ...profileApi,
};