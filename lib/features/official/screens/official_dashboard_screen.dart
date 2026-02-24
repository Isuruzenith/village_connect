import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'pending_requests_screen.dart';
import 'post_notice_screen.dart';

class OfficialDashboardScreen extends StatefulWidget {
  const OfficialDashboardScreen({super.key});

  @override
  State<OfficialDashboardScreen> createState() =>
      _OfficialDashboardScreenState();
}

class _OfficialDashboardScreenState extends State<OfficialDashboardScreen> {
  final List<_StatCard> _stats = [
    _StatCard('Pending', '12', AppColors.accentYellow, AppColors.warning),
    _StatCard('In Review', '5', AppColors.accentBlue, AppColors.info),
    _StatCard('Approved Today', '8', AppColors.accentGreen, AppColors.success),
    _StatCard('Rejected', '2', AppColors.accentRed, AppColors.error),
  ];

  final List<_PendingRequest> _recentRequests = [
    _PendingRequest(
      citizenName: 'Nadeeka Silva',
      documentType: 'Character Certificate',
      submittedDate: '22 Feb 2026',
      initials: 'NS',
    ),
    _PendingRequest(
      citizenName: 'Ruwan Jayasinghe',
      documentType: 'Residence Certificate',
      submittedDate: '21 Feb 2026',
      initials: 'RJ',
    ),
    _PendingRequest(
      citizenName: 'Malini Kumari',
      documentType: 'Income Certificate',
      submittedDate: '20 Feb 2026',
      initials: 'MK',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBarArea(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildStatsRow(),
                    const SizedBox(height: 28),
                    _buildQuickActions(),
                    const SizedBox(height: 28),
                    _buildRecentPendingRequests(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Officer',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Nimal Fernando',
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.textOnPrimary,
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
              color: AppColors.textOnPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'NF',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _stats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final stat = _stats[index];
          return Container(
            width: 140,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: stat.backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stat.count,
                  style: AppTextStyles.h1.copyWith(
                    color: stat.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                Text(
                  stat.label,
                  style: AppTextStyles.captionMedium.copyWith(
                    color: stat.textColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: AppTextStyles.h3),
        const SizedBox(height: 14),
        _buildActionCard(
          title: 'Review Requests',
          icon: Icons.rate_review_outlined,
          backgroundColor: AppColors.accentBlue,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PendingRequestsScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildActionCard(
          title: 'Post Notice',
          icon: Icons.campaign_outlined,
          backgroundColor: AppColors.accentYellow,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PostNoticeScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildActionCard(
          title: 'View Community',
          icon: Icons.people_outline,
          backgroundColor: AppColors.accentGreen,
          onTap: () {
            // Navigate to community view
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySemiBold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentPendingRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Pending Requests', style: AppTextStyles.h3),
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PendingRequestsScreen(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: AppTextStyles.captionMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(_recentRequests.length, (index) {
          final request = _recentRequests[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < _recentRequests.length - 1 ? 10 : 0,
            ),
            child: _buildRequestCard(request),
          );
        }),
      ],
    );
  }

  Widget _buildRequestCard(_PendingRequest request) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                request.initials,
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.citizenName,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  request.documentType,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 2),
                Text(
                  'Submitted: ${request.submittedDate}',
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PendingRequestsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                'Review',
                style: AppTextStyles.buttonSmall.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard {
  final String label;
  final String count;
  final Color backgroundColor;
  final Color textColor;

  const _StatCard(this.label, this.count, this.backgroundColor, this.textColor);
}

class _PendingRequest {
  final String citizenName;
  final String documentType;
  final String submittedDate;
  final String initials;

  const _PendingRequest({
    required this.citizenName,
    required this.documentType,
    required this.submittedDate,
    required this.initials,
  });
}
