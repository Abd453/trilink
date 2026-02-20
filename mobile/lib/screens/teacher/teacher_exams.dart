import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TeacherExams extends StatelessWidget {
  const TeacherExams({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Create quiz button
      SizedBox(width: double.infinity, height: 48, child: ElevatedButton.icon(icon: Icon(Icons.add_rounded), label: Text('Create New Quiz'), onPressed: () => _showCreateQuiz(context))),
      SizedBox(height: 24),
      Text('Recent Quizzes', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[
        {'t': 'Ch.7 Calculus Quiz', 'c': 'Grade 11-A', 'q': 15, 's': 'Active', 'sub': 38},
        {'t': 'Ch.5 Mechanics Test', 'c': 'Grade 12-A', 'q': 20, 's': 'Graded', 'sub': 35},
        {'t': 'Midterm Practice', 'c': 'Grade 11-B', 'q': 30, 's': 'Draft', 'sub': 0},
      ].map((e) => Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(e['t'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(
              color: e['s'] == 'Active' ? AppColors.success.withValues(alpha: 0.1) : e['s'] == 'Graded' ? AppColors.primary50 : AppColors.gray100,
              borderRadius: BorderRadius.circular(8)),
              child: Text(e['s'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: e['s'] == 'Active' ? AppColors.success : e['s'] == 'Graded' ? AppColors.primary500 : AppColors.gray500))),
          ]),
          SizedBox(height: 6),
          Text('${e['c']} · ${e['q']} questions · ${e['sub']} submissions', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          SizedBox(height: 10),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () {}, child: Text('Edit'))),
            SizedBox(width: 8),
            if (e['s'] == 'Active') Expanded(child: ElevatedButton(onPressed: () {}, child: Text('View Results'))),
          ]),
        ]))),
      SizedBox(height: 24),
      Text('Student Results', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[{'n': 'Abebe Kebede', 'sc': 92, 'g': 'A'}, {'n': 'Kalkidan Assefa', 'sc': 88, 'g': 'A-'}, {'n': 'Meron Girma', 'sc': 75, 'g': 'B'}, {'n': 'Samuel Dereje', 'sc': 95, 'g': 'A+'}].map((s) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
        child: Row(children: [
          Expanded(child: Text(s['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          Text('${s['sc']}%', style: TextStyle(fontWeight: FontWeight.w700, color: (s['sc'] as int) >= 90 ? AppColors.success : (s['sc'] as int) >= 80 ? AppColors.primary500 : AppColors.warning)),
          SizedBox(width: 10),
          Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primary50, borderRadius: BorderRadius.circular(8)), child: Text(s['g'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.primary600))),
        ]))),
    ]));
  }

  void _showCreateQuiz(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(padding: EdgeInsets.all(24).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Create Quiz', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          SizedBox(height: 20),
          TextField(decoration: InputDecoration(labelText: 'Quiz Title', hintText: 'e.g., Chapter 7 Quiz')),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Number of Questions', hintText: '15'), keyboardType: TextInputType.number),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Duration (minutes)', hintText: '30'), keyboardType: TextInputType.number),
          SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Create & Add Questions'))),
        ])));
  }
}
