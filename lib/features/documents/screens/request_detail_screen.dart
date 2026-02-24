import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class RequestDetailScreen extends StatelessWidget {
  final String trackingId;
  final String documentType;
  final String status;

  const RequestDetailScreen({
    super.key,
    required this.trackingId,
    required this.documentType,
    required this.status,
  });

  Map<String, String> get _applicationDetails => {
    'Document Type': documentType,
    'Full Name': 'Kumara Bandara Dissanayake',
    'NIC Number': '199512345678',
    'Address': '42/A, Temple Road, Kadawatha, Gampaha District',
    'Reason':
        'Required for employment verification at a government institution',
    'Submitted Date': '22 Feb 2026',
  };

  String get _gnRemarks {
    if (status == 'Approved') {
      return 'All documents verified. The applicant has been residing in this area for over 15 years. Character is satisfactory.';
    }
    if (status == 'Rejected') {
      return 'The NIC copy provided is not legible. Please resubmit with a clear copy of the NIC (front and back).';
    }
    return '';
  }

  Color get _statusColor {
    switch (status) {
      case 'Approved':
        return AppColors.success;
      case 'Rejected':
        return AppColors.error;
      case 'In Review':
        return AppColors.info;
      default:
        return AppColors.warning;
    }
  }

  IconData get _statusIcon {
    switch (status) {
      case 'Approved':
        return Icons.check_circle_rounded;
      case 'Rejected':
        return Icons.cancel_rounded;
      case 'In Review':
        return Icons.rate_review_rounded;
      default:
        return Icons.schedule_rounded;
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Request Details', style: AppTextStyles.h3),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 1, color: AppColors.divider),
            _buildStatusHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTimeline(),
                  const SizedBox(height: 24),
                  _buildDetailsCard(),
                  if (_gnRemarks.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _buildRemarksCard(),
                  ],
                  const SizedBox(height: 24),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Status Header ─────────────────────────────────────────────────────
  Widget _buildStatusHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _statusColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _statusColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(_statusIcon, color: _statusColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: AppTextStyles.h3.copyWith(color: _statusColor),
                ),
                const SizedBox(height: 4),
                Text(
                  trackingId,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Timeline ──────────────────────────────────────────────────────────
  Widget _buildTimeline() {
    final steps = [
      _TimelineStep('Application Submitted', '22 Feb 2026, 10:30 AM', true),
      _TimelineStep(
        'Under Review',
        '23 Feb 2026, 9:00 AM',
        status != 'Pending',
      ),
      _TimelineStep(
        'GN Verification',
        '24 Feb 2026, 2:00 PM',
        status == 'Approved' || status == 'Rejected',
      ),
      _TimelineStep(
        status == 'Rejected' ? 'Application Rejected' : 'Ready for Collection',
        status == 'Approved' || status == 'Rejected'
            ? '24 Feb 2026, 4:30 PM'
            : 'Pending',
        status == 'Approved' || status == 'Rejected',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress', style: AppTextStyles.bodySemiBold),
        const SizedBox(height: 14),
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isLast = index == steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: step.isCompleted
                          ? _statusColor
                          : AppColors.disabledBackground,
                      shape: BoxShape.circle,
                    ),
                    child: step.isCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 14,
                          )
                        : Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.disabled,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 40,
                      color: step.isCompleted
                          ? _statusColor.withOpacity(0.3)
                          : AppColors.disabledBackground,
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: step.isCompleted
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        step.subtitle,
                        style: AppTextStyles.small.copyWith(
                          color: step.isCompleted
                              ? AppColors.textSecondary
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  // ── Details card ──────────────────────────────────────────────────────
  Widget _buildDetailsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Application Details', style: AppTextStyles.bodySemiBold),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: _applicationDetails.entries.map((entry) {
              final isLast = entry.key == _applicationDetails.keys.last;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(entry.key, style: AppTextStyles.caption),
                        ),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    const Divider(height: 1, color: AppColors.divider),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ── Remarks card ──────────────────────────────────────────────────────
  Widget _buildRemarksCard() {
    final isRejected = status == 'Rejected';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('GN Remarks', style: AppTextStyles.bodySemiBold),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isRejected ? AppColors.errorLight : AppColors.successLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: (isRejected ? AppColors.error : AppColors.success)
                  .withOpacity(0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isRejected
                    ? Icons.info_outline_rounded
                    : Icons.check_circle_outline_rounded,
                color: isRejected ? AppColors.error : AppColors.success,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _gnRemarks,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Action buttons ────────────────────────────────────────────────────
  Widget _buildActionButtons(BuildContext context) {
    if (status == 'Rejected') {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.refresh_rounded, size: 20),
          label: const Text('Resubmit Application'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _TimelineStep {
  final String title;
  final String subtitle;
  final bool isCompleted;

  const _TimelineStep(this.title, this.subtitle, this.isCompleted);
}
