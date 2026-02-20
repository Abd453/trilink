"use client";
export default function TeacherDashboard() {
    const stats = [
        { label: "Total Students", value: "156", icon: "👨‍🎓", color: "blue", change: "+8 new", positive: true },
        { label: "Classes Today", value: "4", icon: "📚", color: "green", change: "2 remaining", positive: true },
        { label: "Avg. Attendance", value: "91%", icon: "✅", color: "purple", change: "+1.5%", positive: true },
        { label: "Pending Grades", value: "12", icon: "📝", color: "orange", change: "3 urgent", positive: false },
    ];

    const classes = [
        { name: "Grade 11-A Mathematics", students: 42, time: "8:00 - 8:45", status: "completed" },
        { name: "Grade 11-B Mathematics", students: 38, time: "9:00 - 9:45", status: "completed" },
        { name: "Grade 12-A Calculus", students: 35, time: "10:00 - 10:45", status: "ongoing" },
        { name: "Grade 12-B Calculus", students: 41, time: "11:00 - 11:45", status: "upcoming" },
    ];

    const recentActivity = [
        { action: "Graded Quiz - Grade 11-A", time: "30 min ago", type: "grade" },
        { action: "Marked attendance - Grade 12-A", time: "1 hour ago", type: "attendance" },
        { action: "Created new quiz for Chapter 7", time: "2 hours ago", type: "exam" },
        { action: "Received feedback from admin", time: "3 hours ago", type: "notification" },
    ];

    return (
        <div className="page-wrapper">
            <div className="page-header">
                <div>
                    <h1 className="page-title">Good morning, Mr. Solomon! ☀️</h1>
                    <p className="page-subtitle">Here&apos;s your teaching overview for today.</p>
                </div>
            </div>

            <div className="stats-grid">
                {stats.map((stat) => (
                    <div className="stat-card" key={stat.label}>
                        <div className={`stat-icon ${stat.color}`}><span style={{ fontSize: "1.25rem" }}>{stat.icon}</span></div>
                        <div className="stat-info">
                            <div className="stat-label">{stat.label}</div>
                            <div className="stat-value">{stat.value}</div>
                            <div className={`stat-change ${stat.positive ? "positive" : "negative"}`}>{stat.positive ? "↑" : "⚠"} {stat.change}</div>
                        </div>
                    </div>
                ))}
            </div>

            <div className="content-grid">
                <div className="card">
                    <div className="card-header">
                        <h3 className="card-title">Today&apos;s Classes</h3>
                    </div>
                    <div style={{ display: "flex", flexDirection: "column", gap: "0.5rem" }}>
                        {classes.map((c, i) => (
                            <div key={i} style={{
                                display: "flex", alignItems: "center", justifyContent: "space-between",
                                padding: "0.875rem", background: "var(--gray-50)", borderRadius: "var(--radius-md)",
                                borderLeft: `3px solid ${c.status === "completed" ? "var(--success)" : c.status === "ongoing" ? "var(--primary-500)" : "var(--gray-300)"}`,
                            }}>
                                <div>
                                    <div style={{ fontWeight: 600, fontSize: "0.875rem" }}>{c.name}</div>
                                    <div style={{ fontSize: "0.75rem", color: "var(--gray-500)" }}>{c.students} students · {c.time}</div>
                                </div>
                                <span className={`badge ${c.status === "completed" ? "badge-success" : c.status === "ongoing" ? "badge-primary" : "badge-warning"}`}>
                                    {c.status.charAt(0).toUpperCase() + c.status.slice(1)}
                                </span>
                            </div>
                        ))}
                    </div>
                </div>

                <div className="card">
                    <div className="card-header">
                        <h3 className="card-title">Recent Activity</h3>
                    </div>
                    <div style={{ display: "flex", flexDirection: "column", gap: "0.75rem" }}>
                        {recentActivity.map((a, i) => (
                            <div key={i} style={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
                                <div style={{
                                    width: 36, height: 36, borderRadius: "var(--radius-full)",
                                    background: a.type === "grade" ? "var(--primary-100)" : a.type === "attendance" ? "var(--success-light)" : a.type === "exam" ? "var(--purple-light)" : "var(--warning-light)",
                                    display: "flex", alignItems: "center", justifyContent: "center", fontSize: "0.875rem", flexShrink: 0,
                                }}>
                                    {a.type === "grade" ? "📊" : a.type === "attendance" ? "✅" : a.type === "exam" ? "📝" : "🔔"}
                                </div>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: "0.875rem", fontWeight: 500 }}>{a.action}</div>
                                    <div style={{ fontSize: "0.7rem", color: "var(--gray-400)" }}>{a.time}</div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}
