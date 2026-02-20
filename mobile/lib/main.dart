import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'providers/auth_provider.dart';
import 'screens/role_selection_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/student/student_shell.dart';
import 'screens/parent/parent_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const TriLinkaApp(),
    ),
  );
}

class TriLinkaApp extends StatelessWidget {
  const TriLinkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriLink',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const RoleSelectionScreen(),
      routes: {
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/login/student': (context) => const LoginScreen(role: 'Student'),
        '/login/parent': (context) => const LoginScreen(role: 'Parent'),
        '/student': (context) => const StudentShell(),
        '/parent': (context) => const ParentShell(),
      },
    );
  }
}
