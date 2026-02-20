import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentSettings extends StatefulWidget {
  const StudentSettings({super.key});
  @override
  State<StudentSettings> createState() => _StudentSettingsState();
}

class _StudentSettingsState extends State<StudentSettings> {
  bool _emailNotif = true;
  bool _pushNotif = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        SizedBox(height: 20),
        _section('Notifications', [
          _toggle('Email Notifications', _emailNotif, (v) => setState(() => _emailNotif = v)),
          _toggle('Push Notifications', _pushNotif, (v) => setState(() => _pushNotif = v)),
        ]),
        SizedBox(height: 16),
        _section('Language', [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: AppColors.gray50, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.gray200)),
            child: DropdownButton<String>(
              value: _language, isExpanded: true, underline: SizedBox(),
              items: ['English', 'Amharic (አማርኛ)'].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
              onChanged: (v) => setState(() => _language = v!),
            ),
          ),
        ]),
        SizedBox(height: 32),
        Container(
          width: double.infinity, padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.dangerLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.danger.withValues(alpha: 0.3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Danger Zone', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.danger)),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger, side: BorderSide(color: AppColors.danger)),
              child: Text('Delete Account'),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        SizedBox(height: 12),
        ...children,
      ]),
    );
  }

  Widget _toggle(String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: TextStyle(fontSize: 14)),
        Switch(value: value, onChanged: onChanged, activeTrackColor: AppColors.primary500),
      ]),
    );
  }
}
