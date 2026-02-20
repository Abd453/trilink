"use client";
import LoginPage from "@/components/LoginPage";

export default function AdminLogin() {
    return (
        <LoginPage
            role="Admin"
            rolePlural="Administrators"
            dashboardPath="/admin/dashboard"
            gradient="linear-gradient(135deg, #7c3aed, #5b21b6)"
            tagline="Manage with confidence"
        />
    );
}
