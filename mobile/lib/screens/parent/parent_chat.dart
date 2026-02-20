import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ParentChatPage extends StatelessWidget {
  const ParentChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'n': 'Mr. Solomon', 's': 'Mathematics', 'msg': 'Abebe is doing well in class', 't': '1h', 'u': 1},
      {'n': 'Ms. Sara', 's': 'Physics', 'msg': 'Lab report corrections needed', 't': '3h', 'u': 0},
      {'n': 'Admin Office', 's': 'School', 'msg': 'Conference reminder for Feb 28', 't': '1d', 'u': 0},
    ];

    return Column(children: [
      // Chat viewer toggle
      Container(padding: EdgeInsets.all(12), margin: EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.infoLight, borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Icon(Icons.visibility_rounded, color: AppColors.info, size: 20), SizedBox(width: 10),
          Expanded(child: Text('You can also view student-teacher chats', style: TextStyle(fontSize: 12, color: AppColors.info))),
        ])),
      Expanded(child: ListView.builder(padding: EdgeInsets.symmetric(horizontal: 16), itemCount: chats.length, itemBuilder: (_, i) {
        final c = chats[i]; final unread = c['u'] as int;
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _ChatDetail(name: c['n'] as String, subject: c['s'] as String))),
          child: Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
            child: Row(children: [
              CircleAvatar(radius: 22, backgroundColor: AppColors.warningLight, child: Icon(Icons.person_rounded, color: AppColors.warning, size: 20)),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(c['n'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)), Text(c['t'] as String, style: TextStyle(fontSize: 11, color: AppColors.textSecondary))]),
                Text(c['s'] as String, style: TextStyle(fontSize: 11, color: AppColors.primary500)),
                SizedBox(height: 2), Text(c['msg'] as String, style: TextStyle(fontSize: 13, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
              ])),
              if (unread > 0) Container(padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: AppColors.warning, borderRadius: BorderRadius.circular(10)), child: Text('$unread', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
            ])));
      })),
    ]);
  }
}

class _ChatDetail extends StatelessWidget {
  final String name, subject;
  const _ChatDetail({required this.name, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontSize: 15)), Text(subject, style: TextStyle(fontSize: 12, color: AppColors.textSecondary))])),
      body: Column(children: [
        Expanded(child: ListView(padding: EdgeInsets.all(16), children: [
          _buildBubble('Hello Mr. Solomon, how is Abebe doing?', true), _buildBubble('He\'s doing great! His math scores have improved significantly.', false), _buildBubble('That\'s wonderful to hear. Any areas to work on?', true),
        ])),
        Container(padding: EdgeInsets.fromLTRB(16, 8, 8, MediaQuery.of(context).padding.bottom + 8), decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.gray100))),
          child: Row(children: [
            Expanded(child: TextField(decoration: InputDecoration(hintText: 'Type a message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), filled: true, fillColor: AppColors.gray50, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
            SizedBox(width: 8), Container(decoration: BoxDecoration(color: AppColors.warning, shape: BoxShape.circle), child: IconButton(icon: Icon(Icons.send_rounded, color: Colors.white, size: 20), onPressed: () {})),
          ])),
      ]),
    );
  }

  Widget _buildBubble(String text, bool isMe) => Align(alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10), constraints: BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(color: isMe ? AppColors.warning : AppColors.gray100, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(isMe ? 16 : 4), bottomRight: Radius.circular(isMe ? 4 : 16))),
      child: Text(text, style: TextStyle(fontSize: 14, color: isMe ? Colors.white : AppColors.textPrimary))));
}
