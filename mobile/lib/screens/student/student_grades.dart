import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentGrades extends StatefulWidget {
  const StudentGrades({super.key});
  @override
  State<StudentGrades> createState() => _StudentGradesState();
}

class _StudentGradesState extends State<StudentGrades> {
  int? _selectedSubject;

  final _subjects = [
    {'name': 'Mathematics', 'avg': 92, 'grade': 'A', 'tests': [
      {'name': 'Quiz 1', 'score': 95}, {'name': 'Midterm', 'score': 88}, {'name': 'Quiz 2', 'score': 93},
    ]},
    {'name': 'Physics', 'avg': 88, 'grade': 'A-', 'tests': [
      {'name': 'Quiz 1', 'score': 90}, {'name': 'Lab Report', 'score': 85}, {'name': 'Midterm', 'score': 89},
    ]},
    {'name': 'Chemistry', 'avg': 78, 'grade': 'B+', 'tests': [
      {'name': 'Quiz 1', 'score': 80}, {'name': 'Lab Report', 'score': 72}, {'name': 'Midterm', 'score': 82},
    ]},
    {'name': 'English', 'avg': 85, 'grade': 'A-', 'tests': [
      {'name': 'Essay 1', 'score': 88}, {'name': 'Quiz 1', 'score': 82}, {'name': 'Midterm', 'score': 85},
    ]},
    {'name': 'Biology', 'avg': 91, 'grade': 'A', 'tests': [
      {'name': 'Quiz 1', 'score': 93}, {'name': 'Lab Report', 'score': 89}, {'name': 'Midterm', 'score': 91},
    ]},
  ];

  Color _gradeColor(int score) => score >= 90 ? AppColors.success : score >= 80 ? AppColors.primary500 : AppColors.warning;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Grades', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Tap a subject for details', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          SizedBox(height: 20),
          ..._subjects.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            final avg = s['avg'] as int;
            final isSelected = _selectedSubject == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedSubject = isSelected ? null : i),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary50 : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isSelected ? AppColors.primary200 : AppColors.gray100),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(s['name'] as String, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(value: avg / 100, backgroundColor: AppColors.gray100, color: _gradeColor(avg), minHeight: 6),
                        ),
                      ])),
                      SizedBox(width: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: _gradeColor(avg).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text('${s['grade']}', style: TextStyle(fontWeight: FontWeight.w700, color: _gradeColor(avg), fontSize: 14)),
                      ),
                      SizedBox(width: 8),
                      Text('$avg%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    ]),
                    if (isSelected) ...[
                      SizedBox(height: 12),
                      Divider(),
                      ...(s['tests'] as List).map((t) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(t['name'] as String, style: TextStyle(fontSize: 13, color: AppColors.gray600)),
                          Text('${t['score']}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _gradeColor(t['score'] as int))),
                        ]),
                      )),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
