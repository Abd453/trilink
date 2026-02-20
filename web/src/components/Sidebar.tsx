"use client";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { ReactNode } from "react";

export interface NavItem {
    label: string;
    href: string;
    icon: ReactNode;
    badge?: number;
    section?: string;
}

interface SidebarProps {
    role: string;
    items: NavItem[];
    roleColor?: string;
}

export default function Sidebar({ role, items, roleColor }: SidebarProps) {
    const pathname = usePathname();
    let currentSection = "";

    return (
        <aside className="sidebar">
            <div className="sidebar-header">
                <div className="sidebar-logo">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M22 10v6M2 10l10-5 10 5-10 5z" />
                        <path d="M6 12v5c0 1.1 2.7 3 6 3s6-1.9 6-3v-5" />
                    </svg>
                </div>
                <div>
                    <div className="sidebar-brand">Tri<span>Link</span></div>
                    <div style={{ fontSize: "0.7rem", color: "var(--gray-400)", fontWeight: 500, textTransform: "uppercase", letterSpacing: "0.05em" }}>
                        {role} Portal
                    </div>
                </div>
            </div>

            <nav className="sidebar-nav">
                {items.map((item, i) => {
                    const showSection = item.section && item.section !== currentSection;
                    if (item.section) currentSection = item.section;
                    const isActive = pathname === item.href || (item.href !== `/${role.toLowerCase()}/dashboard` && pathname.startsWith(item.href));

                    return (
                        <div key={i}>
                            {showSection && (
                                <div className="sidebar-section">{item.section}</div>
                            )}
                            <Link href={item.href} className={`nav-item ${isActive ? "active" : ""}`}>
                                <span className="nav-icon">{item.icon}</span>
                                <span>{item.label}</span>
                                {item.badge && item.badge > 0 && (
                                    <span className="nav-badge">{item.badge}</span>
                                )}
                            </Link>
                        </div>
                    );
                })}
            </nav>

            <div className="sidebar-footer">
                <Link href={`/${role.toLowerCase()}/login`} className="nav-item" style={{ color: "var(--danger)" }}>
                    <span className="nav-icon">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                            <polyline points="16 17 21 12 16 7" />
                            <line x1="21" y1="12" x2="9" y2="12" />
                        </svg>
                    </span>
                    <span>Logout</span>
                </Link>
            </div>
        </aside>
    );
}
