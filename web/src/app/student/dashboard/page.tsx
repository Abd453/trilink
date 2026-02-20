"use client";
import { useState } from "react";
import { useRouter } from "next/navigation";

type ExamStatus = "available" | "completed" | "upcoming" | "missed";

interface Exam {
    id: number;
    course: string;
    type: "Test" | "Quiz" | "Midterm" | "Final";
    title: string;
    date: string;
    time: string;
    duration: number; // in minutes
    totalQuestions: number;
    status: ExamStatus;
    score?: number;
    room: string;
}

export default function StudentDashboard() {
    const router = useRouter();
    const [filter, setFilter] = useState<"all" | "available" | "completed">("all");

    const exams: Exam[] = [
        { id: 1, course: "Mathematics", type: "Midterm", title: "Ch.5-8 Midterm Exam", date: "2026-02-20", time: "09:00", duration: 120, totalQuestions: 40, status: "available", room: "ICT Lab 1" },
        { id: 2, course: "Physics", type: "Quiz", title: "Ch.6 Mechanics Quiz", date: "2026-02-20", time: "14:00", duration: 30, totalQuestions: 15, status: "available", room: "ICT Lab 2" },
        { id: 3, course: "Chemistry", type: "Test", title: "Organic Chemistry Test", date: "2026-02-21", time: "10:00", duration: 60, totalQuestions: 25, status: "upcoming", room: "ICT Lab 1" },
        { id: 4, course: "English", type: "Quiz", title: "Grammar & Vocabulary Quiz", date: "2026-02-19", time: "11:00", duration: 20, totalQuestions: 10, status: "completed", score: 88, room: "ICT Lab 2" },
        { id: 5, course: "Biology", type: "Test", title: "Cell Biology Test", date: "2026-02-18", time: "09:00", duration: 45, totalQuestions: 20, status: "completed", score: 94, room: "ICT Lab 1" },
        { id: 6, course: "Mathematics", type: "Quiz", title: "Integration Quick Quiz", date: "2026-02-17", time: "10:00", duration: 15, totalQuestions: 8, status: "completed", score: 75, room: "ICT Lab 2" },
        { id: 7, course: "Physics", type: "Final", title: "Semester Final Exam", date: "2026-03-10", time: "08:00", duration: 180, totalQuestions: 60, status: "upcoming", room: "ICT Lab 1" },
    ];

    const filtered = filter === "all" ? exams : exams.filter(e => filter === "available" ? (e.status === "available") : e.status === "completed");
    const availableCount = exams.filter(e => e.status === "available").length;
    const completedCount = exams.filter(e => e.status === "completed").length;
    const avgScore = exams.filter(e => e.score).reduce((a, e) => a + (e.score || 0), 0) / (completedCount || 1);

    const typeColor: Record<string, string> = {
        Quiz: "var(--primary-500)", Test: "var(--warning)", Midterm: "var(--purple)", Final: "var(--danger)"
    };
    const typeBg: Record<string, string> = {
        Quiz: "var(--primary-50)", Test: "var(--warning-light)", Midterm: "var(--purple-light)", Final: "var(--danger-light)"
    };

    const handleStartExam = (exam: Exam) => {
        router.push(`/student/exam/${exam.id}`);
    };

    const handleViewResult = (exam: Exam) => {
        router.push(`/student/result/${exam.id}`);
    };

    return (
        <div>
            {/* Page Header */}
            <div style={{ marginBottom: "1.5rem" }}>
                <h1 style={{ fontSize: "1.5rem", fontWeight: 800, color: "var(--gray-900)" }}>📝 Exam Portal</h1>
                <p style={{ fontSize: "0.875rem", color: "var(--gray-500)", marginTop: "0.25rem" }}>Select a course exam to begin</p>
            </div>

            {/* Stats */}
            <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "1rem", marginBottom: "1.5rem" }}>
                <div style={{ background: "#fff", borderRadius: 14, padding: "1.25rem", border: "1px solid var(--gray-100)" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
                        <div style={{ width: 42, height: 42, borderRadius: 12, background: "var(--success-light)", display: "flex", alignItems: "center", justifyContent: "center", fontSize: "1.2rem" }}>🟢</div>
                        <div>
                            <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>Available Now</div>
                            <div style={{ fontSize: "1.5rem", fontWeight: 800, color: "var(--gray-900)" }}>{availableCount}</div>
                        </div>
                    </div>
                </div>
                <div style={{ background: "#fff", borderRadius: 14, padding: "1.25rem", border: "1px solid var(--gray-100)" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
                        <div style={{ width: 42, height: 42, borderRadius: 12, background: "var(--primary-50)", display: "flex", alignItems: "center", justifyContent: "center", fontSize: "1.2rem" }}>✅</div>
                        <div>
                            <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>Completed</div>
                            <div style={{ fontSize: "1.5rem", fontWeight: 800, color: "var(--gray-900)" }}>{completedCount}</div>
                        </div>
                    </div>
                </div>
                <div style={{ background: "#fff", borderRadius: 14, padding: "1.25rem", border: "1px solid var(--gray-100)" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
                        <div style={{ width: 42, height: 42, borderRadius: 12, background: "var(--purple-light)", display: "flex", alignItems: "center", justifyContent: "center", fontSize: "1.2rem" }}>📊</div>
                        <div>
                            <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>Avg. Score</div>
                            <div style={{ fontSize: "1.5rem", fontWeight: 800, color: "var(--gray-900)" }}>{Math.round(avgScore)}%</div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Filter Tabs */}
            <div style={{ display: "flex", gap: "0.5rem", marginBottom: "1.25rem" }}>
                {(["all", "available", "completed"] as const).map(f => (
                    <button key={f} onClick={() => setFilter(f)} style={{
                        padding: "0.5rem 1.25rem", borderRadius: 10, border: "1.5px solid",
                        borderColor: filter === f ? "var(--primary-500)" : "var(--gray-200)",
                        background: filter === f ? "var(--primary-500)" : "#fff",
                        color: filter === f ? "#fff" : "var(--gray-600)",
                        fontWeight: 600, fontSize: "0.85rem", cursor: "pointer",
                        transition: "all 150ms ease"
                    }}>
                        {f === "all" ? "All Exams" : f === "available" ? "🟢 Available" : "✅ Completed"}
                    </button>
                ))}
            </div>

            {/* Exam Cards */}
            <div style={{ display: "flex", flexDirection: "column", gap: "0.75rem" }}>
                {filtered.map(exam => (
                    <div key={exam.id} style={{
                        background: "#fff", borderRadius: 16, padding: "1.25rem",
                        border: `1.5px solid ${exam.status === "available" ? "var(--success)" : "var(--gray-100)"}`,
                        boxShadow: exam.status === "available" ? "0 0 0 3px rgba(16,185,129,0.08)" : "none",
                        transition: "all 200ms ease",
                    }}>
                        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: "0.75rem" }}>
                            <div style={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
                                <div style={{
                                    padding: "0.35rem 0.85rem", borderRadius: 8,
                                    background: typeBg[exam.type] || "var(--gray-100)",
                                    color: typeColor[exam.type] || "var(--gray-600)",
                                    fontWeight: 700, fontSize: "0.75rem",
                                }}>{exam.type}</div>
                                <span style={{ fontSize: "0.8rem", color: "var(--gray-400)" }}>•</span>
                                <span style={{ fontSize: "0.85rem", fontWeight: 600, color: "var(--primary-600)" }}>{exam.course}</span>
                            </div>
                            <div style={{
                                padding: "0.3rem 0.75rem", borderRadius: 8,
                                background: exam.status === "available" ? "var(--success-light)" : exam.status === "completed" ? "var(--primary-50)" : exam.status === "upcoming" ? "var(--warning-light)" : "var(--danger-light)",
                                color: exam.status === "available" ? "#065f46" : exam.status === "completed" ? "var(--primary-700)" : exam.status === "upcoming" ? "#92400e" : "#991b1b",
                                fontWeight: 600, fontSize: "0.75rem",
                            }}>
                                {exam.status === "available" ? "● Available Now" : exam.status === "completed" ? `Score: ${exam.score}%` : exam.status === "upcoming" ? "Upcoming" : "Missed"}
                            </div>
                        </div>

                        <h3 style={{ fontSize: "1.05rem", fontWeight: 700, color: "var(--gray-900)", marginBottom: "0.5rem" }}>{exam.title}</h3>

                        <div style={{ display: "flex", alignItems: "center", gap: "1.5rem", fontSize: "0.8rem", color: "var(--gray-500)", marginBottom: "1rem" }}>
                            <span>📅 {new Date(exam.date).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}</span>
                            <span>🕐 {exam.time}</span>
                            <span>⏱ {exam.duration} min</span>
                            <span>📋 {exam.totalQuestions} questions</span>
                            <span>🏫 {exam.room}</span>
                        </div>

                        <div style={{ display: "flex", gap: "0.5rem" }}>
                            {exam.status === "available" && (
                                <button onClick={() => handleStartExam(exam)} style={{
                                    padding: "0.6rem 1.5rem", borderRadius: 10,
                                    background: "linear-gradient(135deg, var(--primary-500), var(--primary-600))",
                                    color: "#fff", fontWeight: 700, fontSize: "0.85rem",
                                    border: "none", cursor: "pointer",
                                    boxShadow: "0 2px 8px rgba(37,99,235,0.25)",
                                    transition: "all 150ms ease",
                                }}>▶ Start Exam</button>
                            )}
                            {exam.status === "completed" && (
                                <button onClick={() => handleViewResult(exam)} style={{
                                    padding: "0.6rem 1.5rem", borderRadius: 10,
                                    background: "var(--primary-50)", color: "var(--primary-600)",
                                    fontWeight: 600, fontSize: "0.85rem",
                                    border: "1.5px solid var(--primary-200)", cursor: "pointer",
                                }}>📊 View Result</button>
                            )}
                            {exam.status === "upcoming" && (
                                <span style={{ padding: "0.6rem 1.5rem", borderRadius: 10, background: "var(--gray-100)", color: "var(--gray-400)", fontWeight: 600, fontSize: "0.85rem" }}>
                                    🔒 Not yet available
                                </span>
                            )}
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
