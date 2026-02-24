import 'package:flutter/material.dart';
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

  final List<Map<String, String>> _requests = [
    {
      'type': 'Character Certificate',
      'trackingId': 'VC-2026-00142',
      'submittedDate': '22 Feb 2026',
      'status': 'In Review',
    },
    {
      'type': 'Residence Certificate',
      'trackingId': 'VC-2026-00138',
      'submittedDate': '18 Feb 2026',
      'status': 'Approved',
    },
    {
      'type': 'Income Certificate',
      'trackingId': 'VC-2026-00135',
      'submittedDate': '15 Feb 2026',
      'status': 'Pending',
    },
    {
      'type': 'Birth Certificate',
      'trackingId': 'VC-2026-00129',
      'submittedDate': '10 Feb 2026',
      'status': 'Rejected',
    },
    {
      'type': 'Land Ownership Certificate',
      'trackingId': 'VC-2026-00121',
      'submittedDate': '05 Feb 2026',
      'status': 'Approved',
    },
    {
      'type': 'Identity Verification',
      'trackingId': 'VC-2026-00118',
      'submittedDate': '01 Feb 2026',
      'status': 'Pending',
    },
  ];

  List<Map<String, String>> get _filteredRequests {
    if (_selectedFilter == 'All') return _requests;
    return _requests
        .where((r) => r['status'] == _selectedFilter)
        .toList();
  }

  Color _statusBgColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.accentYellow;
      case 'In Review':
        return AppColors.accentBlue;
      case 'Approved':
        return AppColors.accentGreen;
      case 'Rejected':
        return AppColors.accentRed;
      default:
        return AppColors.accentBlue;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.warning;
      case 'In Review':
        return AppColors.info;
      case 'Approved':
        return AppColors.success;
      case 'Rejected':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  Color _statusStripeColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.warning;
      case 'In Review':
        return AppColors.info;
      case 'Approved':
        return AppColors.success;
      case 'Rejected':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  IconData _documentIcon(String type) {
    switch (type) {
      case 'Character Certificate':
        return Icons.verified_user_outlined;
      case 'Residence Certificate':
        return Icons.home_outlined;
      case 'Income Certificate':
        return Icons.account_balance_wallet_outlined;
      case 'Birth Certificate':
        return Icons.child_care_outlined;
      case 'Identity Verification':
        return Icons.badge_outlined;
      case 'Land Ownership Certificate':
        return Icons.landscape_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'My Requests',
          style: AppTextStyles.h3.copyWith(fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: AppColors.textSecondary,
                size: 22,
              ),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: _filteredRequests.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    itemCount: _filteredRequests.length,
                    itemBuilder: (context, index) {
                      return _buildRequestCard(_filteredRequests[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            final filter = _filters[index];
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: AppTextStyles.captionMedium.copyWith(
                          color: isSelected
                              ? AppColors.textOnPrimary
                              : AppColors.textSecondary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRequestCard(Map<String, String> request) {
    final status = request['status']!;
    final stripeColor = _statusStripeColor(status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestDetailScreen(
                  trackingId: request['trackingId']!,
                  documentType: request['type']!,
                  status: request['status']!,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Row(
                children: [
                  // Left accent stripe
                  Container(
                    width: 5,
                    height: 100,
                    color: stripeColor,
                  ),
                  // Card content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 16, 16, 16),
                      child: Row(
                        children: [
                          // Document icon
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: _statusBgColor(status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _documentIcon(request['type']!),
                              color: _statusTextColor(status),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Text content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request['type']!,
                                  style: AppTextStyles.bodySemiBold.copyWith(
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.tag_rounded,
                                      size: 13,
                                      color: AppColors.textMuted,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      request['trackingId']!,
                                      style: AppTextStyles.small.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: 12,
                                      color: AppColors.textMuted,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      request['submittedDate']!,
                                      style: AppTextStyles.small.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: _statusBgColor(status),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              status,
                              style: AppTextStyles.small.copyWith(
                                color: _statusTextColor(status),
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.inbox_outlined,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No requests found',
              style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'There are no requests matching the selected filter.',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
