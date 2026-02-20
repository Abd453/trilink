import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminRegistration extends StatefulWidget {
  const AdminRegistration({super.key});
  @override
  State<AdminRegistration> createState() => _State();
}

class _State extends State<AdminRegistration> {
  String _type = 'Student';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Registration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      SizedBox(height: 4), Text('Register students, teachers, and parents', style: TextStyle(color: AppColors.textSecondary)),
      SizedBox(height: 16),
      Row(children: ['Student', 'Teacher', 'Parent'].map((t) => Padding(padding: EdgeInsets.only(right: 8),
        child: ChoiceChip(label: Text(t), selected: _type == t, onSelected: (_) => setState(() => _type = t), selectedColor: AppColors.primary500, labelStyle: TextStyle(color: _type == t ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.w600)))).toList()),
      SizedBox(height: 20),
      Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('New $_type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'First Name')),
          SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Last Name')),
          SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Email')),
          SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Phone')),
          if (_type == 'Student') ...[
            SizedBox(height: 12), DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Grade'), items: ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(), onChanged: (_) {}),
          ],
          if (_type == 'Teacher') ...[
            SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Subject')),
            SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Department')),
          ],
          if (_type == 'Parent') ...[
            SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Child\'s Name')),
            SizedBox(height: 12), DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Relationship'), items: ['Father', 'Mother', 'Guardian'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(), onChanged: (_) {}),
          ],
          SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$_type registered successfully ✓'), backgroundColor: AppColors.success));
          }, child: Text('Register $_type'))),
        ])),
    ]));
  }
}
