"use client";
import { useState, useEffect, useCallback, useRef } from "react";
import { useRouter } from "next/navigation";

/* ─── Types ─── */
type QuestionType = "mcq" | "truefalse" | "fillin";

interface Question {
    id: number;
    type: QuestionType;
    text: string;
    options?: string[];
    order: number;
}

interface ExamData {
    id: number;
    course: string;
    type: string;
    title: string;
    duration: number; // minutes
    minimumTime: number; // minutes — must stay at least this long (half of duration)
    totalQuestions: number;
    questions: Question[];
}

/* ─── Mock Exam Data ─── */
function getMockExam(): ExamData {
    const questions: Question[] = [
        { id: 1, order: 1, type: "mcq", text: "What is the derivative of f(x) = 3x² + 2x - 5?", options: ["6x + 2", "3x + 2", "6x² + 2", "6x - 5"] },
        { id: 2, order: 2, type: "mcq", text: "Which of the following is NOT a property of limits?", options: ["Sum rule", "Product rule", "Division by zero rule", "Quotient rule"] },
        { id: 3, order: 3, type: "truefalse", text: "The integral of 1/x is ln|x| + C." },
        { id: 4, order: 4, type: "fillin", text: "The derivative of sin(x) is ______." },
        { id: 5, order: 5, type: "mcq", text: "What is the value of lim(x→0) sin(x)/x?", options: ["0", "1", "∞", "Does not exist"] },
        { id: 6, order: 6, type: "truefalse", text: "A continuous function on a closed interval always attains its maximum and minimum values." },
        { id: 7, order: 7, type: "mcq", text: "The chain rule states that d/dx[f(g(x))] equals:", options: ["f'(g(x)) · g'(x)", "f'(x) · g'(x)", "f(g'(x))", "f'(g(x))"] },
        { id: 8, order: 8, type: "fillin", text: "The formula for integration by parts is ∫u dv = uv - ∫______." },
        { id: 9, order: 9, type: "mcq", text: "Which test is used to determine if an infinite series converges?", options: ["Ratio test", "Mean test", "Mode test", "Range test"] },
        { id: 10, order: 10, type: "truefalse", text: "The second derivative test can determine concavity of a function." },
    ];

    return {
        id: 1,
        course: "Mathematics",
        type: "Midterm",
        title: "Ch.5-8 Midterm Exam",
        duration: 120,
        minimumTime: 60,
        totalQuestions: questions.length,
        questions,
    };
}

/* ─── COMPONENT ─── */
export default function ExamSession({ params }: { params: Promise<{ examId: string }> }) {
    const router = useRouter();
    const exam = getMockExam();

    // State
    const [currentQ, setCurrentQ] = useState(0);
    const [answers, setAnswers] = useState<Record<number, string>>({});
    const [flagged, setFlagged] = useState<Set<number>>(new Set());
    const [timeLeft, setTimeLeft] = useState(exam.duration * 60); // seconds
    const [timeSpent, setTimeSpent] = useState(0); // seconds
    const [showConfirm, setShowConfirm] = useState(false);
    const [showEarlyWarning, setShowEarlyWarning] = useState(false);
    const [showTabWarning, setShowTabWarning] = useState(false);
    const [tabViolations, setTabViolations] = useState(0);
    const [submitted, setSubmitted] = useState(false);
    const [showReport, setShowReport] = useState(false);
    const tabViolationsRef = useRef(0);

    const question = exam.questions[currentQ];
    const answeredCount = Object.keys(answers).length;
    const minimumTimeSeconds = exam.minimumTime * 60;

    // ─── Timer ───
    useEffect(() => {
        if (submitted) return;
        const interval = setInterval(() => {
            setTimeLeft(prev => {
                if (prev <= 1) {
                    clearInterval(interval);
                    handleAutoSubmit();
                    return 0;
                }
                return prev - 1;
            });
            setTimeSpent(prev => prev + 1);
        }, 1000);
        return () => clearInterval(interval);
    }, [submitted]);

    // ─── Tab Lock (Anti-Cheat) ───
    useEffect(() => {
        if (submitted) return;

        const handleVisibilityChange = () => {
            if (document.hidden) {
                tabViolationsRef.current += 1;
                setTabViolations(tabViolationsRef.current);
                setShowTabWarning(true);
            }
        };

        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            e.preventDefault();
            e.returnValue = "You are in an active exam session. Leaving will be recorded.";
        };

        // Disable right-click
        const handleContextMenu = (e: MouseEvent) => { e.preventDefault(); };

        // Disable copy/paste keyboard shortcuts
        const handleKeyDown = (e: KeyboardEvent) => {
            if ((e.ctrlKey || e.metaKey) && ["c", "v", "a", "x"].includes(e.key.toLowerCase())) {
                e.preventDefault();
            }
            // Disable F12, Ctrl+Shift+I (DevTools)
            if (e.key === "F12" || ((e.ctrlKey || e.metaKey) && e.shiftKey && e.key.toLowerCase() === "i")) {
                e.preventDefault();
            }
        };

        document.addEventListener("visibilitychange", handleVisibilityChange);
        window.addEventListener("beforeunload", handleBeforeUnload);
        document.addEventListener("contextmenu", handleContextMenu);
        document.addEventListener("keydown", handleKeyDown);

        return () => {
            document.removeEventListener("visibilitychange", handleVisibilityChange);
            window.removeEventListener("beforeunload", handleBeforeUnload);
            document.removeEventListener("contextmenu", handleContextMenu);
            document.removeEventListener("keydown", handleKeyDown);
        };
    }, [submitted]);

    // ─── Handlers ───
    const setAnswer = (qId: number, value: string) => {
        setAnswers(prev => ({ ...prev, [qId]: value }));
    };

    const toggleFlag = (qId: number) => {
        setFlagged(prev => {
            const next = new Set(prev);
            if (next.has(qId)) next.delete(qId);
            else next.add(qId);
            return next;
        });
    };

    const handleAutoSubmit = () => {
        setSubmitted(true);
    };

    const handleSubmitClick = () => {
        // Check minimum time
        if (timeSpent < minimumTimeSeconds) {
            setShowEarlyWarning(true);
            return;
        }
        setShowConfirm(true);
    };

    const confirmSubmit = () => {
        // Check if finished too fast (less than 20% of given time for all questions answered)
        if (timeSpent < (exam.duration * 60 * 0.2) && answeredCount === exam.totalQuestions) {
            setShowConfirm(false);
            setShowReport(true);
            return;
        }
        setSubmitted(true);
        setShowConfirm(false);
    };

    const forceSubmitAfterReport = () => {
        setSubmitted(true);
        setShowReport(false);
    };

    const formatTime = (s: number) => {
        const m = Math.floor(s / 60);
        const sec = s % 60;
        return `${m.toString().padStart(2, "0")}:${sec.toString().padStart(2, "0")}`;
    };

    const timePercent = (timeLeft / (exam.duration * 60)) * 100;
    const isLowTime = timeLeft < 300; // less than 5 min

    /* ─── SUBMITTED STATE ─── */
    if (submitted) {
        const correctAnswers: Record<number, string> = {
            1: "6x + 2", 2: "Division by zero rule", 3: "True", 4: "cos(x)",
            5: "1", 6: "True", 7: "f'(g(x)) · g'(x)", 8: "v du", 9: "Ratio test", 10: "True",
        };
        const score = exam.questions.reduce((acc, q) => {
            const userAnswer = answers[q.id]?.trim().toLowerCase() || "";
            const correct = correctAnswers[q.id]?.toLowerCase() || "";
            return acc + (userAnswer === correct ? 1 : 0);
        }, 0);
        const pct = Math.round((score / exam.totalQuestions) * 100);

        return (
            <div style={{ minHeight: "100vh", background: "var(--gray-50)", display: "flex", alignItems: "center", justifyContent: "center" }}>
                <div style={{ background: "#fff", borderRadius: 24, padding: "3rem", maxWidth: 480, width: "100%", textAlign: "center", boxShadow: "0 20px 60px rgba(0,0,0,0.08)" }}>
                    <div style={{ width: 80, height: 80, borderRadius: "50%", background: pct >= 50 ? "var(--success-light)" : "var(--danger-light)", display: "flex", alignItems: "center", justifyContent: "center", margin: "0 auto 1.5rem", fontSize: "2rem" }}>
                        {pct >= 50 ? "✅" : "⚠️"}
                    </div>
                    <h1 style={{ fontSize: "1.5rem", fontWeight: 800, marginBottom: "0.5rem" }}>Exam Submitted!</h1>
                    <p style={{ color: "var(--gray-500)", marginBottom: "2rem" }}>{exam.title}</p>

                    <div style={{ display: "flex", justifyContent: "center", gap: "2rem", marginBottom: "2rem" }}>
                        <div>
                            <div style={{ fontSize: "2.5rem", fontWeight: 900, color: pct >= 90 ? "var(--success)" : pct >= 70 ? "var(--primary-500)" : pct >= 50 ? "var(--warning)" : "var(--danger)" }}>{pct}%</div>
                            <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>Score</div>
                        </div>
                        <div>
                            <div style={{ fontSize: "2.5rem", fontWeight: 900, color: "var(--gray-900)" }}>{score}/{exam.totalQuestions}</div>
                            <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>Correct</div>
                        </div>
                    </div>

                    <div style={{ display: "flex", justifyContent: "center", gap: "1rem", marginBottom: "1.5rem", fontSize: "0.85rem" }}>
                        <div style={{ padding: "0.5rem 1rem", background: "var(--gray-50)", borderRadius: 10 }}>
                            <span style={{ color: "var(--gray-500)" }}>Time Spent: </span>
                            <span style={{ fontWeight: 700 }}>{formatTime(timeSpent)}</span>
                        </div>
                        {tabViolations > 0 && (
                            <div style={{ padding: "0.5rem 1rem", background: "var(--danger-light)", borderRadius: 10, color: "#991b1b" }}>
                                ⚠️ Tab violations: {tabViolations}
                            </div>
                        )}
                    </div>

                    <button onClick={() => router.push("/student/dashboard")} style={{
                        padding: "0.75rem 2rem", borderRadius: 12,
                        background: "linear-gradient(135deg, var(--primary-500), var(--primary-600))",
                        color: "#fff", fontWeight: 700, fontSize: "0.9rem",
                        border: "none", cursor: "pointer", boxShadow: "0 2px 8px rgba(37,99,235,0.25)"
                    }}>← Back to Exam Portal</button>
                </div>
            </div>
        );
    }

    /* ─── EXAM UI ─── */
    return (
        <div style={{ minHeight: "100vh", background: "var(--gray-50)", display: "flex", flexDirection: "column", userSelect: "none" }}>

            {/* ── Top Bar ── */}
            <div style={{
                background: "#fff", borderBottom: "1px solid var(--gray-100)",
                padding: "0.75rem 1.5rem", display: "flex", alignItems: "center", justifyContent: "space-between",
                position: "sticky", top: 0, zIndex: 100,
            }}>
                <div>
                    <div style={{ fontWeight: 700, fontSize: "1rem", color: "var(--gray-900)" }}>{exam.title}</div>
                    <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>{exam.course} · {exam.type}</div>
                </div>

                {/* Timer */}
                <div style={{
                    display: "flex", alignItems: "center", gap: "0.75rem",
                    padding: "0.5rem 1.25rem", borderRadius: 12,
                    background: isLowTime ? "var(--danger-light)" : "var(--gray-50)",
                    border: `1.5px solid ${isLowTime ? "var(--danger)" : "var(--gray-200)"}`,
                }}>
                    <span style={{ fontSize: "0.8rem", color: isLowTime ? "#991b1b" : "var(--gray-500)" }}>⏱ Time Left</span>
                    <span style={{
                        fontSize: "1.25rem", fontWeight: 800, fontVariantNumeric: "tabular-nums",
                        color: isLowTime ? "var(--danger)" : "var(--gray-900)",
                        animation: isLowTime ? "pulse 1s infinite" : "none",
                    }}>{formatTime(timeLeft)}</span>
                </div>

                <button onClick={handleSubmitClick} style={{
                    padding: "0.6rem 1.5rem", borderRadius: 10,
                    background: "linear-gradient(135deg, var(--success), #059669)",
                    color: "#fff", fontWeight: 700, fontSize: "0.85rem",
                    border: "none", cursor: "pointer",
                    boxShadow: "0 2px 8px rgba(16,185,129,0.3)",
                }}>💾 Save & Submit</button>
            </div>

            {/* ── Progress Bar ── */}
            <div style={{ height: 4, background: "var(--gray-100)" }}>
                <div style={{
                    height: "100%", background: isLowTime ? "var(--danger)" : "var(--primary-500)",
                    width: `${timePercent}%`, transition: "width 1s linear",
                }} />
            </div>

            {/* ── Main Content ── */}
            <div style={{ display: "flex", flex: 1, overflow: "hidden" }}>

                {/* ── Question Panel ── */}
                <div style={{ flex: 1, padding: "2rem", overflowY: "auto" }}>
                    {/* Question Header */}
                    <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: "1.5rem" }}>
                        <div style={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
                            <span style={{
                                width: 36, height: 36, borderRadius: 10,
                                background: "var(--primary-500)", color: "#fff",
                                display: "flex", alignItems: "center", justifyContent: "center",
                                fontWeight: 800, fontSize: "0.9rem"
                            }}>{question.order}</span>
                            <span style={{ fontSize: "0.85rem", color: "var(--gray-500)" }}>of {exam.totalQuestions}</span>
                            <span style={{
                                padding: "0.3rem 0.75rem", borderRadius: 8,
                                background: question.type === "mcq" ? "var(--primary-50)" : question.type === "truefalse" ? "var(--purple-light)" : "var(--warning-light)",
                                color: question.type === "mcq" ? "var(--primary-600)" : question.type === "truefalse" ? "#5b21b6" : "#92400e",
                                fontWeight: 700, fontSize: "0.7rem", textTransform: "uppercase"
                            }}>
                                {question.type === "mcq" ? "Multiple Choice" : question.type === "truefalse" ? "True / False" : "Fill in the Blank"}
                            </span>
                        </div>
                        <button onClick={() => toggleFlag(question.id)} style={{
                            display: "flex", alignItems: "center", gap: "0.4rem",
                            padding: "0.5rem 1rem", borderRadius: 10,
                            background: flagged.has(question.id) ? "var(--warning-light)" : "var(--gray-50)",
                            border: `1.5px solid ${flagged.has(question.id) ? "var(--warning)" : "var(--gray-200)"}`,
                            color: flagged.has(question.id) ? "#92400e" : "var(--gray-600)",
                            fontWeight: 600, fontSize: "0.8rem", cursor: "pointer",
                        }}>
                            {flagged.has(question.id) ? "🚩 Flagged" : "🏳️ Flag"}
                        </button>
                    </div>

                    {/* Question Text */}
                    <div style={{
                        background: "#fff", borderRadius: 16, padding: "2rem",
                        border: "1px solid var(--gray-100)", marginBottom: "1.5rem",
                        boxShadow: "0 1px 3px rgba(0,0,0,0.04)",
                    }}>
                        <p style={{ fontSize: "1.1rem", lineHeight: 1.7, fontWeight: 500, color: "var(--gray-800)" }}>
                            {question.text}
                        </p>
                    </div>

                    {/* Answer Area */}
                    <div style={{ marginBottom: "2rem" }}>
                        {question.type === "mcq" && question.options?.map((opt, i) => {
                            const letter = String.fromCharCode(65 + i);
                            const isSelected = answers[question.id] === opt;
                            return (
                                <label key={i} onClick={() => setAnswer(question.id, opt)} style={{
                                    display: "flex", alignItems: "center", gap: "1rem",
                                    padding: "1rem 1.25rem", borderRadius: 14, marginBottom: "0.5rem",
                                    background: isSelected ? "var(--primary-50)" : "#fff",
                                    border: `2px solid ${isSelected ? "var(--primary-500)" : "var(--gray-200)"}`,
                                    cursor: "pointer", transition: "all 150ms ease",
                                }}>
                                    <span style={{
                                        width: 34, height: 34, borderRadius: 10,
                                        background: isSelected ? "var(--primary-500)" : "var(--gray-100)",
                                        color: isSelected ? "#fff" : "var(--gray-600)",
                                        display: "flex", alignItems: "center", justifyContent: "center",
                                        fontWeight: 700, fontSize: "0.85rem",
                                    }}>{letter}</span>
                                    <span style={{ fontSize: "0.95rem", fontWeight: isSelected ? 600 : 400, color: "var(--gray-800)" }}>{opt}</span>
                                    {isSelected && <span style={{ marginLeft: "auto", color: "var(--primary-500)" }}>✓</span>}
                                </label>
                            );
                        })}

                        {question.type === "truefalse" && (
                            <div style={{ display: "flex", gap: "1rem" }}>
                                {["True", "False"].map(opt => {
                                    const isSelected = answers[question.id] === opt;
                                    return (
                                        <button key={opt} onClick={() => setAnswer(question.id, opt)} style={{
                                            flex: 1, padding: "1.25rem", borderRadius: 14,
                                            background: isSelected ? (opt === "True" ? "var(--success-light)" : "var(--danger-light)") : "#fff",
                                            border: `2px solid ${isSelected ? (opt === "True" ? "var(--success)" : "var(--danger)") : "var(--gray-200)"}`,
                                            cursor: "pointer", fontSize: "1rem", fontWeight: 700,
                                            color: isSelected ? (opt === "True" ? "#065f46" : "#991b1b") : "var(--gray-700)",
                                            transition: "all 150ms ease",
                                        }}>
                                            {opt === "True" ? "✓ True" : "✗ False"}
                                        </button>
                                    );
                                })}
                            </div>
                        )}

                        {question.type === "fillin" && (
                            <input
                                type="text"
                                value={answers[question.id] || ""}
                                onChange={(e) => setAnswer(question.id, e.target.value)}
                                placeholder="Type your answer here..."
                                style={{
                                    width: "100%", padding: "1rem 1.25rem", borderRadius: 14,
                                    border: "2px solid var(--gray-200)", fontSize: "1rem",
                                    background: "#fff", outline: "none",
                                    transition: "border-color 150ms ease",
                                }}
                                onFocus={(e) => e.target.style.borderColor = "var(--primary-500)"}
                                onBlur={(e) => e.target.style.borderColor = "var(--gray-200)"}
                            />
                        )}
                    </div>

                    {/* Navigation Buttons */}
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                        <button onClick={() => setCurrentQ(Math.max(0, currentQ - 1))} disabled={currentQ === 0} style={{
                            padding: "0.65rem 1.5rem", borderRadius: 10,
                            background: currentQ === 0 ? "var(--gray-100)" : "#fff",
                            border: "1.5px solid var(--gray-200)", color: currentQ === 0 ? "var(--gray-300)" : "var(--gray-700)",
                            fontWeight: 600, fontSize: "0.85rem", cursor: currentQ === 0 ? "not-allowed" : "pointer",
                        }}>← Previous</button>

                        <span style={{ fontSize: "0.85rem", color: "var(--gray-400)" }}>
                            Question {currentQ + 1} of {exam.totalQuestions}
                        </span>

                        <button onClick={() => setCurrentQ(Math.min(exam.totalQuestions - 1, currentQ + 1))} disabled={currentQ === exam.totalQuestions - 1} style={{
                            padding: "0.65rem 1.5rem", borderRadius: 10,
                            background: currentQ === exam.totalQuestions - 1 ? "var(--gray-100)" : "var(--primary-500)",
                            border: "none", color: currentQ === exam.totalQuestions - 1 ? "var(--gray-300)" : "#fff",
                            fontWeight: 600, fontSize: "0.85rem", cursor: currentQ === exam.totalQuestions - 1 ? "not-allowed" : "pointer",
                        }}>Next →</button>
                    </div>
                </div>

                {/* ── Question Navigator Sidebar ── */}
                <div style={{
                    width: 240, background: "#fff", borderLeft: "1px solid var(--gray-100)",
                    padding: "1.5rem", overflowY: "auto",
                }}>
                    <div style={{ fontSize: "0.85rem", fontWeight: 700, color: "var(--gray-700)", marginBottom: "1rem" }}>Question Navigator</div>

                    <div style={{ display: "grid", gridTemplateColumns: "repeat(5, 1fr)", gap: 6, marginBottom: "1.5rem" }}>
                        {exam.questions.map((q, i) => {
                            const isAnswered = answers[q.id] !== undefined;
                            const isFlagged = flagged.has(q.id);
                            const isCurrent = i === currentQ;
                            return (
                                <button key={q.id} onClick={() => setCurrentQ(i)} style={{
                                    width: 38, height: 38, borderRadius: 10, border: "none",
                                    background: isCurrent
                                        ? "var(--primary-500)"
                                        : isFlagged
                                            ? "var(--warning-light)"
                                            : isAnswered
                                                ? "var(--success-light)"
                                                : "var(--gray-100)",
                                    color: isCurrent ? "#fff"
                                        : isFlagged ? "#92400e"
                                            : isAnswered ? "#065f46" : "var(--gray-500)",
                                    fontWeight: 700, fontSize: "0.8rem", cursor: "pointer",
                                    position: "relative",
                                    boxShadow: isCurrent ? "0 2px 8px rgba(37,99,235,0.25)" : "none",
                                }}>
                                    {q.order}
                                    {isFlagged && <span style={{ position: "absolute", top: -2, right: -2, fontSize: "0.6rem" }}>🚩</span>}
                                </button>
                            );
                        })}
                    </div>

                    {/* Legend */}
                    <div style={{ fontSize: "0.75rem", color: "var(--gray-500)", display: "flex", flexDirection: "column", gap: "0.5rem", marginBottom: "1.5rem" }}>
                        <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                            <span style={{ width: 14, height: 14, borderRadius: 4, background: "var(--success-light)", border: "1px solid #d1fae5" }} />
                            Answered ({answeredCount})
                        </div>
                        <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                            <span style={{ width: 14, height: 14, borderRadius: 4, background: "var(--gray-100)" }} />
                            Unanswered ({exam.totalQuestions - answeredCount})
                        </div>
                        <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                            <span style={{ width: 14, height: 14, borderRadius: 4, background: "var(--warning-light)", border: "1px solid #fef3c7" }} />
                            Flagged ({flagged.size})
                        </div>
                    </div>

                    {/* Summary */}
                    <div style={{
                        padding: "1rem", borderRadius: 12, background: "var(--gray-50)",
                        border: "1px solid var(--gray-200)", fontSize: "0.8rem",
                    }}>
                        <div style={{ fontWeight: 700, marginBottom: "0.5rem" }}>Progress</div>
                        <div style={{ height: 6, background: "var(--gray-200)", borderRadius: 3, marginBottom: "0.5rem" }}>
                            <div style={{ height: "100%", background: "var(--success)", borderRadius: 3, width: `${(answeredCount / exam.totalQuestions) * 100}%`, transition: "width 200ms ease" }} />
                        </div>
                        <div style={{ color: "var(--gray-500)" }}>{answeredCount} of {exam.totalQuestions} answered</div>
                    </div>
                </div>
            </div>

            {/* ── MODALS ── */}

            {/* Confirm Submit Modal */}
            {showConfirm && (
                <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 9999 }}>
                    <div style={{ background: "#fff", borderRadius: 20, padding: "2rem", maxWidth: 420, width: "90%", textAlign: "center" }}>
                        <div style={{ fontSize: "3rem", marginBottom: "1rem" }}>📋</div>
                        <h2 style={{ fontSize: "1.25rem", fontWeight: 800, marginBottom: "0.5rem" }}>Submit Exam?</h2>
                        <p style={{ color: "var(--gray-500)", marginBottom: "0.75rem", fontSize: "0.9rem" }}>Are you sure you want to submit your exam?</p>
                        <div style={{ background: "var(--gray-50)", borderRadius: 12, padding: "1rem", marginBottom: "1.5rem", fontSize: "0.85rem" }}>
                            <div>Answered: <strong>{answeredCount}/{exam.totalQuestions}</strong></div>
                            <div>Unanswered: <strong style={{ color: "var(--danger)" }}>{exam.totalQuestions - answeredCount}</strong></div>
                            <div>Flagged: <strong style={{ color: "var(--warning)" }}>{flagged.size}</strong></div>
                        </div>
                        {exam.totalQuestions - answeredCount > 0 && (
                            <div style={{ background: "var(--warning-light)", borderRadius: 10, padding: "0.75rem", marginBottom: "1rem", color: "#92400e", fontSize: "0.8rem", fontWeight: 600 }}>
                                ⚠️ You have {exam.totalQuestions - answeredCount} unanswered question(s)!
                            </div>
                        )}
                        <div style={{ display: "flex", gap: "0.75rem" }}>
                            <button onClick={() => setShowConfirm(false)} style={{ flex: 1, padding: "0.75rem", borderRadius: 12, background: "var(--gray-100)", border: "none", fontWeight: 600, cursor: "pointer", color: "var(--gray-700)" }}>Go Back</button>
                            <button onClick={confirmSubmit} style={{ flex: 1, padding: "0.75rem", borderRadius: 12, background: "var(--success)", border: "none", fontWeight: 700, cursor: "pointer", color: "#fff" }}>Yes, Submit</button>
                        </div>
                    </div>
                </div>
            )}

            {/* Early Warning Modal — must stay minimum time */}
            {showEarlyWarning && (
                <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 9999 }}>
                    <div style={{ background: "#fff", borderRadius: 20, padding: "2rem", maxWidth: 420, width: "90%", textAlign: "center" }}>
                        <div style={{ fontSize: "3rem", marginBottom: "1rem" }}>⏳</div>
                        <h2 style={{ fontSize: "1.25rem", fontWeight: 800, marginBottom: "0.5rem", color: "var(--danger)" }}>Cannot Submit Yet</h2>
                        <p style={{ color: "var(--gray-600)", marginBottom: "1rem", fontSize: "0.9rem", lineHeight: 1.6 }}>
                            You must remain in the exam hall for at least <strong>{exam.minimumTime} minutes</strong> (half of the allotted time).
                        </p>
                        <div style={{ background: "var(--danger-light)", borderRadius: 12, padding: "1rem", marginBottom: "1.5rem", color: "#991b1b", fontSize: "0.85rem" }}>
                            <div>Time spent: <strong>{formatTime(timeSpent)}</strong></div>
                            <div>Minimum required: <strong>{formatTime(minimumTimeSeconds)}</strong></div>
                            <div>Remaining: <strong>{formatTime(minimumTimeSeconds - timeSpent)}</strong></div>
                        </div>
                        <p style={{ fontSize: "0.8rem", color: "var(--gray-500)", marginBottom: "1rem" }}>
                            Please take your time to review your answers carefully.
                        </p>
                        <button onClick={() => setShowEarlyWarning(false)} style={{ padding: "0.75rem 2rem", borderRadius: 12, background: "var(--primary-500)", border: "none", fontWeight: 700, cursor: "pointer", color: "#fff" }}>OK, Continue Exam</button>
                    </div>
                </div>
            )}

            {/* Tab Warning Modal */}
            {showTabWarning && (
                <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.7)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 9999 }}>
                    <div style={{ background: "#fff", borderRadius: 20, padding: "2rem", maxWidth: 420, width: "90%", textAlign: "center" }}>
                        <div style={{ fontSize: "3rem", marginBottom: "1rem" }}>🚨</div>
                        <h2 style={{ fontSize: "1.25rem", fontWeight: 800, marginBottom: "0.5rem", color: "var(--danger)" }}>Tab Switch Detected!</h2>
                        <p style={{ color: "var(--gray-600)", marginBottom: "1rem", fontSize: "0.9rem", lineHeight: 1.6 }}>
                            You left the exam tab. This has been recorded and will be reported. Excessive tab switching may result in disqualification.
                        </p>
                        <div style={{ background: "var(--danger-light)", borderRadius: 12, padding: "0.75rem", marginBottom: "1.5rem", color: "#991b1b", fontWeight: 700, fontSize: "0.9rem" }}>
                            Total violations: {tabViolations} / 3
                        </div>
                        {tabViolations >= 3 ? (
                            <button onClick={() => { setShowTabWarning(false); setSubmitted(true); }} style={{ padding: "0.75rem 2rem", borderRadius: 12, background: "var(--danger)", border: "none", fontWeight: 700, cursor: "pointer", color: "#fff" }}>
                                Exam Auto-Submitted (Disqualified)
                            </button>
                        ) : (
                            <button onClick={() => setShowTabWarning(false)} style={{ padding: "0.75rem 2rem", borderRadius: 12, background: "var(--primary-500)", border: "none", fontWeight: 700, cursor: "pointer", color: "#fff" }}>
                                Return to Exam
                            </button>
                        )}
                    </div>
                </div>
            )}

            {/* Too-Fast Report Modal */}
            {showReport && (
                <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 9999 }}>
                    <div style={{ background: "#fff", borderRadius: 20, padding: "2rem", maxWidth: 420, width: "90%", textAlign: "center" }}>
                        <div style={{ fontSize: "3rem", marginBottom: "1rem" }}>⚠️</div>
                        <h2 style={{ fontSize: "1.25rem", fontWeight: 800, marginBottom: "0.5rem", color: "var(--warning)" }}>Suspiciously Fast Completion</h2>
                        <p style={{ color: "var(--gray-600)", marginBottom: "1rem", fontSize: "0.9rem", lineHeight: 1.6 }}>
                            You completed the exam in <strong>{formatTime(timeSpent)}</strong>. This is unusually fast and has been flagged for review.
                        </p>
                        <div style={{ background: "var(--warning-light)", borderRadius: 12, padding: "1rem", marginBottom: "1.5rem", color: "#92400e", fontSize: "0.85rem", lineHeight: 1.6 }}>
                            <p><strong>Please take your time</strong> to carefully read and answer each question. Rushing through exams may affect your grade and will be reported to your teacher.</p>
                        </div>
                        <div style={{ display: "flex", gap: "0.75rem" }}>
                            <button onClick={() => setShowReport(false)} style={{ flex: 1, padding: "0.75rem", borderRadius: 12, background: "var(--primary-500)", border: "none", fontWeight: 700, cursor: "pointer", color: "#fff" }}>Go Back & Review</button>
                            <button onClick={forceSubmitAfterReport} style={{ flex: 1, padding: "0.75rem", borderRadius: 12, background: "var(--gray-100)", border: "none", fontWeight: 600, cursor: "pointer", color: "var(--gray-700)" }}>Submit Anyway</button>
                        </div>
                    </div>
                </div>
            )}

            <style>{`
                @keyframes pulse {
                    0%, 100% { opacity: 1; }
                    50% { opacity: 0.5; }
                }
            `}</style>
        </div>
    );
}
