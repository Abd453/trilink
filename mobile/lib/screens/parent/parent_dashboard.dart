import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Welcome, Mr. Kebede! 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      SizedBox(height: 4), Text('Abebe\'s academic overview', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      SizedBox(height: 20),
      // Child card
      Container(width: double.infinity, padding: EdgeInsets.all(20),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.warning, Color(0xFFD97706)]), borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          CircleAvatar(radius: 30, backgroundColor: Colors.white24, child: Text('AK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18))),
          SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Abebe Kebede', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
            Text('Grade 11 — Section A', style: TextStyle(color: Colors.white70, fontSize: 13)),
            SizedBox(height: 8),
            Row(children: [
              _MiniStat2('Avg', '87%'), SizedBox(width: 16), _MiniStat2('Att', '94%'), SizedBox(width: 16), _MiniStat2('Rank', '#5'),
            ]),
          ])),
        ]),
      ),
      SizedBox(height: 24),
      Text('Subject Performance', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[{'n': 'Mathematics', 'sc': 92, 'ch': '+3%'}, {'n': 'Physics', 'sc': 88, 'ch': '+1%'}, {'n': 'Chemistry', 'sc': 78, 'ch': '-2%'}, {'n': 'English', 'sc': 85, 'ch': '+5%'}, {'n': 'Biology', 'sc': 91, 'ch': '+2%'}].map((s) {
        final sc = s['sc'] as int; final change = s['ch'] as String; final isPos = change.startsWith('+');
        return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              SizedBox(height: 6),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: sc / 100, backgroundColor: AppColors.gray100, color: sc >= 90 ? AppColors.success : sc >= 80 ? AppColors.primary500 : AppColors.warning, minHeight: 6)),
            ])),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('$sc%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              Text(change, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isPos ? AppColors.success : AppColors.danger)),
            ]),
          ]));
      }),
      SizedBox(height: 24),
      Text('Recent Activity', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[{'t': 'Math quiz scored: 92%', 'ti': '2 hours ago', 'i': Icons.grading_rounded}, {'t': 'Attendance: Present', 'ti': 'Today', 'i': Icons.check_circle_rounded}, {'t': 'Physics lab submitted', 'ti': 'Yesterday', 'i': Icons.assignment_turned_in_rounded}].map((a) =>
        Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            Icon(a['i'] as IconData, color: AppColors.primary500, size: 22), SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a['t'] as String, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              Text(a['ti'] as String, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
          ]))),
      SizedBox(height: 80),
    ]));
  }
}

class _MiniStat2 extends StatelessWidget {
  final String label, value;
  const _MiniStat2(this.label, this.value);
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: TextStyle(fontSize: 10, color: Colors.white60)),
    Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
  ]);
}
