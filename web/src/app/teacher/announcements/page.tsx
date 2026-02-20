"use client";
export default function TeacherAnnouncements() {
    return (
        <div className="page-wrapper">
            <div className="page-header">
                <div><h1 className="page-title">Announcements</h1><p className="page-subtitle">Create and manage announcements for your classes</p></div>
                <button className="btn btn-primary">+ New Announcement</button>
            </div>
            <div className="card" style={{ marginBottom: "1rem" }}>
                <h3 className="card-title" style={{ marginBottom: "1rem" }}>Create Announcement</h3>
                <div className="input-group" style={{ marginBottom: "1rem" }}><label>Title</label><div className="input-field"><input placeholder="Announcement title..." /></div></div>
                <div className="input-group" style={{ marginBottom: "1rem" }}>
                    <label>Target</label>
                    <select style={{ padding: "0.75rem 1rem", background: "var(--gray-50)", border: "1.5px solid var(--gray-200)", borderRadius: "var(--radius-md)", fontSize: "0.9rem", fontFamily: "inherit" }}>
                        <option>All My Classes</option><option>Grade 11-A</option><option>Grade 11-B</option><option>Grade 12-A</option>
                    </select>
                </div>
                <div className="input-group" style={{ marginBottom: "1rem" }}><label>Message</label>
                    <textarea placeholder="Write your announcement..." rows={4} style={{ padding: "0.75rem 1rem", background: "var(--gray-50)", border: "1.5px solid var(--gray-200)", borderRadius: "var(--radius-md)", fontSize: "0.9rem", fontFamily: "inherit", resize: "vertical" }} />
                </div>
                <div style={{ display: "flex", gap: "0.75rem" }}><button className="btn btn-primary">Publish Now</button><button className="btn btn-outline">Schedule</button></div>
            </div>
            <div className="card">
                <h3 className="card-title" style={{ marginBottom: "1rem" }}>Previous Announcements</h3>
                {[
                    { title: "Math Quiz Tomorrow", target: "Grade 11-A", date: "Feb 18", status: "sent" },
                    { title: "Homework Deadline Extended", target: "All Classes", date: "Feb 16", status: "sent" },
                    { title: "Exam Preparation Tips", target: "Grade 12-A", date: "Feb 14", status: "scheduled" },
                ].map((a, i) => (
                    <div key={i} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "0.75rem", background: "var(--gray-50)", borderRadius: "var(--radius-md)", marginBottom: "0.5rem" }}>
                        <div><div style={{ fontWeight: 600, fontSize: "0.875rem" }}>{a.title}</div><div style={{ fontSize: "0.75rem", color: "var(--gray-500)" }}>To: {a.target} · {a.date}</div></div>
                        <span className={`badge ${a.status === "sent" ? "badge-success" : "badge-warning"}`}>{a.status}</span>
                    </div>
                ))}
            </div>
        </div>
    );
}
