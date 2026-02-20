import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentAnnouncements extends StatelessWidget {
  const StudentAnnouncements({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = [
      {'title': 'Midterm Exam Schedule', 'body': 'Midterm exams will be held from Feb 25 to Mar 5. Please check the detailed schedule.', 'date': 'Feb 19', 'type': 'exam', 'from': 'Admin Office'},
      {'title': 'Science Fair Registration', 'body': 'Registration for the annual science fair is now open. Deadline: Feb 28.', 'date': 'Feb 18', 'type': 'event', 'from': 'Ms. Sara'},
      {'title': 'Library Hours Extended', 'body': 'The library will now be open until 8 PM on weekdays during exam season.', 'date': 'Feb 17', 'type': 'general', 'from': 'Admin Office'},
      {'title': 'Mathematics Quiz Tomorrow', 'body': 'Chapter 7 quiz will be conducted tomorrow during first period.', 'date': 'Feb 16', 'type': 'exam', 'from': 'Mr. Solomon'},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...announcements.map((a) {
            final color = a['type'] == 'exam' ? AppColors.danger : a['type'] == 'event' ? AppColors.primary500 : AppColors.success;
            final icon = a['type'] == 'exam' ? Icons.event_note_rounded : a['type'] == 'event' ? Icons.celebration_rounded : Icons.info_rounded;
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.gray100),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(a['title']!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    Text('${a['from']} · ${a['date']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ])),
                ]),
                SizedBox(height: 10),
                Text(a['body']!, style: TextStyle(fontSize: 13, color: AppColors.gray600, height: 1.4)),
              ]),
            );
          }),
        ],
      ),
    );
  }
}
