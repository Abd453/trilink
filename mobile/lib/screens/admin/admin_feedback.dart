import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminFeedbackPage extends StatelessWidget {
  const AdminFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feedback = [
      {'s': 'Mathematics', 't': 'Mr. Solomon', 'r': 4.7, 'c': 42, 'comments': [{'t': 'Excellent teaching!', 'r': 5}, {'t': 'Sometimes too fast', 'r': 3}]},
      {'s': 'Physics', 't': 'Ms. Sara', 'r': 4.3, 'c': 38, 'comments': [{'t': 'Very engaging classes', 'r': 5}, {'t': 'Need more practice', 'r': 4}]},
      {'s': 'Chemistry', 't': 'Mr. Tadesse', 'r': 3.8, 'c': 35, 'comments': [{'t': 'Lab sessions are great', 'r': 4}, {'t': 'Hard to follow', 'r': 3}]},
    ];

    return ListView.builder(padding: EdgeInsets.all(16), itemCount: feedback.length, itemBuilder: (_, i) {
      final f = feedback[i]; final rating = f['r'] as double;
      return Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(f['s'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              Text('${f['t']} · ${f['c']} responses', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ]),
            Row(children: [
              Text('$rating', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: rating >= 4.5 ? AppColors.success : rating >= 3.5 ? AppColors.warning : AppColors.danger)),
              SizedBox(width: 4), Icon(Icons.star_rounded, color: AppColors.warning, size: 22),
            ]),
          ]),
          SizedBox(height: 12),
          ...(f['comments'] as List).map((c) => Container(
            margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.gray50, borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(child: Text('"${c['t']}"', style: TextStyle(fontSize: 13, color: AppColors.gray700, fontStyle: FontStyle.italic))),
              Row(children: List.generate(c['r'] as int, (_) => Icon(Icons.star_rounded, color: AppColors.warning, size: 14))),
            ]))),
        ]));
    });
  }
}
