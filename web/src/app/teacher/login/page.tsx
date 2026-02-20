"use client";
import LoginPage from "@/components/LoginPage";

export default function TeacherLogin() {
    return (
        <LoginPage
            role="Teacher"
            rolePlural="Teachers"
            dashboardPath="/teacher/dashboard"
            gradient="linear-gradient(135deg, #059669, #047857)"
            tagline="Empower your classroom"
        />
    );
}
