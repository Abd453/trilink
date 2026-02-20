import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome
          Row(children: [Icon(Icons.wb_sunny_rounded, color: AppColors.warning, size: 22), SizedBox(width: 8), Text('Good morning, Abebe!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800))]),
          SizedBox(height: 4),
          Text('Here\'s your academic overview', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          SizedBox(height: 20),

          // Stats
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _StatCard(icon: Icons.quiz_rounded, label: 'Tests Taken', value: '24', color: AppColors.primary500, bgColor: AppColors.primary50),
              _StatCard(icon: Icons.trending_up_rounded, label: 'Avg. Score', value: '87%', color: AppColors.success, bgColor: AppColors.successLight),
              _StatCard(icon: Icons.fact_check_rounded, label: 'Attendance', value: '94%', color: AppColors.purple, bgColor: AppColors.purpleLight),
              _StatCard(icon: Icons.emoji_events_rounded, label: 'Rank', value: '#5', color: AppColors.warning, bgColor: AppColors.warningLight),
            ],
          ),
          SizedBox(height: 24),

          // Announcements
          _SectionTitle(title: 'Recent Announcements'),
          SizedBox(height: 12),
          ...[
            _AnnouncementItem(title: 'Midterm Exam Schedule Released', subtitle: 'Feb 25 - Mar 5', icon: Icons.event_note_rounded, color: AppColors.danger),
            _AnnouncementItem(title: 'Science Fair Registration Open', subtitle: 'Deadline: Feb 28', icon: Icons.science_rounded, color: AppColors.primary500),
          ],
          SizedBox(height: 24),

          // Subject Performance
          _SectionTitle(title: 'Subject Performance'),
          SizedBox(height: 12),
          ...[
            _SubjectRow(name: 'Mathematics', score: 92, color: AppColors.primary500),
            _SubjectRow(name: 'Physics', score: 88, color: AppColors.success),
            _SubjectRow(name: 'Chemistry', score: 78, color: AppColors.warning),
            _SubjectRow(name: 'English', score: 85, color: AppColors.purple),
            _SubjectRow(name: 'Biology', score: 91, color: AppColors.info),
          ],
          SizedBox(height: 24),

          // Upcoming Events
          _SectionTitle(title: 'Upcoming Events'),
          SizedBox(height: 12),
          ...[
            _EventItem(title: 'Math Quiz', date: 'Feb 22', time: '9:00 AM', type: 'exam'),
            _EventItem(title: 'Physics Lab Report Due', date: 'Feb 23', time: '3:00 PM', type: 'assignment'),
            _EventItem(title: 'Parent-Teacher Conference', date: 'Feb 28', time: '2:00 PM', type: 'event'),
          ],
          SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700));
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color, bgColor;
  const _StatCard({required this.icon, required this.label, required this.value, required this.color, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          Spacer(),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _AnnouncementItem extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  const _AnnouncementItem({required this.title, required this.subtitle, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Row(children: [
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 2),
          Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        Icon(Icons.chevron_right_rounded, color: AppColors.gray300),
      ]),
    );
  }
}

class _SubjectRow extends StatelessWidget {
  final String name;
  final int score;
  final Color color;
  const _SubjectRow({required this.name, required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Container(width: 4, height: 32, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: score / 100, backgroundColor: AppColors.gray100, color: color, minHeight: 6),
          ),
        ])),
        SizedBox(width: 12),
        Text('$score%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
      ]),
    );
  }
}

class _EventItem extends StatelessWidget {
  final String title, date, time, type;
  const _EventItem({required this.title, required this.date, required this.time, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = type == 'exam' ? AppColors.danger : type == 'assignment' ? AppColors.warning : AppColors.primary500;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(date.split(' ')[1], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
            Text(date.split(' ')[0], style: TextStyle(fontSize: 10, color: color)),
          ]),
        ),
        SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 2),
          Text(time, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
      ]),
    );
  }
}
