import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'admin_dashboard.dart';
import 'admin_registration.dart';
import 'admin_students.dart';
import 'admin_teachers.dart';
import 'admin_feedback.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});
  @override
  State<AdminShell> createState() => _State();
}

class _State extends State<AdminShell> {
  int _i = 0;
  final _pages = const [AdminDashboard(), AdminRegistration(), AdminStudentsList(), AdminTeachersList(), AdminFeedbackPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TriLink · Admin'), leading: Builder(builder: (c) => IconButton(icon: Icon(Icons.menu_rounded), onPressed: () => Scaffold.of(c).openDrawer()))),
      drawer: Drawer(child: SafeArea(child: Column(children: [
        Container(width: double.infinity, padding: EdgeInsets.all(24), decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.purple, Color(0xFF6D28D9)])),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(radius: 28, backgroundColor: Colors.white24, child: Text('AU', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
            SizedBox(height: 10), Text('Admin User', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
            Text('System Administrator', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ])),
        Expanded(child: ListView(padding: EdgeInsets.symmetric(vertical: 8), children: [
          _di(Icons.dashboard_rounded, 'Dashboard', 0), _di(Icons.person_add_rounded, 'Registration', 1),
          _di(Icons.school_rounded, 'Students', 2), _di(Icons.menu_book_rounded, 'Teachers', 3),
          _di(Icons.rate_review_rounded, 'Feedback', 4),
        ])),
        Divider(),
        ListTile(leading: Icon(Icons.logout_rounded, color: AppColors.danger), title: Text('Logout', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
          onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/role-selection', (_) => false)),
      ]))),
      body: _pages[_i],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _i, onTap: (i) => setState(() => _i = i), items: [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person_add_rounded), label: 'Register'),
        BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: 'Students'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Teachers'),
        BottomNavigationBarItem(icon: Icon(Icons.rate_review_rounded), label: 'Feedback'),
      ]),
    );
  }

  Widget _di(IconData icon, String label, int index) => ListTile(leading: Icon(icon, color: AppColors.gray600, size: 22), title: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)), onTap: () { Navigator.pop(context); setState(() => _i = index); }, dense: true);
}
