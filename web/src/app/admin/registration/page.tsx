"use client";
import { useState } from "react";
export default function AdminRegistration() {
    const [regType, setRegType] = useState<"student" | "teacher" | "parent">("student");
    return (
        <div className="page-wrapper">
            <div className="page-header"><div><h1 className="page-title">Registration</h1><p className="page-subtitle">Register students, teachers, and parents</p></div></div>
            <div style={{ display: "flex", gap: "0.5rem", marginBottom: "1.5rem" }}>
                {(["student", "teacher", "parent"] as const).map(t => (<button key={t} className={`btn ${regType === t ? "btn-primary" : "btn-secondary"}`} onClick={() => setRegType(t)}>{t === "student" ? "🎓" : t === "teacher" ? "📚" : "👨‍👩‍👧"} {t.charAt(0).toUpperCase() + t.slice(1)}</button>))}
            </div>
            <div className="card">
                <h3 className="card-title" style={{ marginBottom: "1.25rem" }}>Register New {regType.charAt(0).toUpperCase() + regType.slice(1)}</h3>
                <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "1rem", marginBottom: "1.25rem" }}>
                    <div className="input-group"><label>First Name</label><div className="input-field"><input placeholder="First name" /></div></div>
                    <div className="input-group"><label>Last Name</label><div className="input-field"><input placeholder="Last name" /></div></div>
                    <div className="input-group"><label>Email</label><div className="input-field"><input placeholder="email@school.edu" /></div></div>
                    <div className="input-group"><label>Phone</label><div className="input-field"><input placeholder="+251 ..." /></div></div>
                    {regType === "student" && <><div className="input-group"><label>Grade</label><select style={{ padding: "0.75rem", background: "var(--gray-50)", border: "1.5px solid var(--gray-200)", borderRadius: "var(--radius-md)", fontFamily: "inherit" }}><option>Grade 9</option><option>Grade 10</option><option>Grade 11</option><option>Grade 12</option></select></div><div className="input-group"><label>Section</label><select style={{ padding: "0.75rem", background: "var(--gray-50)", border: "1.5px solid var(--gray-200)", borderRadius: "var(--radius-md)", fontFamily: "inherit" }}><option>A</option><option>B</option><option>C</option></select></div></>}
                    {regType === "teacher" && <><div className="input-group"><label>Subject</label><div className="input-field"><input placeholder="Mathematics" /></div></div><div className="input-group"><label>Department</label><div className="input-field"><input placeholder="Science" /></div></div></>}
                    {regType === "parent" && <><div className="input-group"><label>Child&apos;s Name</label><div className="input-field"><input placeholder="Student full name" /></div></div><div className="input-group"><label>Relationship</label><select style={{ padding: "0.75rem", background: "var(--gray-50)", border: "1.5px solid var(--gray-200)", borderRadius: "var(--radius-md)", fontFamily: "inherit" }}><option>Father</option><option>Mother</option><option>Guardian</option></select></div></>}
                </div>
                <button className="btn btn-primary">Register {regType.charAt(0).toUpperCase() + regType.slice(1)}</button>
            </div>
        </div>
    );
}
