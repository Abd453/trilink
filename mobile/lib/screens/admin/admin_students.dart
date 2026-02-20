import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminStudentsList extends StatelessWidget {
  const AdminStudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      {'n': 'Abebe Kebede', 'id': 'STU-042', 'g': '11-A', 'att': 94, 'avg': 87, 's': 'active'},
      {'n': 'Kalkidan Assefa', 'id': 'STU-015', 'g': '11-A', 'att': 97, 'avg': 91, 's': 'active'},
      {'n': 'Meron Girma', 'id': 'STU-033', 'g': '11-A', 'att': 85, 'avg': 79, 's': 'warning'},
      {'n': 'Samuel Dereje', 'id': 'STU-019', 'g': '11-B', 'att': 92, 'avg': 85, 's': 'active'},
    ];

    return ListView.builder(padding: EdgeInsets.all(16), itemCount: students.length, itemBuilder: (_, i) {
      final s = students[i]; final avg = s['avg'] as int;
      return Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
        child: Row(children: [
          CircleAvatar(radius: 20, backgroundColor: AppColors.primary100, child: Text((s['n'] as String).split(' ').map((w) => w[0]).join(''), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary600))),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text('${s['id']} · Grade ${s['g']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: (avg >= 90 ? AppColors.success : avg >= 80 ? AppColors.primary500 : AppColors.warning).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
              child: Text('$avg%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: avg >= 90 ? AppColors.success : avg >= 80 ? AppColors.primary500 : AppColors.warning))),
            SizedBox(height: 4),
            Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: s['s'] == 'active' ? AppColors.successLight : AppColors.warningLight, borderRadius: BorderRadius.circular(6)),
              child: Text(s['s'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: s['s'] == 'active' ? AppColors.success : AppColors.warning))),
          ]),
        ]));
    });
  }
}
