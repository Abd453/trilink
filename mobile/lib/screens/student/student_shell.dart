import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'student_dashboard.dart';
import 'student_announcements.dart';
import 'student_grades.dart';
import 'student_attendance.dart';
import 'student_chat.dart';
import 'student_feedback.dart';
import 'student_game.dart';
import 'student_calendar.dart';
import 'student_profile.dart';
import 'student_settings.dart';
import 'student_notifications.dart';
import 'student_exam_scores.dart';
import 'student_ai_assistant.dart';

class StudentShell extends StatefulWidget {
  const StudentShell({super.key});
  @override
  State<StudentShell> createState() => _StudentShellState();
}

class _StudentShellState extends State<StudentShell> {
  int _currentIndex = 0;

  final _pages = const [
    StudentDashboard(),
    StudentGrades(),
    StudentAIAssistant(),
    StudentChat(),
    StudentProfilePage(),
  ];

  final _drawerPages = <String, Widget>{
    'Dashboard': const StudentDashboard(),
    'Announcements': const StudentAnnouncements(),
    'Grades': const StudentGrades(),
    'AI Assistant': const StudentAIAssistant(),
    'Attendance': const StudentAttendance(),
    'Chat': const StudentChat(),
    'Feedback': const StudentFeedback(),
    'Game Zone': const StudentGame(),
    'Calendar': const StudentCalendar(),
    'Profile': const StudentProfilePage(),
    'Settings': const StudentSettings(),
    'Exam Scores': const StudentExamScores(),
  };

  final _drawerIcons = {
    'Dashboard': Icons.dashboard_rounded,
    'Announcements': Icons.campaign_rounded,
    'Grades': Icons.grading_rounded,
    'AI Assistant': Icons.auto_awesome_rounded,
    'Attendance': Icons.fact_check_rounded,
    'Chat': Icons.chat_rounded,
    'Feedback': Icons.rate_review_rounded,
    'Game Zone': Icons.sports_esports_rounded,
    'Calendar': Icons.calendar_month_rounded,
    'Profile': Icons.person_rounded,
    'Settings': Icons.settings_rounded,
    'Exam Scores': Icons.quiz_rounded,
  };

  Widget _currentPage() => _pages[_currentIndex];

  void _navigateToDrawerPage(String key) {
    Navigator.pop(context); // close drawer
    final page = _drawerPages[key]!;
    if (_pages.contains(page)) {
      setState(() => _currentIndex = _pages.indexOf(page));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(
        appBar: AppBar(title: Text(key)),
        body: page,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TriLink'),
        actions: [
          IconButton(
            icon: Stack(children: [
              Icon(Icons.notifications_outlined),
              Positioned(right: 0, top: 0, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.danger, shape: BoxShape.circle))),
            ]),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text('Notifications')), body: StudentNotifications()))),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.primary600, AppColors.primary800]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 30, backgroundColor: Colors.white.withValues(alpha: 0.2), child: Text('AK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18))),
                    SizedBox(height: 12),
                    Text('Abebe Kebede', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    Text('Grade 11-A · Student', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: _drawerPages.keys.map((key) => ListTile(
                    leading: Icon(_drawerIcons[key], color: AppColors.gray600, size: 22),
                    title: Text(key, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () => _navigateToDrawerPage(key),
                    dense: true,
                  )).toList(),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout_rounded, color: AppColors.danger),
                title: Text('Logout', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/role-selection', (_) => false),
              ),
            ],
          ),
        ),
      ),
      body: _currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grading_rounded), label: 'Grades'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_rounded), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
