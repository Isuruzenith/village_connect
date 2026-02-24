import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'request_detail_screen.dart';

class RequestTrackingScreen extends StatefulWidget {
  const RequestTrackingScreen({super.key});

  @override
  State<RequestTrackingScreen> createState() => _RequestTrackingScreenState();
}

class _RequestTrackingScreenState extends State<RequestTrackingScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Pending',
    'In Review',
    'Approved',
    'Rejected',
  ];

  final List<_RequestItem> _requests = [
    _RequestItem(
      trackingId: 'CC-2026-0142',
      documentType: 'Character Certificate',
      status: 'Approved',
      date: '22 Feb 2026',
      statusColor: AppColors.success,
      icon: Icons.verified_user_rounded,
    ),
    _RequestItem(
      trackingId: 'RC-2026-0088',
      documentType: 'Residence Certificate',
      status: 'In Review',
      date: '20 Feb 2026',
      statusColor: AppColors.info,
      icon: Icons.home_rounded,
    ),
    _RequestItem(
      trackingId: 'IC-2026-0055',
      documentType: 'Income Certificate',
      status: 'Pending',
      date: '18 Feb 2026',
      statusColor: AppColors.warning,
      icon: Icons.account_balance_wallet_rounded,
    ),
    _RequestItem(
      trackingId: 'CC-2026-0099',
      documentType: 'Character Certificate',
      status: 'Rejected',
      date: '10 Feb 2026',
      statusColor: AppColors.error,
      icon: Icons.verified_user_rounded,
    ),
    _RequestItem(
      trackingId: 'RC-2026-0067',
      documentType: 'Residence Certificate',
      status: 'Approved',
      date: '05 Feb 2026',
      statusColor: AppColors.success,
      icon: Icons.home_rounded,
    ),
  ];

  List<_RequestItem> get _filteredRequests {
    if (_selectedFilter == 'All') return _requests;
    return _requests.where((r) => r.status == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceGrey.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'Track Applications',
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border.withOpacity(0.3), height: 1),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Filter by Status',
              style: AppTextStyles.small.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildFilterChips(),
          const SizedBox(height: 16),
          Expanded(child: _buildRequestList()),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.card,
                borderRadius: BorderRadius.circular(24),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.shadowLight.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border.withOpacity(0.5),
                ),
              ),
              child: Text(
                filter,
                style: AppTextStyles.captionMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestList() {
    final filtered = _filteredRequests;
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceGrey.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 36,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No requests found',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing your filter criteria.',
              style: AppTextStyles.small.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        itemCount: filtered.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: _buildRequestCard(filtered[index])),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestCard(_RequestItem request) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RequestDetailScreen(
                trackingId: request.trackingId,
                documentType: request.documentType,
                status: request.status,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: request.statusColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(request.icon, color: request.statusColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.documentType,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          request.trackingId,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.circle,
                          size: 4,
                          color: AppColors.textMuted.withOpacity(0.5),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          request.date,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: request.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      request.status,
                      style: AppTextStyles.caption.copyWith(
                        color: request.statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestItem {
  final String trackingId;
  final String documentType;
  final String status;
  final String date;
  final Color statusColor;
  final IconData icon;

  const _RequestItem({
    required this.trackingId,
    required this.documentType,
    required this.status,
    required this.date,
    required this.statusColor,
    required this.icon,
  });
}
