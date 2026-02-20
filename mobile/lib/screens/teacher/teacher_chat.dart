import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TeacherChat extends StatelessWidget {
  const TeacherChat({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'n': 'Abebe Kebede', 'msg': 'Thank you for the feedback!', 't': '5m', 'i': 'AK', 'u': 1},
      {'n': 'Grade 11-A Group', 'msg': 'Reminder: Quiz tomorrow', 't': '1h', 'i': '11', 'u': 0},
      {'n': 'Admin Office', 'msg': 'Please submit grades by Friday', 't': '3h', 'i': 'AO', 'u': 2},
    ];

    return ListView.builder(padding: EdgeInsets.all(16), itemCount: chats.length, itemBuilder: (_, i) {
      final c = chats[i]; final unread = c['u'] as int;
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _ChatDetail(name: c['n'] as String, initials: c['i'] as String))),
        child: Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
          child: Row(children: [
            CircleAvatar(radius: 22, backgroundColor: AppColors.success.withValues(alpha: 0.15), child: Text(c['i'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.success))),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(c['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)), Text(c['t'] as String, style: TextStyle(fontSize: 11, color: AppColors.textSecondary))]),
              SizedBox(height: 2), Text(c['msg'] as String, style: TextStyle(fontSize: 13, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
            ])),
            if (unread > 0) ...[SizedBox(width: 8), Container(padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(10)), child: Text('$unread', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)))],
          ])));
    });
  }
}

class _ChatDetail extends StatelessWidget {
  final String name, initials;
  const _ChatDetail({required this.name, required this.initials});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(children: [
        Expanded(child: ListView(padding: EdgeInsets.all(16), children: [
          _bubble('Hello Mr. Solomon, I need help with the calculus homework.', false),
          _bubble('Sure Abebe, which problem are you stuck on?', true),
          _bubble('Problem 5, the integration by parts.', false),
        ])),
        Container(padding: EdgeInsets.fromLTRB(16, 8, 8, MediaQuery.of(context).padding.bottom + 8), decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.gray100))),
          child: Row(children: [
            Expanded(child: TextField(decoration: InputDecoration(hintText: 'Type a message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), filled: true, fillColor: AppColors.gray50, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
            SizedBox(width: 8), Container(decoration: BoxDecoration(color: AppColors.success, shape: BoxShape.circle), child: IconButton(icon: Icon(Icons.send_rounded, color: Colors.white, size: 20), onPressed: () {})),
          ])),
      ]),
    );
  }

  Widget _bubble(String text, bool isMe) {
    return Align(alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10), constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(color: isMe ? AppColors.success : AppColors.gray100, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(isMe ? 16 : 4), bottomRight: Radius.circular(isMe ? 4 : 16))),
        child: Text(text, style: TextStyle(fontSize: 14, color: isMe ? Colors.white : AppColors.textPrimary))));
  }
}
