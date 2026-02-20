import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentFeedback extends StatefulWidget {
  const StudentFeedback({super.key});
  @override
  State<StudentFeedback> createState() => _StudentFeedbackState();
}

class _StudentFeedbackState extends State<StudentFeedback> {
  String? _selectedSubject;
  int _rating = 0;
  final _commentController = TextEditingController();
  final _submitted = <String>{};

  final _subjects = ['Mathematics', 'Physics', 'Chemistry', 'English', 'Biology'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Anonymous Feedback', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Your identity is not shared with teachers', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.infoLight, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Icon(Icons.privacy_tip_rounded, color: AppColors.info, size: 20),
              SizedBox(width: 10),
              Expanded(child: Text('All feedback is completely anonymous', style: TextStyle(fontSize: 12, color: AppColors.info))),
            ]),
          ),
          SizedBox(height: 24),

          Text('Select Subject', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _subjects.map((s) {
              final isSelected = _selectedSubject == s;
              final done = _submitted.contains(s);
              return GestureDetector(
                onTap: done ? null : () => setState(() { _selectedSubject = s; _rating = 0; _commentController.clear(); }),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: done ? AppColors.successLight : isSelected ? AppColors.primary500 : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: done ? AppColors.success : isSelected ? AppColors.primary500 : AppColors.gray200),
                  ),
                  child: Text(s, style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600,
                    color: done ? AppColors.success : isSelected ? Colors.white : AppColors.textPrimary,
                  )),
                ),
              );
            }).toList(),
          ),

          if (_selectedSubject != null && !_submitted.contains(_selectedSubject)) ...[
            SizedBox(height: 24),
            Text('Rate $_selectedSubject', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            Row(
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    i < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: AppColors.warning, size: 36,
                  ),
                ),
              )),
            ),
            SizedBox(height: 20),
            Text('Comments (optional)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(hintText: 'Share your thoughts...'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 48,
              child: ElevatedButton(
                onPressed: _rating > 0 ? () {
                  setState(() { _submitted.add(_selectedSubject!); _selectedSubject = null; });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted anonymously ✓'), backgroundColor: AppColors.success));
                } : null,
                child: Text('Submit Feedback'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
