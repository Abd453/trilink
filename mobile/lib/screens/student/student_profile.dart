import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        // Profile card
        Container(
          width: double.infinity, padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.primary600, AppColors.primary800]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            CircleAvatar(radius: 40, backgroundColor: Colors.white.withValues(alpha: 0.2), child: Text('AK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24))),
            SizedBox(height: 12),
            Text('Abebe Kebede', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
            Text('Grade 11 — Section A', style: TextStyle(color: Colors.white70, fontSize: 14)),
            SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _ProfileStat('87%', 'Avg Score'),
              _ProfileStat('94%', 'Attendance'),
              _ProfileStat('#5', 'Rank'),
            ]),
          ]),
        ),
        SizedBox(height: 20),
        // Info card
        Container(
          width: double.infinity, padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Personal Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(height: 16),
            ...[
              {'l': 'Student ID', 'v': 'STU-042'},
              {'l': 'Email', 'v': 'abebe.k@school.edu'},
              {'l': 'Phone', 'v': '+251 911 234 567'},
              {'l': 'Date of Birth', 'v': 'March 15, 2010'},
              {'l': 'Parent', 'v': 'Mr. Kebede Alemu'},
              {'l': 'Address', 'v': 'Addis Ababa, Ethiopia'},
            ].map((i) => Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: 100, child: Text(i['l']!, style: TextStyle(fontSize: 13, color: AppColors.textSecondary))),
                Expanded(child: Text(i['v']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
              ]),
            )),
          ]),
        ),
      ]),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value, label;
  const _ProfileStat(this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
    ]);
  }
}
