import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ParentAttendancePage extends StatelessWidget {
  const ParentAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Attendance Report', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      SizedBox(height: 4), Text('Abebe\'s attendance records', style: TextStyle(color: AppColors.textSecondary)),
      SizedBox(height: 20),
      Row(children: [
        Expanded(child: _Card('Present', '113', AppColors.success, Icons.check_circle_rounded)),
        SizedBox(width: 10), Expanded(child: _Card('Absent', '5', AppColors.danger, Icons.cancel_rounded)),
        SizedBox(width: 10), Expanded(child: _Card('Rate', '94%', AppColors.primary500, Icons.pie_chart_rounded)),
      ]),
      SizedBox(height: 24), Text('Recent Attendance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), SizedBox(height: 12),
      ...[
        {'d': 'Feb 19', 'day': 'Wednesday', 's': 'present'},
        {'d': 'Feb 18', 'day': 'Tuesday', 's': 'present'},
        {'d': 'Feb 17', 'day': 'Monday', 's': 'late'},
        {'d': 'Feb 14', 'day': 'Friday', 's': 'present'},
        {'d': 'Feb 13', 'day': 'Thursday', 's': 'absent'},
        {'d': 'Feb 12', 'day': 'Wednesday', 's': 'present'},
      ].map((a) {
        final color = a['s'] == 'present' ? AppColors.success : a['s'] == 'absent' ? AppColors.danger : AppColors.warning;
        return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(a['s'] == 'present' ? Icons.check_rounded : a['s'] == 'absent' ? Icons.close_rounded : Icons.access_time_rounded, color: color, size: 20)),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a['day']!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(a['d']!, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(a['s']![0].toUpperCase() + a['s']!.substring(1), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color))),
          ]));
      }),
    ]));
  }
}

class _Card extends StatelessWidget {
  final String label, value; final Color color; final IconData icon;
  const _Card(this.label, this.value, this.color, this.icon);
  @override
  Widget build(BuildContext context) => Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
    child: Column(children: [Icon(icon, color: color, size: 24), SizedBox(height: 6), Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color)), Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary))]));
}
