"use client";
export default function ParentDashboard() {
    return (
        <div className="page-wrapper">
            <div className="page-header"><div><h1 className="page-title">Welcome, Mr. Kebede! 👋</h1><p className="page-subtitle">Monitor your child&apos;s academic progress</p></div></div>
            <div className="stats-grid">
                {[{ label: "Child's Avg Score", value: "87%", icon: "📊", color: "blue" }, { label: "Attendance Rate", value: "94%", icon: "✅", color: "green" }, { label: "Class Rank", value: "#5", icon: "🏆", color: "purple" }, { label: "Upcoming Exams", value: "2", icon: "📝", color: "orange" }].map(s => (
                    <div className="stat-card" key={s.label}><div className={`stat-icon ${s.color}`}><span style={{ fontSize: "1.25rem" }}>{s.icon}</span></div><div className="stat-info"><div className="stat-label">{s.label}</div><div className="stat-value">{s.value}</div></div></div>
                ))}
            </div>
            <div className="content-grid">
                <div className="card"><div className="card-header"><h3 className="card-title">📊 Recent Grades</h3></div>
                    {[{ subj: "Mathematics", score: 92, grade: "A" }, { subj: "Physics", score: 88, grade: "A-" }, { subj: "Chemistry", score: 78, grade: "B+" }, { subj: "English", score: 85, grade: "A-" }].map((g, i) => (
                        <div key={i} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "0.625rem 0", borderBottom: "1px solid var(--gray-50)" }}>
                            <span style={{ fontWeight: 500 }}>{g.subj}</span>
                            <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                                <span className={`badge ${g.score >= 90 ? "badge-success" : g.score >= 80 ? "badge-primary" : "badge-warning"}`}>{g.grade}</span>
                                <span style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>{g.score}%</span>
                            </div>
                        </div>
                    ))}
                </div>
                <div className="card"><div className="card-header"><h3 className="card-title">📅 Upcoming Events</h3></div>
                    {[{ title: "Math Midterm", date: "Feb 25", type: "exam" }, { title: "Physics Quiz", date: "Feb 22", type: "exam" }, { title: "Parent-Teacher Conference", date: "Feb 28", type: "event" }].map((e, i) => (
                        <div key={i} style={{ display: "flex", alignItems: "center", gap: "0.75rem", padding: "0.75rem", background: "var(--gray-50)", borderRadius: "var(--radius-md)", marginBottom: "0.5rem", borderLeft: `3px solid ${e.type === "exam" ? "var(--danger)" : "var(--primary-500)"}` }}>
                            <div><div style={{ fontWeight: 600, fontSize: "0.875rem" }}>{e.title}</div><div style={{ fontSize: "0.75rem", color: "var(--gray-500)" }}>{e.date}</div></div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
}
