import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/home/screens/citizen_home_screen.dart';
import '../../../features/documents/screens/request_tracking_screen.dart';
import '../../../features/notifications/screens/notifications_screen.dart';
import '../../../features/help/screens/help_screen.dart';
import '../../../features/chatbot/screens/chatbot_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      CitizenHomeScreen(
        onNavigateToTab: _onTabSelected,
      ),
      const RequestTrackingScreen(),
      const NotificationsScreen(),
      const HelpScreen(),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openChatbot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatbotScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: _buildChatbotFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildChatbotFAB() {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: _openChatbot,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.smart_toy_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: BottomAppBar(
          height: 72,
          color: AppColors.card,
          elevation: 0,
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              // Left side tabs
              _buildNavItem(0, Icons.home_rounded, 'Home'),
              _buildNavItem(1, Icons.description_outlined, 'Requests'),
              // Center space for FAB
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 28),
                    Text(
                      'AI Bot',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
              // Right side tabs
              _buildNavItem(2, Icons.notifications_outlined, 'Notices'),
              _buildNavItem(3, Icons.help_outline_rounded, 'Help'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTabSelected(index),
          child: SizedBox(
            height: 64,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: isSelected ? AppColors.primary : AppColors.textMuted,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color:
                        isSelected ? AppColors.primary : AppColors.textMuted,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
