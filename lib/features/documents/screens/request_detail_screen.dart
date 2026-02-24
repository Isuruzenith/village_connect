import 'package:flutter/material.dart';
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

  // Mock data for the detail view
  Map<String, String> get _applicationDetails => {
        'Document Type': documentType,
        'Full Name': 'Kumara Bandara Dissanayake',
        'NIC Number': '199512345678',
        'Address': '42/A, Temple Road, Kadawatha, Gampaha District',
        'Reason': 'Required for employment verification at a government institution',
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Request Details',
          style: AppTextStyles.h3.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 24),
            _buildTimelineProgress(),
            const SizedBox(height: 24),
            _buildApplicationDetailsCard(),
            const SizedBox(height: 20),
            if (status == 'Approved') ...[
              _buildGNRemarksCard(context),
              const SizedBox(height: 20),
              _buildDownloadButton(context),
            ],
            if (status == 'Rejected') ...[
              _buildRejectionCard(),
              const SizedBox(height: 20),
            ],
            if (status == 'In Review') ...[
              _buildAdditionalInfoCard(context),
              const SizedBox(height: 20),
            ],
            if (status == 'Pending') ...[
              _buildPendingInfoCard(),
              const SizedBox(height: 20),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status Header
  // ---------------------------------------------------------------------------
  Widget _buildStatusHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: _statusBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _statusIcon,
              color: _statusTextColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: _statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: AppTextStyles.captionMedium.copyWith(
                color: _statusTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _statusMessage,
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tag_rounded, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                trackingId,
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color get _statusBgColor {
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

  Color get _statusTextColor {
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

  IconData get _statusIcon {
    switch (status) {
      case 'Pending':
        return Icons.schedule_rounded;
      case 'In Review':
        return Icons.rate_review_outlined;
      case 'Approved':
        return Icons.check_circle_outline_rounded;
      case 'Rejected':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline_rounded;
    }
  }

  String get _statusMessage {
    switch (status) {
      case 'Pending':
        return 'Your application has been received and is awaiting review by the Grama Niladhari.';
      case 'In Review':
        return 'The Grama Niladhari is currently reviewing your application. You will be notified once a decision is made.';
      case 'Approved':
        return 'Your application has been approved. You can download the certificate below.';
      case 'Rejected':
        return 'Unfortunately, your application could not be approved. Please review the reason below.';
      default:
        return '';
    }
  }

  // ---------------------------------------------------------------------------
  // Timeline Progress
  // ---------------------------------------------------------------------------
  Widget _buildTimelineProgress() {
    final steps = [
      {'label': 'Submitted', 'date': '22 Feb 2026'},
      {'label': 'In Review', 'date': status == 'Pending' ? '' : '23 Feb 2026'},
      {'label': 'Approved', 'date': status == 'Approved' ? '24 Feb 2026' : ''},
    ];

    int completedIndex;
    switch (status) {
      case 'Pending':
        completedIndex = 0;
        break;
      case 'In Review':
        completedIndex = 1;
        break;
      case 'Approved':
        completedIndex = 2;
        break;
      case 'Rejected':
        completedIndex = 1;
        break;
      default:
        completedIndex = 0;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Application Progress', style: AppTextStyles.bodySemiBold),
          const SizedBox(height: 20),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isCompleted = index <= completedIndex;
            final isCurrent = index == completedIndex;
            final isRejected = status == 'Rejected' && index == completedIndex;
            final isLast = index == steps.length - 1;

            Color dotColor;
            if (isRejected) {
              dotColor = AppColors.error;
            } else if (isCompleted) {
              dotColor = AppColors.success;
            } else {
              dotColor = AppColors.disabledBackground;
            }

            Color lineColor;
            if (isRejected) {
              lineColor = AppColors.error.withValues(alpha: 0.3);
            } else if (index < completedIndex) {
              lineColor = AppColors.success.withValues(alpha: 0.4);
            } else {
              lineColor = AppColors.disabledBackground;
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline dot and line
                SizedBox(
                  width: 28,
                  child: Column(
                    children: [
                      Container(
                        width: isCurrent ? 20 : 16,
                        height: isCurrent ? 20 : 16,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                          border: isCurrent && !isRejected
                              ? Border.all(
                                  color: dotColor.withValues(alpha: 0.3),
                                  width: 3,
                                )
                              : null,
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color: dotColor.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: isCompleted
                            ? Icon(
                                isRejected
                                    ? Icons.close_rounded
                                    : Icons.check_rounded,
                                color: Colors.white,
                                size: isCurrent ? 12 : 10,
                              )
                            : null,
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: lineColor,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                // Step label and date
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isCurrent ? 0 : 0,
                      bottom: isLast ? 0 : 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isRejected ? 'Rejected' : step['label']!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isCompleted
                                ? AppColors.textPrimary
                                : AppColors.textMuted,
                            fontWeight: isCurrent
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                        if (step['date']!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            step['date']!,
                            style: AppTextStyles.small,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Application Details Card
  // ---------------------------------------------------------------------------
  Widget _buildApplicationDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text('Application Details', style: AppTextStyles.bodySemiBold),
            ],
          ),
          const SizedBox(height: 18),
          ..._applicationDetails.entries.map((entry) {
            return Column(
              children: [
                _buildDetailRow(entry.key, entry.value),
                if (entry.key != _applicationDetails.keys.last)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: AppColors.divider, height: 1),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: AppTextStyles.caption,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(fontSize: 15),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // GN Remarks Card (Approved)
  // ---------------------------------------------------------------------------
  Widget _buildGNRemarksCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 5, color: AppColors.success),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.comment_outlined,
                            color: AppColors.success,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'GN Remarks',
                          style: AppTextStyles.bodySemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _gnRemarks,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Mr. H.P. Jayasinghe (GN Officer)',
                          style: AppTextStyles.small.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '24 Feb 2026',
                          style: AppTextStyles.small,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Download Button (Approved)
  // ---------------------------------------------------------------------------
  Widget _buildDownloadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Downloading certificate...',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        icon: const Icon(Icons.download_rounded, size: 22),
        label: Text('Download Certificate', style: AppTextStyles.button),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Rejection Card (Rejected)
  // ---------------------------------------------------------------------------
  Widget _buildRejectionCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 5, color: AppColors.error),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accentRed,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.error_outline_rounded,
                            color: AppColors.error,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Reason for Rejection',
                          style: AppTextStyles.bodySemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _gnRemarks,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Mr. H.P. Jayasinghe (GN Officer)',
                          style: AppTextStyles.small.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '24 Feb 2026',
                          style: AppTextStyles.small,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh_rounded, size: 20),
                        label: Text(
                          'Resubmit Application',
                          style: AppTextStyles.buttonSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
    );
  }

  // ---------------------------------------------------------------------------
  // Additional Info Card (In Review)
  // ---------------------------------------------------------------------------
  Widget _buildAdditionalInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 5, color: AppColors.warning),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accentYellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.warning,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Additional Information Required',
                            style: AppTextStyles.bodySemiBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'The GN Officer has requested additional supporting documents. Please upload a clear colour copy of your NIC (both sides) and a utility bill as proof of residence.',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.upload_file_rounded, size: 20),
                        label: Text(
                          'Upload More Documents',
                          style: AppTextStyles.buttonSmall,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
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
    );
  }

  // ---------------------------------------------------------------------------
  // Pending Info Card
  // ---------------------------------------------------------------------------
  Widget _buildPendingInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentYellow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentYellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.hourglass_top_rounded,
              color: AppColors.warning,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Waiting for Review',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your application is in the queue. Estimated processing time: 3-5 working days.',
                  style: AppTextStyles.small.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
