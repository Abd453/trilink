import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentChat extends StatefulWidget {
  const StudentChat({super.key});
  @override
  State<StudentChat> createState() => _StudentChatState();
}

class _StudentChatState extends State<StudentChat> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _inbox = [
    {'name': 'Mr. Solomon', 'msg': 'Great work on the quiz!', 'time': '5m', 'initials': 'MS', 'unread': 2},
    {'name': 'Ms. Sara', 'msg': 'Lab report corrections sent', 'time': '1h', 'initials': 'MS', 'unread': 0},
    {'name': 'Admin Office', 'msg': 'Conference reminder', 'time': '3h', 'initials': 'AO', 'unread': 1},
  ];

  final _groups = [
    {'name': 'Grade 11-A', 'msg': 'Study session at 4PM', 'time': '30m', 'initials': '11', 'unread': 5},
    {'name': 'Science Club', 'msg': 'Meeting tomorrow', 'time': '2h', 'initials': 'SC', 'unread': 0},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary500,
            unselectedLabelColor: AppColors.gray400,
            indicatorColor: AppColors.primary500,
            tabs: [Tab(text: 'Inbox'), Tab(text: 'Groups')],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildList(_inbox),
              _buildList(_groups),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<Map<String, dynamic>> items) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (_, i) {
        final item = items[i];
        return GestureDetector(
          onTap: () => _openChat(context, item['name'] as String, item['initials'] as String),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray100)),
            child: Row(children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary100,
                child: Text(item['initials'] as String, style: TextStyle(color: AppColors.primary600, fontWeight: FontWeight.w700, fontSize: 13)),
              ),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(item['name'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(item['time'] as String, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                ]),
                SizedBox(height: 2),
                Text(item['msg'] as String, style: TextStyle(fontSize: 13, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
              ])),
              if ((item['unread'] as int) > 0) ...[
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.primary500, borderRadius: BorderRadius.circular(10)),
                  child: Text('${item['unread']}', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ]),
          ),
        );
      },
    );
  }

  void _openChat(BuildContext context, String name, String initials) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => _ChatDetailScreen(name: name, initials: initials)));
  }
}

class _ChatDetailScreen extends StatelessWidget {
  final String name, initials;
  const _ChatDetailScreen({required this.name, required this.initials});

  @override
  Widget build(BuildContext context) {
    final messages = [
      {'from': 'other', 'text': 'Hi Abebe! How are you finding the homework?'},
      {'from': 'me', 'text': 'Hello! It\'s going well, but I\'m stuck on problem 5.'},
      {'from': 'other', 'text': 'No worries, let me explain the approach...'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(radius: 16, backgroundColor: AppColors.primary100, child: Text(initials, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary600))),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            Text('Online', style: TextStyle(fontSize: 11, color: AppColors.success)),
          ]),
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final m = messages[i];
                final isMe = m['from'] == 'me';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primary500 : AppColors.gray100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16), topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                    ),
                    child: Text(m['text']!, style: TextStyle(fontSize: 14, color: isMe ? Colors.white : AppColors.textPrimary)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 8, 8, MediaQuery.of(context).padding.bottom + 8),
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.gray100))),
            child: Row(children: [
              Expanded(
                child: TextField(decoration: InputDecoration(hintText: 'Type a message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), filled: true, fillColor: AppColors.gray50, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10))),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(color: AppColors.primary500, shape: BoxShape.circle),
                child: IconButton(icon: Icon(Icons.send_rounded, color: Colors.white, size: 20), onPressed: () {}),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
