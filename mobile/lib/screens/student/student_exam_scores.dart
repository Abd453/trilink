import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentExamScores extends StatelessWidget {
  const StudentExamScores({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = [
      {'course': 'English', 'type': 'Quiz', 'title': 'Grammar & Vocabulary Quiz', 'date': 'Feb 19', 'score': 88, 'total': 10, 'correct': 8, 'time': '14:32'},
      {'course': 'Biology', 'type': 'Test', 'title': 'Cell Biology Test', 'date': 'Feb 18', 'score': 94, 'total': 20, 'correct': 18, 'time': '38:15'},
      {'course': 'Mathematics', 'type': 'Quiz', 'title': 'Integration Quick Quiz', 'date': 'Feb 17', 'score': 75, 'total': 8, 'correct': 6, 'time': '12:04'},
      {'course': 'Physics', 'type': 'Midterm', 'title': 'Mechanics Midterm', 'date': 'Feb 14', 'score': 82, 'total': 30, 'correct': 24, 'time': '52:40'},
      {'course': 'Chemistry', 'type': 'Test', 'title': 'Organic Chemistry Test', 'date': 'Feb 10', 'score': 70, 'total': 25, 'correct': 17, 'time': '45:22'},
    ];

    final avgScore = exams.map((e) => e['score'] as int).reduce((a, b) => a + b) ~/ exams.length;

    Color scoreColor(int s) => s >= 90 ? AppColors.success : s >= 80 ? AppColors.primary500 : s >= 70 ? AppColors.warning : AppColors.danger;

    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Exam Scores', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      SizedBox(height: 4),
      Text('Your exam results from the web portal', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      SizedBox(height: 20),

      // Summary card
      Container(padding: EdgeInsets.all(20), width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary600, AppColors.primary800]), borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(children: [
            Text('$avgScore%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28)),
            Text('Average', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(children: [
            Text('${exams.length}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28)),
            Text('Exams Taken', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(children: [
            Text('${exams.where((e) => (e['score'] as int) >= 80).length}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28)),
            Text('Passed', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
        ])),

      SizedBox(height: 24),
      Text('Recent Exams', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      SizedBox(height: 12),

      ...exams.map((e) {
        final score = e['score'] as int;
        final color = scoreColor(score);
        return Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: e['type'] == 'Quiz' ? AppColors.primary50 : e['type'] == 'Test' ? AppColors.warningLight : AppColors.purpleLight, borderRadius: BorderRadius.circular(6)),
                  child: Text(e['type'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: e['type'] == 'Quiz' ? AppColors.primary600 : e['type'] == 'Test' ? AppColors.warning : AppColors.purple))),
                SizedBox(width: 8),
                Text(e['course'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.primary600)),
              ]),
              Text(e['date'] as String, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ]),
            SizedBox(height: 8),
            Text(e['title'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            SizedBox(height: 10),
            Row(children: [
              Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: score / 100, backgroundColor: AppColors.gray100, color: color, minHeight: 6))),
              SizedBox(width: 12),
              Text('$score%', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: color)),
            ]),
            SizedBox(height: 8),
            Row(children: [
              Text('${e['correct']}/${e['total']} correct', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              SizedBox(width: 16),
              Row(children: [Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary), SizedBox(width: 3), Text('${e['time']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))]),
            ]),
          ]));
      }),

      SizedBox(height: 16),
      Container(padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.infoLight, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Icon(Icons.computer_rounded, color: AppColors.info, size: 22), SizedBox(width: 12),
          Expanded(child: Text('To take exams, please use the web portal on a computer in the ICT lab.', style: TextStyle(fontSize: 13, color: AppColors.info, fontWeight: FontWeight.w500))),
        ])),
    ]));
  }
}
