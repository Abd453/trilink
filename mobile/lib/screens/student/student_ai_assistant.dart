import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudentAIAssistant extends StatefulWidget {
  const StudentAIAssistant({super.key});
  @override
  State<StudentAIAssistant> createState() => _StudentAIAssistantState();
}

class _StudentAIAssistantState extends State<StudentAIAssistant> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'role': 'assistant',
      'content':
          'Hello! I\'m your TriLink AI Study Assistant. I can help you with:\n\n• Explaining difficult concepts\n• Solving practice problems\n• Preparing for exams\n• Summarizing lessons\n\nWhat would you like help with today?',
      'time': '10:00 AM',
    },
  ];

  final _quickPrompts = [
    {'label': 'Explain a concept', 'icon': Icons.lightbulb_outline_rounded},
    {'label': 'Help with homework', 'icon': Icons.edit_note_rounded},
    {'label': 'Practice problems', 'icon': Icons.quiz_rounded},
    {'label': 'Exam preparation', 'icon': Icons.school_rounded},
    {'label': 'Summarize a topic', 'icon': Icons.summarize_rounded},
    {'label': 'Study tips', 'icon': Icons.tips_and_updates_rounded},
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'role': 'user',
        'content': text.trim(),
        'time': TimeOfDay.now().format(context),
      });
      _isTyping = true;
    });
    _controller.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({
          'role': 'assistant',
          'content': _getAIResponse(text),
          'time': TimeOfDay.now().format(context),
        });
      });
      _scrollToBottom();
    });
  }

  String _getAIResponse(String query) {
    final q = query.toLowerCase();
    if (q.contains('derivative') || q.contains('calculus')) {
      return 'Great question! The derivative measures the rate of change of a function.\n\nThe basic rules are:\n• Power Rule: d/dx(xⁿ) = nxⁿ⁻¹\n• Sum Rule: d/dx(f+g) = f\' + g\'\n• Product Rule: d/dx(fg) = f\'g + fg\'\n\nWould you like me to work through a specific example?';
    } else if (q.contains('physics') || q.contains('newton')) {
      return 'Newton\'s Laws of Motion are fundamental to physics:\n\n1. An object at rest stays at rest unless acted upon by a force\n2. F = ma (Force equals mass times acceleration)\n3. Every action has an equal and opposite reaction\n\nWould you like to practice some problems?';
    } else if (q.contains('exam') || q.contains('study') || q.contains('prepare')) {
      return 'Here are some effective study strategies:\n\n1. Active Recall — Test yourself rather than re-reading\n2. Spaced Repetition — Review at increasing intervals\n3. Practice Problems — Work through past papers\n4. Teach Others — Explain concepts out loud\n5. Take Breaks — Use the Pomodoro technique (25 min study, 5 min break)\n\nWhich subject are you preparing for?';
    } else if (q.contains('help') || q.contains('homework')) {
      return 'I\'d be happy to help with your homework! Please share:\n\n• The subject and topic\n• The specific question or problem\n• Any work you\'ve already done\n\nI\'ll guide you step by step rather than just giving the answer, so you truly understand the concept.';
    } else {
      return 'That\'s a great question! Let me help you with that.\n\nCould you provide more details about:\n• Which subject this relates to?\n• What specific part you need help with?\n\nThe more context you give me, the better I can assist you!';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Messages list
        Expanded(
          child: _messages.length == 1
              ? _buildWelcomeView()
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == _messages.length && _isTyping) {
                      return _buildTypingIndicator();
                    }
                    return _buildMessage(_messages[i]);
                  },
                ),
        ),

        // Input bar
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.gray100)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.gray200),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask anything...',
                        hintStyle: TextStyle(color: AppColors.gray400, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                      onSubmitted: _sendMessage,
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.primary600, AppColors.primary800]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    onPressed: () => _sendMessage(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // AI icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary500, const Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: AppColors.primary500.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8)),
              ],
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            'TriLink AI Assistant',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.gray900),
          ),
          const SizedBox(height: 6),
          Text(
            'Your personal study companion',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          // Welcome message bubble
          _buildMessage(_messages[0]),

          const SizedBox(height: 24),
          // Quick prompts
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Quick Actions',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray600),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickPrompts.map((p) {
              return InkWell(
                onTap: () => _sendMessage(p['label'] as String),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.gray200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(p['icon'] as IconData, size: 16, color: AppColors.primary500),
                      const SizedBox(width: 6),
                      Text(
                        p['label'] as String,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gray700),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    final isUser = msg['role'] == 'user';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primary500, const Color(0xFF8B5CF6)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 14),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary500 : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                border: isUser ? null : Border.all(color: AppColors.gray100),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg['content'] as String,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                      color: isUser ? Colors.white : AppColors.gray800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg['time'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: isUser ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('AK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary600)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.primary500, const Color(0xFF8B5CF6)]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gray100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 600 + i * 200),
                  builder: (_, v, child) => Opacity(opacity: (v * 2 - 1).abs().clamp(0.3, 1.0), child: child),
                  child: Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary400,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
