import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'parent_dashboard.dart';
import 'parent_attendance.dart';
import 'parent_chat.dart';
import 'parent_student.dart';

class ParentShell extends StatefulWidget {
  const ParentShell({super.key});
  @override
  State<ParentShell> createState() => _State();
}

class _State extends State<ParentShell> {
  int _i = 0;
  final _pages = const [ParentDashboard(), ParentAttendancePage(), ParentStudentDetails(), ParentChatPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TriLink · Parent'), leading: Builder(builder: (c) => IconButton(icon: Icon(Icons.menu_rounded), onPressed: () => Scaffold.of(c).openDrawer()))),
      drawer: Drawer(child: SafeArea(child: Column(children: [
        Container(width: double.infinity, padding: EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.warning, Color(0xFFD97706)])),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(radius: 28, backgroundColor: Colors.white24, child: Text('KA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
            SizedBox(height: 10), Text('Mr. Kebede Alemu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
            Text('Parent of Abebe Kebede', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ])),
        Expanded(child: ListView(padding: EdgeInsets.symmetric(vertical: 8), children: [
          _di(Icons.dashboard_rounded, 'Dashboard', 0), _di(Icons.fact_check_rounded, 'Attendance', 1),
          _di(Icons.school_rounded, 'Student Details', 2), _di(Icons.chat_rounded, 'Chat', 3),
        ])),
        Divider(),
        ListTile(leading: Icon(Icons.logout_rounded, color: AppColors.danger), title: Text('Logout', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
          onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/role-selection', (_) => false)),
      ]))),
      body: _pages[_i],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _i, onTap: (i) => setState(() => _i = i), items: [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.fact_check_rounded), label: 'Attendance'),
        BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: 'Details'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: 'Chat'),
      ]),
    );
  }

  Widget _di(IconData icon, String label, int index) => ListTile(leading: Icon(icon, color: AppColors.gray600, size: 22), title: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)), onTap: () { Navigator.pop(context); setState(() => _i = index); }, dense: true);
}
