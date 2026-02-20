"use client";
import Link from "next/link";
import { useState, useEffect } from "react";

export default function Home() {
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  const roles = [
    {
      title: "Student",
      desc: "Access exams and view grades",
      icon: "🎓",
      href: "/student/login",
      color: "linear-gradient(135deg, #3b82f6, #1d4ed8)",
      shadow: "rgba(59,130,246,0.35)",
    },
    {
      title: "Teacher",
      desc: "Manage classes and assessments",
      icon: "📚",
      href: "/teacher/login",
      color: "linear-gradient(135deg, #10b981, #059669)",
      shadow: "rgba(16,185,129,0.35)",
    },
    {
      title: "Admin",
      desc: "School-wide management",
      icon: "🏫",
      href: "/admin/login",
      color: "linear-gradient(135deg, #8b5cf6, #6d28d9)",
      shadow: "rgba(139,92,246,0.35)",
    },
    {
      title: "Parent",
      desc: "Monitor your child's progress",
      icon: "👨‍👩‍👧",
      href: "/parent/login",
      color: "linear-gradient(135deg, #f59e0b, #d97706)",
      shadow: "rgba(245,158,11,0.35)",
    },
  ];

  return (
    <div style={{
      minHeight: "100vh",
      background: "linear-gradient(135deg, #f0f7ff 0%, #e8f0fe 30%, #f8fafc 100%)",
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "2rem",
    }}>
      <div style={{
        opacity: mounted ? 1 : 0,
        transform: mounted ? "translateY(0)" : "translateY(20px)",
        transition: "all 0.6s ease",
        textAlign: "center",
        marginBottom: "3rem",
      }}>
        <div style={{
          width: 80,
          height: 80,
          background: "linear-gradient(135deg, #3b82f6, #1d4ed8)",
          borderRadius: 20,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          margin: "0 auto 1.5rem",
          boxShadow: "0 8px 30px rgba(37,99,235,0.3)",
        }}>
          <svg width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M22 10v6M2 10l10-5 10 5-10 5z" />
            <path d="M6 12v5c0 1.1 2.7 3 6 3s6-1.9 6-3v-5" />
          </svg>
        </div>
        <h1 style={{
          fontSize: "2.5rem",
          fontWeight: 800,
          color: "#0f172a",
          letterSpacing: "-0.03em",
          marginBottom: "0.5rem",
        }}>
          Welcome to <span style={{ color: "#2563eb" }}>TriLink</span>
        </h1>
        <p style={{ fontSize: "1.1rem", color: "#64748b", maxWidth: 440, margin: "0 auto" }}>
          Learn smarter, grow faster. Choose your portal to get started.
        </p>
      </div>

      <div style={{
        display: "grid",
        gridTemplateColumns: "repeat(auto-fit, minmax(240px, 1fr))",
        gap: "1.25rem",
        maxWidth: 1020,
        width: "100%",
      }}>
        {roles.map((role, i) => (
          <Link key={role.title} href={role.href} style={{ textDecoration: "none" }}>
            <div style={{
              background: "#fff",
              borderRadius: 20,
              padding: "2rem 1.5rem",
              textAlign: "center",
              boxShadow: "0 1px 3px rgba(0,0,0,0.08)",
              border: "1px solid #f1f5f9",
              transition: "all 0.3s ease",
              cursor: "pointer",
              opacity: mounted ? 1 : 0,
              transform: mounted ? "translateY(0)" : "translateY(30px)",
              transitionDelay: `${i * 100}ms`,
            }}
              onMouseEnter={(e) => {
                (e.currentTarget as HTMLDivElement).style.transform = "translateY(-6px)";
                (e.currentTarget as HTMLDivElement).style.boxShadow = `0 20px 40px ${role.shadow}`;
              }}
              onMouseLeave={(e) => {
                (e.currentTarget as HTMLDivElement).style.transform = "translateY(0)";
                (e.currentTarget as HTMLDivElement).style.boxShadow = "0 1px 3px rgba(0,0,0,0.08)";
              }}>
              <div style={{
                width: 64,
                height: 64,
                background: role.color,
                borderRadius: 16,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: "1.75rem",
                margin: "0 auto 1rem",
                boxShadow: `0 4px 14px ${role.shadow}`,
              }}>
                {role.icon}
              </div>
              <h3 style={{ fontSize: "1.25rem", fontWeight: 700, color: "#0f172a", marginBottom: "0.375rem" }}>
                {role.title}
              </h3>
              <p style={{ fontSize: "0.875rem", color: "#94a3b8" }}>{role.desc}</p>
            </div>
          </Link>
        ))}
      </div>

      <p style={{ marginTop: "3rem", fontSize: "0.8rem", color: "#94a3b8" }}>
        © 2026 TriLink Education Platform. All rights reserved.
      </p>
    </div>
  );
}
