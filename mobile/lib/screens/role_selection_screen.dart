import 'package:flutter/material.dart';
import '../core/theme.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary600, AppColors.primary800],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 60),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '△',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'TriLink',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'School Management System',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Select Your Role',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Choose your portal to continue',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.95,
                            children: [
                              _RoleCard(
                                icon: Icons.school_rounded,
                                label: 'Student',
                                subtitle: 'Access your portal',
                                color: AppColors.primary500,
                                bgColor: AppColors.primary50,
                                onTap: () => Navigator.pushNamed(context, '/login/student'),
                              ),
                              _RoleCard(
                                icon: Icons.menu_book_rounded,
                                label: 'Teacher',
                                subtitle: 'Manage classes',
                                color: AppColors.success,
                                bgColor: AppColors.successLight,
                                onTap: () => Navigator.pushNamed(context, '/login/teacher'),
                              ),
                              _RoleCard(
                                icon: Icons.admin_panel_settings_rounded,
                                label: 'Admin',
                                subtitle: 'System control',
                                color: AppColors.purple,
                                bgColor: AppColors.purpleLight,
                                onTap: () => Navigator.pushNamed(context, '/login/admin'),
                              ),
                              _RoleCard(
                                icon: Icons.family_restroom_rounded,
                                label: 'Parent',
                                subtitle: 'Track progress',
                                color: AppColors.warning,
                                bgColor: AppColors.warningLight,
                                onTap: () => Navigator.pushNamed(context, '/login/parent'),
                              ),
                            ],
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

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gray100),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(height: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
