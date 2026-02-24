import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../notices/screens/notice_board_screen.dart';
import '../../help/screens/help_screen.dart';
import '../../chatbot/screens/chatbot_screen.dart';
import 'citizen_home_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CitizenHomeScreen(),
    NotificationsScreen(),
    SizedBox(), // Placeholder for FAB
    NoticeBoardScreen(),
    HelpScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) return; // Center FAB slot — skip
    setState(() => _currentIndex = index);
  }

  void _openChatbot() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const ChatbotScreen(),
        transitionsBuilder: (_, animation, _, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, 0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex > 2 ? _currentIndex : _currentIndex,
        children: _screens,
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFab() {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _openChatbot,
          borderRadius: BorderRadius.circular(18),
          child: const Icon(
            Icons.smart_toy_outlined,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      height: 68,
      color: AppColors.card,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'Home'),
            _buildNavItem(
              1,
              Icons.notifications_none_rounded,
              Icons.notifications_rounded,
              'Alerts',
            ),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(
              3,
              Icons.article_outlined,
              Icons.article_rounded,
              'Notices',
            ),
            _buildNavItem(
              4,
              Icons.help_outline_rounded,
              Icons.help_rounded,
              'Help',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    final isActive = _currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTabTapped(index),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryLight
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isActive ? activeIcon : icon,
                    color: isActive ? AppColors.primary : AppColors.textMuted,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: AppTextStyles.small.copyWith(
                    color: isActive ? AppColors.primary : AppColors.textMuted,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 11,
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
