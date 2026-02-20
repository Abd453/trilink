import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TeacherAttendancePage extends StatefulWidget {
  const TeacherAttendancePage({super.key});
  @override
  State<TeacherAttendancePage> createState() => _State();
}

class _State extends State<TeacherAttendancePage> {
  String _class = 'Grade 11-A';
  final _students = [
    {'n': 'Abebe Kebede', 'id': 'STU-042', 's': 'present'},
    {'n': 'Kalkidan Assefa', 'id': 'STU-015', 's': 'present'},
    {'n': 'Yohannes Belay', 'id': 'STU-028', 's': 'present'},
    {'n': 'Meron Girma', 'id': 'STU-033', 's': 'absent'},
    {'n': 'Samuel Dereje', 'id': 'STU-019', 's': 'present'},
    {'n': 'Hana Tadesse', 'id': 'STU-051', 's': 'late'},
  ];
  late Map<String, String> _att;

  @override
  void initState() { super.initState(); _att = {for (var s in _students) s['id']!: s['s']!}; }

  void _toggle(String id) {
    final order = ['present', 'absent', 'late'];
    setState(() { _att[id] = order[(order.indexOf(_att[id]!) + 1) % 3]; });
  }

  Color _statusColor(String s) => s == 'present' ? AppColors.success : s == 'absent' ? AppColors.danger : AppColors.warning;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Class selector
      Container(height: 50, padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(scrollDirection: Axis.horizontal, children: ['Grade 11-A', 'Grade 11-B', 'Grade 12-A', 'Grade 12-B'].map((c) =>
          Padding(padding: EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(c), selected: _class == c, onSelected: (_) => setState(() => _class = c),
            selectedColor: AppColors.primary500, labelStyle: TextStyle(color: _class == c ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.w600)))
        ).toList())),
      SizedBox(height: 8),
      // Stats bar
      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Row(children: [
        _MiniStat('Present', _att.values.where((v) => v == 'present').length, AppColors.success),
        SizedBox(width: 16), _MiniStat('Absent', _att.values.where((v) => v == 'absent').length, AppColors.danger),
        SizedBox(width: 16), _MiniStat('Late', _att.values.where((v) => v == 'late').length, AppColors.warning),
      ])),
      SizedBox(height: 8),
      Expanded(child: ListView.builder(padding: EdgeInsets.all(16), itemCount: _students.length, itemBuilder: (_, i) {
        final s = _students[i]; final status = _att[s['id']!]!;
        return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            CircleAvatar(radius: 20, backgroundColor: AppColors.primary100, child: Text((s['n'] as String).split(' ').map((w) => w[0]).join(''), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary600))),
            SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['n']!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(s['id']!, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            GestureDetector(onTap: () => _toggle(s['id']!), child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(color: _statusColor(status).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(status[0].toUpperCase() + status.substring(1), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _statusColor(status))),
            )),
          ]));
      })),
      // Save button
      Padding(padding: EdgeInsets.all(16), child: SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Attendance saved ✓'), backgroundColor: AppColors.success));
      }, child: Text('Save Attendance')))),
    ]);
  }
}

class _MiniStat extends StatelessWidget {
  final String label; final int count; final Color color;
  const _MiniStat(this.label, this.count, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), SizedBox(width: 4), Text('$label: $count', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))]);
}
