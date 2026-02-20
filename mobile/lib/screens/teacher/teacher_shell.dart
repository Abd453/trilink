import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'teacher_dashboard.dart';
import 'teacher_attendance.dart';
import 'teacher_exams.dart';
import 'teacher_students.dart';
import 'teacher_chat.dart';

class TeacherShell extends StatefulWidget {
  const TeacherShell({super.key});
  @override
  State<TeacherShell> createState() => _TeacherShellState();
}

class _TeacherShellState extends State<TeacherShell> {
  int _index = 0;
  final _pages = const [TeacherDashboard(), TeacherAttendancePage(), TeacherExams(), TeacherStudents(), TeacherChat()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TriLink · Teacher'),
        leading: Builder(builder: (ctx) => IconButton(icon: Icon(Icons.menu_rounded), onPressed: () => Scaffold.of(ctx).openDrawer())),
      ),
      drawer: Drawer(child: SafeArea(child: Column(children: [
        Container(width: double.infinity, padding: EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.success, Color(0xFF059669)])),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(radius: 28, backgroundColor: Colors.white24, child: Text('MS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
            SizedBox(height: 10),
            Text('Mr. Solomon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
            Text('Mathematics Teacher', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ])),
        Expanded(child: ListView(padding: EdgeInsets.symmetric(vertical: 8), children: [
          _drawerItem(Icons.dashboard_rounded, 'Dashboard', 0),
          _drawerItem(Icons.fact_check_rounded, 'Attendance', 1),
          _drawerItem(Icons.quiz_rounded, 'Exams', 2),
          _drawerItem(Icons.people_rounded, 'Students', 3),
          _drawerItem(Icons.chat_rounded, 'Chat', 4),
        ])),
        Divider(),
        ListTile(leading: Icon(Icons.logout_rounded, color: AppColors.danger), title: Text('Logout', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
          onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/role-selection', (_) => false)),
      ]))),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _index, onTap: (i) => setState(() => _index = i), items: [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.fact_check_rounded), label: 'Attendance'),
        BottomNavigationBarItem(icon: Icon(Icons.quiz_rounded), label: 'Exams'),
        BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Students'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: 'Chat'),
      ]),
    );
  }

  Widget _drawerItem(IconData icon, String label, int index) {
    return ListTile(leading: Icon(icon, color: AppColors.gray600, size: 22), title: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)), onTap: () { Navigator.pop(context); setState(() => _index = index); }, dense: true);
  }
}
