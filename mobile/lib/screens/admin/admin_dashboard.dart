import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('School Analytics', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      SizedBox(height: 4), Text('School-wide performance overview', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      SizedBox(height: 20),
      GridView.count(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5, shrinkWrap: true, physics: NeverScrollableScrollPhysics(), children: [
        _S(Icons.school_rounded, 'Students', '1,247', AppColors.primary500, AppColors.primary50),
        _S(Icons.menu_book_rounded, 'Teachers', '68', AppColors.success, AppColors.successLight),
        _S(Icons.fact_check_rounded, 'Attendance', '89%', AppColors.purple, AppColors.purpleLight),
        _S(Icons.trending_up_rounded, 'Performance', '82%', AppColors.warning, AppColors.warningLight),
      ]),
      SizedBox(height: 24), Text('Grade Performance', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[{'g': 'Grade 9', 's': 320, 'a': 91, 'avg': 84}, {'g': 'Grade 10', 's': 310, 'a': 88, 'avg': 81}, {'g': 'Grade 11', 's': 315, 'a': 90, 'avg': 83}, {'g': 'Grade 12', 's': 302, 'a': 87, 'avg': 80}].map((g) => Container(
        margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(g['g'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            SizedBox(height: 2), Text('${g['s']} students · ${g['a']}% att.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ])),
          Column(children: [
            Text('${g['avg']}%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: (g['avg'] as int) >= 83 ? AppColors.success : AppColors.warning)),
            SizedBox(height: 4), SizedBox(width: 60, child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: (g['avg'] as int) / 100, backgroundColor: AppColors.gray100, color: (g['avg'] as int) >= 83 ? AppColors.success : AppColors.warning, minHeight: 4))),
          ]),
        ]))),
      SizedBox(height: 80),
    ]));
  }
}

class _S extends StatelessWidget {
  final IconData i; final String l, v; final Color c, b;
  const _S(this.i, this.l, this.v, this.c, this.b);
  @override
  Widget build(BuildContext context) => Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: b, borderRadius: BorderRadius.circular(10)), child: Icon(i, color: c, size: 20)),
      Spacer(), Text(v, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), Text(l, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
    ]));
}
