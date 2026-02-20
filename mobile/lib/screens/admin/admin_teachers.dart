import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminTeachersList extends StatelessWidget {
  const AdminTeachersList({super.key});

  @override
  Widget build(BuildContext context) {
    final teachers = [
      {'n': 'Mr. Solomon', 's': 'Mathematics', 'c': 4, 'st': 156, 'r': 4.7},
      {'n': 'Ms. Sara', 's': 'Physics', 'c': 3, 'st': 115, 'r': 4.5},
      {'n': 'Mr. Tadesse', 's': 'Chemistry', 'c': 4, 'st': 160, 'r': 4.0},
      {'n': 'Ms. Helen', 's': 'English', 'c': 4, 'st': 158, 'r': 4.8},
    ];

    return ListView.builder(padding: EdgeInsets.all(16), itemCount: teachers.length, itemBuilder: (_, i) {
      final t = teachers[i];
      return Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
        child: Row(children: [
          CircleAvatar(radius: 24, backgroundColor: AppColors.purpleLight, child: Icon(Icons.person_rounded, color: AppColors.purple)),
          SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            Text('${t['s']} · ${t['c']} classes · ${t['st']} students', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ])),
          Row(children: [Icon(Icons.star_rounded, color: AppColors.warning, size: 18), SizedBox(width: 3), Text('${t['r']}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14))]),
        ]));
    });
  }
}
