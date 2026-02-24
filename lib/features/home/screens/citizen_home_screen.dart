import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/documents/screens/document_request_screen.dart';
import '../../../features/notices/screens/notice_board_screen.dart';
import '../../../features/profile/screens/profile_screen.dart';

class CitizenHomeScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateToTab;

  const CitizenHomeScreen({
    super.key,
    this.onNavigateToTab,
  });

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  bool _isOffline = false;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- App Bar / Header Area --
              _buildHeader(),

              // -- Offline Banner --
              if (_isOffline) _buildOfflineBanner(),

              const SizedBox(height: 24),

              // -- Quick Actions Section --
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Quick Actions',
                  style: AppTextStyles.h3,
                ),
              ),
              const SizedBox(height: 12),

              // -- Quick Action Cards --
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildQuickActionCard(
                      title: 'Apply for Document',
                      subtitle: 'Request certificates online',
                      icon: Icons.article_outlined,
                      backgroundColor: AppColors.accentBlue,
                      iconColor: AppColors.info,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DocumentRequestScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActionCard(
                      title: 'Track Application',
                      subtitle: 'Check your request status',
                      icon: Icons.track_changes_rounded,
                      backgroundColor: AppColors.accentGreen,
                      iconColor: AppColors.success,
                      onTap: () {
                        widget.onNavigateToTab?.call(1);
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActionCard(
                      title: 'Report a Problem',
                      subtitle: 'Report community issues',
                      icon: Icons.report_problem_outlined,
                      backgroundColor: AppColors.accentRed,
                      iconColor: AppColors.error,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Coming in Phase 2'),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActionCard(
                      title: 'Announcements',
                      subtitle: 'Official notices & updates',
                      icon: Icons.campaign_outlined,
                      backgroundColor: AppColors.accentYellow,
                      iconColor: AppColors.warning,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NoticeBoardScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActionCard(
                      title: 'My Profile',
                      subtitle: 'View & edit your details',
                      icon: Icons.person_outline_rounded,
                      backgroundColor: AppColors.accentPurple,
                      iconColor: const Color(0xFF6D28D9),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // -- Recent Activity Section --
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activity',
                      style: AppTextStyles.h3,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onNavigateToTab?.call(1);
                      },
                      child: Text(
                        'See All',
                        style: AppTextStyles.captionMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // -- Recent Request Card --
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildRecentRequestCard(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header with greeting, user name, and avatar
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Kamal Perera',
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                'KP',
                style: TextStyle(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Offline banner
  // ---------------------------------------------------------------------------
  Widget _buildOfflineBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.offlineBanner,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.wifi_off_rounded,
            color: AppColors.offlineBannerText,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'You are offline. Some features may be limited.',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.offlineBannerText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Quick Action Card
  // ---------------------------------------------------------------------------
  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Title & subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodySemiBold,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Arrow
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: iconColor.withValues(alpha: 0.5),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recent Request Card
  // ---------------------------------------------------------------------------
  Widget _buildRecentRequestCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppColors.info,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Character Certificate',
                  style: AppTextStyles.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Feb 20, 2026',
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'In Review',
              style: AppTextStyles.small.copyWith(
                color: AppColors.info,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
