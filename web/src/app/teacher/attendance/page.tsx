"use client";
import { useState } from "react";

export default function TeacherAttendance() {
    const [selectedClass, setSelectedClass] = useState("Grade 11-A");
    const classes = ["Grade 11-A", "Grade 11-B", "Grade 12-A", "Grade 12-B"];

    const students = [
        { name: "Abebe Kebede", id: "STU-042", status: "present" },
        { name: "Kalkidan Assefa", id: "STU-015", status: "present" },
        { name: "Yohannes Belay", id: "STU-028", status: "present" },
        { name: "Meron Girma", id: "STU-033", status: "absent" },
        { name: "Samuel Dereje", id: "STU-019", status: "present" },
        { name: "Hana Tadesse", id: "STU-051", status: "late" },
        { name: "Dawit Mulugeta", id: "STU-007", status: "present" },
        { name: "Fatima Hassan", id: "STU-044", status: "present" },
    ];

    const [attendance, setAttendance] = useState<Record<string, string>>(
        Object.fromEntries(students.map(s => [s.id, s.status]))
    );

    const toggleStatus = (id: string) => {
        const order = ["present", "absent", "late"];
        const current = attendance[id];
        const next = order[(order.indexOf(current) + 1) % order.length];
        setAttendance({ ...attendance, [id]: next });
    };

    return (
        <div className="page-wrapper">
            <div className="page-header">
                <div>
                    <h1 className="page-title">Attendance</h1>
                    <p className="page-subtitle">Mark and manage class attendance</p>
                </div>
                <button className="btn btn-primary">Save Attendance</button>
            </div>

            <div style={{ display: "flex", gap: "0.5rem", marginBottom: "1.5rem" }}>
                {classes.map(c => (
                    <button key={c} className={`btn ${selectedClass === c ? "btn-primary" : "btn-secondary"}`} onClick={() => setSelectedClass(c)}>{c}</button>
                ))}
            </div>

            <div className="card">
                <div className="card-header">
                    <h3 className="card-title">{selectedClass} — February 19, 2026</h3>
                    <div style={{ display: "flex", gap: "1rem", fontSize: "0.8rem" }}>
                        <span style={{ color: "var(--success)" }}>● Present: {Object.values(attendance).filter(v => v === "present").length}</span>
                        <span style={{ color: "var(--danger)" }}>● Absent: {Object.values(attendance).filter(v => v === "absent").length}</span>
                        <span style={{ color: "var(--warning)" }}>● Late: {Object.values(attendance).filter(v => v === "late").length}</span>
                    </div>
                </div>
                <div className="table-wrapper">
                    <table>
                        <thead><tr><th>#</th><th>Student</th><th>ID</th><th>Status</th><th>Action</th></tr></thead>
                        <tbody>
                            {students.map((s, i) => (
                                <tr key={s.id}>
                                    <td>{i + 1}</td>
                                    <td style={{ fontWeight: 600 }}>{s.name}</td>
                                    <td style={{ color: "var(--gray-500)" }}>{s.id}</td>
                                    <td>
                                        <span className={`badge ${attendance[s.id] === "present" ? "badge-success" : attendance[s.id] === "absent" ? "badge-danger" : "badge-warning"}`}>
                                            {attendance[s.id].charAt(0).toUpperCase() + attendance[s.id].slice(1)}
                                        </span>
                                    </td>
                                    <td>
                                        <button className="btn btn-secondary btn-sm" onClick={() => toggleStatus(s.id)}>Toggle</button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
