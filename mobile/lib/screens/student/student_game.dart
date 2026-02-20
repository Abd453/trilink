import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentGame extends StatefulWidget {
  const StudentGame({super.key});
  @override
  State<StudentGame> createState() => _StudentGameState();
}

class _StudentGameState extends State<StudentGame> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() { super.initState(); _tabController = TabController(length: 3, vsync: this); }
  @override
  void dispose() { _tabController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity, padding: EdgeInsets.all(20), margin: EdgeInsets.all(16),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary600, AppColors.primary800]), borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(children: [Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 28), SizedBox(height: 4), Text('1,250', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)), Text('Points', style: TextStyle(fontSize: 12, color: Colors.white70))]),
          Container(width: 1, height: 50, color: Colors.white24),
          Column(children: [Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 28), SizedBox(height: 4), Text('7 Days', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)), Text('Streak', style: TextStyle(fontSize: 12, color: Colors.white70))]),
        ]),
      ),
      Container(color: Colors.white, child: TabBar(controller: _tabController, labelColor: AppColors.primary500, unselectedLabelColor: AppColors.gray400, indicatorColor: AppColors.primary500, tabs: [Tab(text: 'Leaderboard'), Tab(text: 'Quizzes'), Tab(text: 'Badges')])),
      Expanded(child: TabBarView(controller: _tabController, children: [_leaderboard(), _quizzes(), _badges()])),
    ]);
  }

  Widget _leaderboard() {
    final users = [{'n': 'Kalkidan A.', 'p': 1520}, {'n': 'Samuel D.', 'p': 1480}, {'n': 'Hana T.', 'p': 1390}, {'n': 'Dawit M.', 'p': 1300}, {'n': 'Abebe K. (You)', 'p': 1250}];
    return ListView.builder(padding: EdgeInsets.all(16), itemCount: users.length, itemBuilder: (_, i) {
      final u = users[i]; final isYou = (u['n'] as String).contains('You');
      return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: isYou ? AppColors.primary50 : Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: isYou ? AppColors.primary200 : AppColors.gray100)),
        child: Row(children: [
          Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.gray100, shape: BoxShape.circle), child: Center(child: Text('${i + 1}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)))),
          SizedBox(width: 12), Expanded(child: Text(u['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          Text('${u['p']} pts', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary600)),
        ]));
    });
  }

  Widget _quizzes() {
    final quizzes = [{'s': 'Mathematics', 'c': 'Ch.7 Calculus', 'd': true}, {'s': 'Mathematics', 'c': 'Ch.8 Integration', 'd': false}, {'s': 'Physics', 'c': 'Ch.5 Mechanics', 'd': true}, {'s': 'Physics', 'c': 'Ch.6 Waves', 'd': false}];
    return ListView.builder(padding: EdgeInsets.all(16), itemCount: quizzes.length, itemBuilder: (_, i) {
      final q = quizzes[i]; final done = q['d'] as bool;
      return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
        child: Row(children: [
          Icon(done ? Icons.check_circle_rounded : Icons.play_circle_rounded, color: done ? AppColors.success : AppColors.primary500, size: 28),
          SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(q['c'] as String, style: TextStyle(fontWeight: FontWeight.w600)), Text(q['s'] as String, style: TextStyle(fontSize: 12, color: AppColors.textSecondary))])),
          if (!done) Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: AppColors.primary500, borderRadius: BorderRadius.circular(8)), child: Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12))),
        ]));
    });
  }

  Widget _badges() {
    final badges = [{'n': 'First Quiz', 'i': Icons.gps_fixed_rounded, 'e': true}, {'n': '7-Day Streak', 'i': Icons.local_fire_department_rounded, 'e': true}, {'n': 'Perfect Score', 'i': Icons.star_rounded, 'e': true}, {'n': 'Quiz Master', 'i': Icons.psychology_rounded, 'e': false}, {'n': 'Top 3', 'i': Icons.military_tech_rounded, 'e': false}];
    return GridView.builder(padding: EdgeInsets.all(16), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12), itemCount: badges.length, itemBuilder: (_, i) {
      final b = badges[i]; final earned = b['e'] as bool;
      return Container(decoration: BoxDecoration(color: earned ? Colors.white : AppColors.gray50, borderRadius: BorderRadius.circular(14), border: Border.all(color: earned ? AppColors.primary200 : AppColors.gray200)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(b['i'] as IconData, size: 28, color: earned ? AppColors.primary500 : AppColors.gray300), SizedBox(height: 6), Text(b['n'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: earned ? AppColors.textPrimary : AppColors.gray400), textAlign: TextAlign.center)]));
    });
  }
}
