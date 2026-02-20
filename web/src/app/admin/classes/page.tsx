"use client";
export default function AdminClasses() {
    const classes = [
        { name: "Grade 9-A", teacher: "Mr. Bekele", students: 40, room: "Room 101" },
        { name: "Grade 9-B", teacher: "Ms. Tigist", students: 38, room: "Room 102" },
        { name: "Grade 10-A", teacher: "Mr. Yonas", students: 42, room: "Room 201" },
        { name: "Grade 10-B", teacher: "Ms. Helen", students: 39, room: "Room 202" },
        { name: "Grade 11-A", teacher: "Mr. Solomon", students: 42, room: "Room 301" },
        { name: "Grade 11-B", teacher: "Mr. Daniel", students: 38, room: "Room 302" },
        { name: "Grade 12-A", teacher: "Ms. Sara", students: 35, room: "Room 401" },
        { name: "Grade 12-B", teacher: "Mr. Tadesse", students: 41, room: "Room 402" },
    ];
    return (
        <div className="page-wrapper">
            <div className="page-header"><div><h1 className="page-title">Class Management</h1><p className="page-subtitle">Create classes and assign teachers</p></div><button className="btn btn-primary">+ Create Class</button></div>
            <div className="card"><div className="table-wrapper"><table><thead><tr><th>Class</th><th>Homeroom Teacher</th><th>Students</th><th>Room</th><th>Actions</th></tr></thead><tbody>
                {classes.map((c, i) => (<tr key={i}><td style={{ fontWeight: 600 }}>{c.name}</td><td>{c.teacher}</td><td>{c.students}</td><td>{c.room}</td><td><div style={{ display: "flex", gap: "0.375rem" }}><button className="btn btn-outline btn-sm">Edit</button><button className="btn btn-secondary btn-sm">Assign Teacher</button></div></td></tr>))}
            </tbody></table></div></div>
        </div>
    );
}
