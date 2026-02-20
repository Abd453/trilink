"use client";
import { useState } from "react";

export default function TeacherStudents() {
    const [selectedStudent, setSelectedStudent] = useState<number | null>(null);

    const students = [
        {
            id: 1, name: "Abebe Kebede", grade: "11-A", avg: 87, attendance: 94, rank: 5, trend: "up", subjects: [
                { name: "Mathematics", score: 92, attendance: 96 },
                { name: "Physics", score: 88, attendance: 92 },
                { name: "Chemistry", score: 78, attendance: 88 },
                { name: "English", score: 85, attendance: 96 },
                { name: "Biology", score: 91, attendance: 96 },
            ]
        },
        {
            id: 2, name: "Kalkidan Assefa", grade: "11-A", avg: 91, attendance: 97, rank: 2, trend: "up", subjects: [
                { name: "Mathematics", score: 94, attendance: 98 },
                { name: "Physics", score: 90, attendance: 96 },
                { name: "Chemistry", score: 88, attendance: 96 },
                { name: "English", score: 89, attendance: 98 },
                { name: "Biology", score: 93, attendance: 96 },
            ]
        },
        {
            id: 3, name: "Meron Girma", grade: "11-A", avg: 79, attendance: 85, rank: 12, trend: "down", subjects: [
                { name: "Mathematics", score: 82, attendance: 88 },
                { name: "Physics", score: 76, attendance: 80 },
                { name: "Chemistry", score: 72, attendance: 84 },
                { name: "English", score: 80, attendance: 88 },
                { name: "Biology", score: 84, attendance: 88 },
            ]
        },
    ];

    const selected = students.find(s => s.id === selectedStudent);

    return (
        <div className="page-wrapper">
            <div className="page-header">
                <div>
                    <h1 className="page-title">Students</h1>
                    <p className="page-subtitle">AI-powered student analytics per subject</p>
                </div>
            </div>

            <div style={{ display: "grid", gridTemplateColumns: selected ? "1fr 1.5fr" : "1fr", gap: "1.5rem" }}>
                <div className="card">
                    <div className="table-wrapper">
                        <table>
                            <thead><tr><th>Student</th><th>Avg</th><th>Attendance</th><th>Rank</th><th>Trend</th></tr></thead>
                            <tbody>
                                {students.map(s => (
                                    <tr key={s.id} onClick={() => setSelectedStudent(s.id)} style={{ cursor: "pointer", background: selectedStudent === s.id ? "var(--primary-50)" : undefined }}>
                                        <td style={{ fontWeight: 600 }}>{s.name}<br /><span style={{ fontSize: "0.7rem", color: "var(--gray-400)" }}>{s.grade}</span></td>
                                        <td><span className={`badge ${s.avg >= 90 ? "badge-success" : s.avg >= 80 ? "badge-primary" : "badge-warning"}`}>{s.avg}%</span></td>
                                        <td>{s.attendance}%</td>
                                        <td>#{s.rank}</td>
                                        <td style={{ color: s.trend === "up" ? "var(--success)" : "var(--danger)" }}>{s.trend === "up" ? "↗ Up" : "↘ Down"}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>

                {selected && (
                    <div>
                        <div className="card" style={{ marginBottom: "1rem" }}>
                            <div style={{ display: "flex", alignItems: "center", gap: "1rem", marginBottom: "1rem" }}>
                                <div className="avatar avatar-initials avatar-lg" style={{ fontSize: "1rem" }}>{selected.name.split(" ").map(n => n[0]).join("")}</div>
                                <div>
                                    <h3 style={{ fontSize: "1.125rem", fontWeight: 700 }}>{selected.name}</h3>
                                    <p style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>Grade {selected.grade} · Rank #{selected.rank}</p>
                                </div>
                            </div>

                            <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "1rem", marginBottom: "1rem" }}>
                                <div style={{ textAlign: "center", padding: "0.75rem", background: "var(--primary-50)", borderRadius: "var(--radius-md)" }}>
                                    <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--primary-600)" }}>{selected.avg}%</div>
                                    <div style={{ fontSize: "0.7rem", color: "var(--gray-500)" }}>Avg Score</div>
                                </div>
                                <div style={{ textAlign: "center", padding: "0.75rem", background: "var(--success-light)", borderRadius: "var(--radius-md)" }}>
                                    <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--success)" }}>{selected.attendance}%</div>
                                    <div style={{ fontSize: "0.7rem", color: "var(--gray-500)" }}>Attendance</div>
                                </div>
                                <div style={{ textAlign: "center", padding: "0.75rem", background: "var(--warning-light)", borderRadius: "var(--radius-md)" }}>
                                    <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--warning)" }}>#{selected.rank}</div>
                                    <div style={{ fontSize: "0.7rem", color: "var(--gray-500)" }}>Class Rank</div>
                                </div>
                            </div>

                            <h4 style={{ fontSize: "0.9rem", fontWeight: 600, marginBottom: "0.5rem" }}>📊 AI Analytics per Subject</h4>
                            <div className="table-wrapper">
                                <table>
                                    <thead><tr><th>Subject</th><th>Score</th><th>Attendance</th><th>Status</th></tr></thead>
                                    <tbody>
                                        {selected.subjects.map((sub, i) => (
                                            <tr key={i}>
                                                <td style={{ fontWeight: 500 }}>{sub.name}</td>
                                                <td><span className={`badge ${sub.score >= 90 ? "badge-success" : sub.score >= 80 ? "badge-primary" : "badge-warning"}`}>{sub.score}%</span></td>
                                                <td>{sub.attendance}%</td>
                                                <td style={{ color: sub.score >= 85 ? "var(--success)" : sub.score >= 75 ? "var(--warning)" : "var(--danger)" }}>
                                                    {sub.score >= 85 ? "✅ Good" : sub.score >= 75 ? "⚠ Needs attention" : "❌ At risk"}
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div className="card" style={{ padding: "1rem" }}>
                            <h4 style={{ fontWeight: 600, color: "var(--primary-600)", marginBottom: "0.5rem" }}>🤖 AI Recommendation</h4>
                            <p style={{ fontSize: "0.85rem", color: "var(--gray-600)" }}>
                                {selected.avg >= 85
                                    ? `${selected.name} is performing well overall. Continue providing challenging material to maintain engagement.`
                                    : `${selected.name} needs additional support in subjects with scores below 80%. Consider scheduling extra practice sessions.`}
                            </p>
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
}
