import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TeacherStudents extends StatefulWidget {
  const TeacherStudents({super.key});
  @override
  State<TeacherStudents> createState() => _State();
}

class _State extends State<TeacherStudents> {
  int? _selected;
  final _students = [
    {'n': 'Abebe Kebede', 'g': '11-A', 'avg': 87, 'att': 94, 'rank': 5, 'subs': [{'s': 'Math', 'sc': 92}, {'s': 'Physics', 'sc': 88}, {'s': 'Chemistry', 'sc': 78}]},
    {'n': 'Kalkidan Assefa', 'g': '11-A', 'avg': 91, 'att': 97, 'rank': 2, 'subs': [{'s': 'Math', 'sc': 94}, {'s': 'Physics', 'sc': 90}, {'s': 'Chemistry', 'sc': 88}]},
    {'n': 'Meron Girma', 'g': '11-A', 'avg': 79, 'att': 85, 'rank': 12, 'subs': [{'s': 'Math', 'sc': 82}, {'s': 'Physics', 'sc': 76}, {'s': 'Chemistry', 'sc': 72}]},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(padding: EdgeInsets.all(16), itemCount: _students.length, itemBuilder: (_, i) {
      final s = _students[i]; final isOpen = _selected == i; final avg = s['avg'] as int;
      return GestureDetector(onTap: () => setState(() => _selected = isOpen ? null : i),
        child: AnimatedContainer(duration: Duration(milliseconds: 200), margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: isOpen ? AppColors.primary50 : Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isOpen ? AppColors.primary200 : AppColors.gray100)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(radius: 20, backgroundColor: AppColors.primary100, child: Text((s['n'] as String).split(' ').map((w) => w[0]).join(''), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary600))),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Grade ${s['g']} · Rank #${s['rank']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ])),
              Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: (avg >= 90 ? AppColors.success : avg >= 80 ? AppColors.primary500 : AppColors.warning).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text('$avg%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: avg >= 90 ? AppColors.success : avg >= 80 ? AppColors.primary500 : AppColors.warning))),
            ]),
            if (isOpen) ...[
              SizedBox(height: 12), Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _Stat2('Avg', '$avg%', AppColors.primary500),
                _Stat2('Att', '${s['att']}%', AppColors.success),
                _Stat2('Rank', '#${s['rank']}', AppColors.warning),
              ]),
              SizedBox(height: 12), Text('📊 Subject Scores', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              SizedBox(height: 8),
              ...(s['subs'] as List).map((sub) {
                final sc = sub['sc'] as int;
                return Padding(padding: EdgeInsets.only(bottom: 6), child: Row(children: [
                  SizedBox(width: 80, child: Text(sub['s'] as String, style: TextStyle(fontSize: 13))),
                  Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: sc / 100, backgroundColor: AppColors.gray100, color: sc >= 90 ? AppColors.success : sc >= 80 ? AppColors.primary500 : AppColors.warning, minHeight: 6))),
                  SizedBox(width: 10), Text('$sc%', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ]));
              }),
              SizedBox(height: 8),
              Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(10)),
                child: Row(children: [Icon(Icons.smart_toy_rounded, size: 18, color: AppColors.primary600), SizedBox(width: 8),
                  Expanded(child: Text(avg >= 85 ? 'Performing well. Keep challenging!' : 'Needs support in weaker subjects.', style: TextStyle(fontSize: 12, color: AppColors.primary700)))])),
            ],
          ])));
    });
  }
}

class _Stat2 extends StatelessWidget {
  final String label, value; final Color color;
  const _Stat2(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Column(children: [Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)), Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary))]);
}
