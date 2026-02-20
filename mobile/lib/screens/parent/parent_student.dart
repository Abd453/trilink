import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ParentStudentDetails extends StatelessWidget {
  const ParentStudentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Student card
      Container(width: double.infinity, padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.gray100)),
        child: Column(children: [
          CircleAvatar(radius: 40, backgroundColor: AppColors.primary100, child: Text('AK', style: TextStyle(color: AppColors.primary600, fontWeight: FontWeight.w800, fontSize: 24))),
          SizedBox(height: 12), Text('Abebe Kebede', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          Text('Grade 11-A · STU-042', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          SizedBox(height: 16), Divider(),
          SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _St('Avg', '87%', AppColors.primary500), _St('Att', '94%', AppColors.success), _St('Rank', '#5', AppColors.warning), _St('Tests', '24', AppColors.purple),
          ]),
        ])),
      SizedBox(height: 24), Text('Subject Grades', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[{'s': 'Mathematics', 'g': 'A', 'sc': 92, 't': 'Mr. Solomon'}, {'s': 'Physics', 'g': 'A-', 'sc': 88, 't': 'Ms. Sara'}, {'s': 'Chemistry', 'g': 'B+', 'sc': 78, 't': 'Mr. Tadesse'}, {'s': 'English', 'g': 'A-', 'sc': 85, 't': 'Ms. Helen'}, {'s': 'Biology', 'g': 'A', 'sc': 91, 't': 'Mr. Dawit'}].map((s) {
        final sc = s['sc'] as int;
        return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['s'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text('Teacher: ${s['t']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: (sc >= 90 ? AppColors.success : sc >= 80 ? AppColors.primary500 : AppColors.warning).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(s['g'] as String, style: TextStyle(fontWeight: FontWeight.w700, color: sc >= 90 ? AppColors.success : sc >= 80 ? AppColors.primary500 : AppColors.warning))),
            SizedBox(width: 8), Text('$sc%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ]));
      }),
    ]));
  }
}

class _St extends StatelessWidget {
  final String l, v; final Color c;
  const _St(this.l, this.v, this.c);
  @override
  Widget build(BuildContext context) => Column(children: [Text(v, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: c)), Text(l, style: TextStyle(fontSize: 11, color: AppColors.textSecondary))]);
}
