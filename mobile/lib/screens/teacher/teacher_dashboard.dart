import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Good morning, Mr. Solomon! ☀️', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      SizedBox(height: 4), Text('Teaching overview for today', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      SizedBox(height: 20),
      GridView.count(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5, shrinkWrap: true, physics: NeverScrollableScrollPhysics(), children: [
        _Stat(Icons.people_rounded, 'Students', '156', AppColors.primary500, AppColors.primary50),
        _Stat(Icons.class_rounded, 'Classes Today', '4', AppColors.success, AppColors.successLight),
        _Stat(Icons.fact_check_rounded, 'Avg Attendance', '91%', AppColors.purple, AppColors.purpleLight),
        _Stat(Icons.grading_rounded, 'Pending', '12', AppColors.warning, AppColors.warningLight),
      ]),
      SizedBox(height: 24), Text('Today\'s Classes', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[{'n': 'Grade 11-A Math', 't': '8:00-8:45', 's': 'completed'}, {'n': 'Grade 11-B Math', 't': '9:00-9:45', 's': 'completed'}, {'n': 'Grade 12-A Calculus', 't': '10:00-10:45', 's': 'ongoing'}, {'n': 'Grade 12-B Calculus', 't': '11:00-11:45', 's': 'upcoming'}].map((c) {
        final color = c['s'] == 'completed' ? AppColors.success : c['s'] == 'ongoing' ? AppColors.primary500 : AppColors.gray300;
        return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            Container(width: 4, height: 36, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
            SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c['n']!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(c['t']!, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(c['s']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color))),
          ]));
      }),
      SizedBox(height: 80),
    ]));
  }
}

class _Stat extends StatelessWidget {
  final IconData icon; final String label, value; final Color color, bg;
  const _Stat(this.icon, this.label, this.value, this.color, this.bg);
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)),
        Spacer(), Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]));
  }
}
