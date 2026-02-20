"use client";
import LoginPage from "@/components/LoginPage";

export default function ParentLogin() {
    return (
        <LoginPage
            role="Parent"
            rolePlural="Parents"
            dashboardPath="/parent/dashboard"
            gradient="linear-gradient(135deg, #d97706, #b45309)"
            tagline="Stay connected with your child"
        />
    );
}
