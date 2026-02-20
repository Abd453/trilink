import 'package:flutter/material.dart';
import '../../core/theme.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Color get _roleColor {
    switch (widget.role) {
      case 'Teacher': return AppColors.success;
      case 'Admin': return AppColors.purple;
      case 'Parent': return AppColors.warning;
      default: return AppColors.primary500;
    }
  }

  IconData get _roleIcon {
    switch (widget.role) {
      case 'Teacher': return Icons.menu_book_rounded;
      case 'Admin': return Icons.admin_panel_settings_rounded;
      case 'Parent': return Icons.family_restroom_rounded;
      default: return Icons.school_rounded;
    }
  }

  String get _tagline {
    switch (widget.role) {
      case 'Teacher': return 'Shape the future, one class at a time';
      case 'Admin': return 'Manage and oversee the entire system';
      case 'Parent': return 'Stay connected with your child\'s journey';
      default: return 'Learn, grow, and achieve your best';
    }
  }

  void _handleLogin() {
    final route = '/${widget.role.toLowerCase()}';
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_roleColor, _roleColor.withValues(alpha: 0.8)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button + header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Logo & title
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 8))],
                ),
                child: Icon(_roleIcon, size: 34, color: _roleColor),
              ),
              SizedBox(height: 16),
              Text(
                '${widget.role} Portal',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              SizedBox(height: 6),
              Text(
                _tagline,
                style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.85)),
              ),
              SizedBox(height: 40),
              // Form
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text('Welcome Back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                        SizedBox(height: 6),
                        Text('Sign in to continue', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                        SizedBox(height: 32),
                        Text('Email or ID', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.gray600)),
                        SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email or school ID',
                            prefixIcon: Icon(Icons.email_outlined, color: AppColors.gray400, size: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.gray600)),
                        SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.gray400, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.gray400, size: 20),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Forgot Password?', style: TextStyle(color: _roleColor, fontWeight: FontWeight.w600, fontSize: 13)),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _roleColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
