import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentCalendar extends StatelessWidget {
  const StudentCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {'title': 'Math Quiz', 'date': 'Feb 22', 'color': AppColors.danger},
      {'title': 'Physics Lab Due', 'date': 'Feb 23', 'color': AppColors.warning},
      {'title': 'Parent-Teacher Conf.', 'date': 'Feb 28', 'color': AppColors.primary500},
    ];
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final today = 19;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('February 2026', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        SizedBox(height: 16),
        // Calendar grid
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
          child: Column(children: [
            Row(children: days.map((d) => Expanded(child: Center(child: Text(d, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gray400))))).toList()),
            SizedBox(height: 8),
            ...List.generate(4, (week) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(children: List.generate(7, (day) {
                final num = week * 7 + day + 1;
                if (num > 28) return Expanded(child: SizedBox());
                final isToday = num == today;
                final hasEvent = [22, 23, 28].contains(num);
                return Expanded(child: GestureDetector(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.primary500 : hasEvent ? AppColors.primary50 : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('$num', style: TextStyle(fontSize: 14, fontWeight: isToday ? FontWeight.w700 : FontWeight.w500, color: isToday ? Colors.white : hasEvent ? AppColors.primary600 : AppColors.textPrimary))),
                  ),
                ));
              })),
            )),
          ]),
        ),
        SizedBox(height: 24),
        Text('Upcoming Events', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        SizedBox(height: 12),
        ...events.map((e) => Container(
          margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100), boxShadow: [BoxShadow(color: (e['color'] as Color).withValues(alpha: 0.08), blurRadius: 10, offset: Offset(0, 4))]),
          child: Row(children: [
            Container(width: 4, height: 40, decoration: BoxDecoration(color: e['color'] as Color, borderRadius: BorderRadius.circular(2))),
            SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e['title'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(e['date'] as String, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
          ]),
        )),
      ]),
    );
  }
}
