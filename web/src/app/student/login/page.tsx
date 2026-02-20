"use client";
import LoginPage from "@/components/LoginPage";

export default function StudentLogin() {
    return (
        <LoginPage
            role="Student"
            rolePlural="Students"
            dashboardPath="/student/dashboard"
            tagline="Access your exams securely"
        />
    );
}
