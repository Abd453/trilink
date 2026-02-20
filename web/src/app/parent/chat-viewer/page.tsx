"use client";
export default function ParentChatViewer() {
    const conversations = [
        {
            teacher: "Mr. Solomon", subject: "Mathematics", messages: [
                { from: "Mr. Solomon", text: "Abebe, please complete the practice problems tonight.", time: "9:00 AM" },
                { from: "Abebe", text: "Yes sir, I'll have them done.", time: "9:05 AM" },
                { from: "Mr. Solomon", text: "Great! Let me know if you need help.", time: "9:06 AM" },
            ]
        },
        {
            teacher: "Ms. Sara", subject: "Physics", messages: [
                { from: "Ms. Sara", text: "Your lab report needs some corrections.", time: "11:00 AM" },
                { from: "Abebe", text: "I'll fix them and resubmit.", time: "11:10 AM" },
            ]
        },
    ];

    return (
        <div className="page-wrapper">
            <div className="page-header">
                <div>
                    <h1 className="page-title">Chat Viewer</h1>
                    <p className="page-subtitle">View conversations between Abebe and his teachers</p>
                </div>
            </div>

            <div style={{ display: "flex", alignItems: "center", gap: "0.5rem", padding: "0.75rem 1rem", background: "var(--info-light)", borderRadius: "var(--radius-md)", marginBottom: "1.5rem" }}>
                <span>👁️</span>
                <span style={{ fontSize: "0.85rem", color: "#0e7490" }}>View-only mode: You can see student-teacher conversations but cannot send messages here.</span>
            </div>

            <div style={{ display: "flex", flexDirection: "column", gap: "1rem" }}>
                {conversations.map((conv, i) => (
                    <div key={i} className="card">
                        <div className="card-header">
                            <h3 className="card-title">{conv.teacher} — {conv.subject}</h3>
                            <span className="badge badge-primary">{conv.messages.length} messages</span>
                        </div>
                        <div style={{ display: "flex", flexDirection: "column", gap: "0.75rem" }}>
                            {conv.messages.map((msg, j) => (
                                <div key={j} style={{ display: "flex", justifyContent: msg.from === "Abebe" ? "flex-end" : "flex-start" }}>
                                    <div style={{
                                        maxWidth: "70%", padding: "0.625rem 1rem",
                                        borderRadius: msg.from === "Abebe" ? "var(--radius-lg) var(--radius-lg) 4px var(--radius-lg)" : "var(--radius-lg) var(--radius-lg) var(--radius-lg) 4px",
                                        background: msg.from === "Abebe" ? "var(--primary-100)" : "var(--gray-100)",
                                    }}>
                                        <div style={{ fontSize: "0.7rem", fontWeight: 600, color: "var(--gray-500)", marginBottom: "0.125rem" }}>{msg.from} · {msg.time}</div>
                                        <div style={{ fontSize: "0.875rem" }}>{msg.text}</div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
