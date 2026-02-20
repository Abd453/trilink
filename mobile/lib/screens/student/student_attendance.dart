import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentAttendance extends StatelessWidget {
  const StudentAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {'name': 'Mathematics', 'present': 23, 'absent': 1, 'late': 0},
      {'name': 'Physics', 'present': 22, 'absent': 1, 'late': 1},
      {'name': 'Chemistry', 'present': 22, 'absent': 2, 'late': 0},
      {'name': 'English', 'present': 23, 'absent': 1, 'late': 0},
      {'name': 'Biology', 'present': 23, 'absent': 0, 'late': 1},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attendance', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          SizedBox(height: 20),
          // Summary cards
          Row(children: [
            Expanded(child: _SummaryCard(label: 'Present', value: '113', color: AppColors.success, icon: Icons.check_circle_rounded)),
            SizedBox(width: 10),
            Expanded(child: _SummaryCard(label: 'Absent', value: '5', color: AppColors.danger, icon: Icons.cancel_rounded)),
            SizedBox(width: 10),
            Expanded(child: _SummaryCard(label: 'Rate', value: '94%', color: AppColors.primary500, icon: Icons.pie_chart_rounded)),
          ]),
          SizedBox(height: 24),
          Text('Subject-wise Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          ...subjects.map((s) {
            final total = (s['present'] as int) + (s['absent'] as int) + (s['late'] as int);
            final rate = ((s['present'] as int) / total * 100).round();
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(s['name'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    Text('$rate%', style: TextStyle(fontWeight: FontWeight.w700, color: rate >= 90 ? AppColors.success : AppColors.warning)),
                  ]),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(value: rate / 100, backgroundColor: AppColors.gray100, color: rate >= 90 ? AppColors.success : AppColors.warning, minHeight: 6),
                  ),
                  SizedBox(height: 8),
                  Row(children: [
                    _MiniStat('Present', '${s['present']}', AppColors.success),
                    SizedBox(width: 16),
                    _MiniStat('Absent', '${s['absent']}', AppColors.danger),
                    SizedBox(width: 16),
                    _MiniStat('Late', '${s['late']}', AppColors.warning),
                  ]),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _SummaryCard({required this.label, required this.value, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 6),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label, value;
  final Color color;
  const _MiniStat(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      SizedBox(width: 4),
      Text('$label: $value', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
    ]);
  }
}
