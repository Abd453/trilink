import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentNotifications extends StatefulWidget {
  const StudentNotifications({super.key});
  @override
  State<StudentNotifications> createState() => _StudentNotificationsState();
}

class _StudentNotificationsState extends State<StudentNotifications> {
  final _notifications = [
    {'title': 'New grade posted for Mathematics', 'time': '10 min ago', 'read': false, 'icon': Icons.grading_rounded},
    {'title': 'Attendance marked for today', 'time': '1 hour ago', 'read': false, 'icon': Icons.fact_check_rounded},
    {'title': 'New announcement from Admin', 'time': '3 hours ago', 'read': true, 'icon': Icons.campaign_rounded},
    {'title': 'Quiz result: Physics Ch.5 - 88%', 'time': '1 day ago', 'read': true, 'icon': Icons.quiz_rounded},
    {'title': 'New message from Mr. Solomon', 'time': '2 days ago', 'read': true, 'icon': Icons.chat_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: _notifications.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (_, i) {
        final n = _notifications[i];
        final isRead = n['read'] as bool;
        return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isRead ? Colors.white : AppColors.primary50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isRead ? AppColors.gray100 : AppColors.primary200),
          ),
          child: Row(children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(color: isRead ? AppColors.gray100 : AppColors.primary100, borderRadius: BorderRadius.circular(12)),
              child: Icon(n['icon'] as IconData, color: isRead ? AppColors.gray500 : AppColors.primary500, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(n['title'] as String, style: TextStyle(fontSize: 13, fontWeight: isRead ? FontWeight.w500 : FontWeight.w600)),
              SizedBox(height: 2),
              Text(n['time'] as String, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ])),
            if (!isRead) Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.primary500, shape: BoxShape.circle)),
          ]),
        );
      },
    );
  }
}
