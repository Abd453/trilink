"use client";
import { useRouter } from "next/navigation";

type QuestionType = "mcq" | "truefalse" | "fillin";

interface Question {
    id: number;
    order: number;
    type: QuestionType;
    text: string;
    options?: string[];
    correctAnswer: string;
    studentAnswer: string;
}

export default function ExamResult({ params }: { params: Promise<{ examId: string }> }) {
    const router = useRouter();

    // Mock result data
    const result = {
        exam: { course: "English", type: "Quiz", title: "Grammar & Vocabulary Quiz", date: "Feb 19, 2026", duration: "20 min", totalQuestions: 10 },
        score: 88,
        correct: 8,
        wrong: 1,
        unanswered: 1,
        timeTaken: "14:32",
        tabViolations: 0,
        questions: [
            { id: 1, order: 1, type: "mcq" as QuestionType, text: "Which of the following is a conjunction?", options: ["Run", "But", "Quickly", "Chair"], correctAnswer: "But", studentAnswer: "But" },
            { id: 2, order: 2, type: "truefalse" as QuestionType, text: "'Their' is a possessive pronoun.", correctAnswer: "True", studentAnswer: "True" },
            { id: 3, order: 3, type: "fillin" as QuestionType, text: "The past tense of 'go' is ______.", correctAnswer: "went", studentAnswer: "went" },
            { id: 4, order: 4, type: "mcq" as QuestionType, text: "What type of sentence is 'Close the door!'?", options: ["Declarative", "Interrogative", "Imperative", "Exclamatory"], correctAnswer: "Imperative", studentAnswer: "Imperative" },
            { id: 5, order: 5, type: "truefalse" as QuestionType, text: "An adverb modifies a noun.", correctAnswer: "False", studentAnswer: "False" },
            { id: 6, order: 6, type: "mcq" as QuestionType, text: "Which word is a synonym for 'happy'?", options: ["Sad", "Angry", "Joyful", "Tired"], correctAnswer: "Joyful", studentAnswer: "Joyful" },
            { id: 7, order: 7, type: "fillin" as QuestionType, text: "The plural of 'child' is ______.", correctAnswer: "children", studentAnswer: "children" },
            { id: 8, order: 8, type: "mcq" as QuestionType, text: "What is the subject in 'The cat sat on the mat'?", options: ["cat", "sat", "mat", "on"], correctAnswer: "cat", studentAnswer: "mat" },
            { id: 9, order: 9, type: "truefalse" as QuestionType, text: "A compound sentence has two independent clauses.", correctAnswer: "True", studentAnswer: "True" },
            { id: 10, order: 10, type: "mcq" as QuestionType, text: "Which is a preposition?", options: ["Under", "Beautiful", "Quickly", "Speak"], correctAnswer: "Under", studentAnswer: "" },
        ],
    };

    const getGrade = (score: number) => {
        if (score >= 90) return { letter: "A", color: "var(--success)" };
        if (score >= 80) return { letter: "B", color: "var(--primary-500)" };
        if (score >= 70) return { letter: "C", color: "var(--warning)" };
        if (score >= 60) return { letter: "D", color: "#f97316" };
        return { letter: "F", color: "var(--danger)" };
    };

    const grade = getGrade(result.score);

    return (
        <div>
            {/* Header */}
            <div style={{ marginBottom: "1.5rem" }}>
                <button onClick={() => router.push("/student/dashboard")} style={{
                    display: "flex", alignItems: "center", gap: "0.4rem",
                    background: "none", border: "none", color: "var(--primary-500)",
                    fontWeight: 600, fontSize: "0.85rem", cursor: "pointer", marginBottom: "1rem",
                }}>← Back to Exam Portal</button>
                <h1 style={{ fontSize: "1.5rem", fontWeight: 800, color: "var(--gray-900)" }}>📊 Exam Result</h1>
                <p style={{ fontSize: "0.875rem", color: "var(--gray-500)", marginTop: "0.25rem" }}>{result.exam.title}</p>
            </div>

            {/* Score Overview Card */}
            <div style={{
                background: "linear-gradient(135deg, #fff 0%, var(--gray-50) 100%)",
                borderRadius: 20, padding: "2rem", border: "1px solid var(--gray-100)",
                marginBottom: "1.5rem", display: "flex", alignItems: "center", gap: "2rem",
            }}>
                {/* Score Circle */}
                <div style={{ position: "relative", width: 120, height: 120 }}>
                    <svg width="120" height="120" viewBox="0 0 120 120">
                        <circle cx="60" cy="60" r="52" fill="none" stroke="var(--gray-100)" strokeWidth="8" />
                        <circle cx="60" cy="60" r="52" fill="none" stroke={grade.color} strokeWidth="8"
                            strokeDasharray={`${(result.score / 100) * 327} 327`}
                            strokeLinecap="round" transform="rotate(-90 60 60)" style={{ transition: "stroke-dasharray 1s ease" }} />
                    </svg>
                    <div style={{ position: "absolute", inset: 0, display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center" }}>
                        <span style={{ fontSize: "2rem", fontWeight: 900, color: grade.color }}>{result.score}%</span>
                        <span style={{ fontSize: "0.75rem", fontWeight: 700, color: "var(--gray-500)" }}>Grade {grade.letter}</span>
                    </div>
                </div>

                <div style={{ flex: 1 }}>
                    <h2 style={{ fontSize: "1.15rem", fontWeight: 700, marginBottom: "0.75rem" }}>{result.exam.course} — {result.exam.type}</h2>
                    <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: "0.75rem" }}>
                        <div style={{ background: "var(--success-light)", borderRadius: 12, padding: "0.75rem 1rem" }}>
                            <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--success)" }}>{result.correct}</div>
                            <div style={{ fontSize: "0.75rem", color: "#065f46" }}>Correct</div>
                        </div>
                        <div style={{ background: "var(--danger-light)", borderRadius: 12, padding: "0.75rem 1rem" }}>
                            <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--danger)" }}>{result.wrong}</div>
                            <div style={{ fontSize: "0.75rem", color: "#991b1b" }}>Wrong</div>
                        </div>
                        <div style={{ background: "var(--gray-100)", borderRadius: 12, padding: "0.75rem 1rem" }}>
                            <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--gray-600)" }}>{result.unanswered}</div>
                            <div style={{ fontSize: "0.75rem", color: "var(--gray-500)" }}>Unanswered</div>
                        </div>
                        <div style={{ background: "var(--primary-50)", borderRadius: 12, padding: "0.75rem 1rem" }}>
                            <div style={{ fontSize: "1.25rem", fontWeight: 800, color: "var(--primary-600)" }}>{result.timeTaken}</div>
                            <div style={{ fontSize: "0.75rem", color: "var(--primary-500)" }}>Time Taken</div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Question Review */}
            <h3 style={{ fontSize: "1.1rem", fontWeight: 700, marginBottom: "1rem" }}>Question Review</h3>
            <div style={{ display: "flex", flexDirection: "column", gap: "0.75rem", marginBottom: "2rem" }}>
                {result.questions.map(q => {
                    const isCorrect = q.studentAnswer.toLowerCase() === q.correctAnswer.toLowerCase();
                    const isUnanswered = !q.studentAnswer;
                    return (
                        <div key={q.id} style={{
                            background: "#fff", borderRadius: 16, padding: "1.25rem",
                            border: `1.5px solid ${isCorrect ? "var(--success)" : isUnanswered ? "var(--gray-200)" : "var(--danger)"}`,
                        }}>
                            <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: "0.5rem" }}>
                                <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                                    <span style={{
                                        width: 28, height: 28, borderRadius: 8,
                                        background: isCorrect ? "var(--success)" : isUnanswered ? "var(--gray-400)" : "var(--danger)",
                                        color: "#fff", display: "flex", alignItems: "center", justifyContent: "center",
                                        fontWeight: 700, fontSize: "0.75rem"
                                    }}>{q.order}</span>
                                    <span style={{
                                        padding: "0.2rem 0.5rem", borderRadius: 6, fontSize: "0.7rem", fontWeight: 600,
                                        background: q.type === "mcq" ? "var(--primary-50)" : q.type === "truefalse" ? "var(--purple-light)" : "var(--warning-light)",
                                        color: q.type === "mcq" ? "var(--primary-600)" : q.type === "truefalse" ? "#5b21b6" : "#92400e",
                                    }}>
                                        {q.type === "mcq" ? "MCQ" : q.type === "truefalse" ? "T/F" : "Fill"}
                                    </span>
                                </div>
                                <span style={{
                                    fontSize: "0.8rem", fontWeight: 700,
                                    color: isCorrect ? "var(--success)" : isUnanswered ? "var(--gray-500)" : "var(--danger)"
                                }}>
                                    {isCorrect ? "✓ Correct" : isUnanswered ? "— Skipped" : "✗ Wrong"}
                                </span>
                            </div>
                            <p style={{ fontSize: "0.9rem", fontWeight: 500, marginBottom: "0.75rem", lineHeight: 1.5 }}>{q.text}</p>
                            <div style={{ display: "flex", gap: "1rem", fontSize: "0.85rem" }}>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: "0.7rem", fontWeight: 600, color: "var(--gray-400)", marginBottom: "0.25rem", textTransform: "uppercase" }}>Your Answer</div>
                                    <div style={{
                                        padding: "0.5rem 0.75rem", borderRadius: 8,
                                        background: isCorrect ? "var(--success-light)" : isUnanswered ? "var(--gray-50)" : "var(--danger-light)",
                                        fontWeight: 600,
                                        color: isCorrect ? "#065f46" : isUnanswered ? "var(--gray-400)" : "#991b1b",
                                    }}>{q.studentAnswer || "(no answer)"}</div>
                                </div>
                                {!isCorrect && (
                                    <div style={{ flex: 1 }}>
                                        <div style={{ fontSize: "0.7rem", fontWeight: 600, color: "var(--gray-400)", marginBottom: "0.25rem", textTransform: "uppercase" }}>Correct Answer</div>
                                        <div style={{
                                            padding: "0.5rem 0.75rem", borderRadius: 8,
                                            background: "var(--success-light)", fontWeight: 600, color: "#065f46",
                                        }}>{q.correctAnswer}</div>
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
        </div>
    );
}
