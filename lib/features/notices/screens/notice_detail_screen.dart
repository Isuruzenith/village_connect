import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class NoticeDetailScreen extends StatelessWidget {
  final Map<String, String> notice;

  const NoticeDetailScreen({
    super.key,
    required this.notice,
  });

  Color _categoryColor(String category) {
    switch (category) {
      case 'General':
        return AppColors.accentBlue;
      case 'Health':
        return AppColors.accentGreen;
      case 'Emergency':
        return AppColors.accentRed;
      case 'Event':
        return AppColors.accentYellow;
      default:
        return AppColors.accentBlue;
    }
  }

  Color _categoryTextColor(String category) {
    switch (category) {
      case 'General':
        return AppColors.info;
      case 'Health':
        return AppColors.success;
      case 'Emergency':
        return AppColors.error;
      case 'Event':
        return AppColors.warning;
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = notice['title'] ?? '';
    final String category = notice['category'] ?? 'General';
    final String date = notice['date'] ?? '';
    final String content = notice['content'] ?? notice['description'] ?? '';
    final bool hasAttachment = notice['hasAttachment'] == 'true';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        title: const Text(
          'Notice Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verified badge and official label
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.info,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Official Announcement',
                    style: AppTextStyles.captionMedium.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Category chip
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _categoryColor(category),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: AppTextStyles.small.copyWith(
                  color: _categoryTextColor(category),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: AppTextStyles.h2.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // Date and author
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.person_outline_rounded,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'By: Grama Niladhari Office, Kaduwela',
                    style: AppTextStyles.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Divider
            const Divider(color: AppColors.divider, thickness: 1),
            const SizedBox(height: 16),

            // Full content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                content,
                style: AppTextStyles.body.copyWith(
                  height: 1.7,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Attachment card
            if (hasAttachment) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accentPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF7C3AED),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attached Document',
                            style: AppTextStyles.bodyMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'PDF Document',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: IconButton(
                        icon: const Icon(
                          Icons.download_rounded,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Download started...'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        tooltip: 'Download document',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Action buttons
            const Divider(color: AppColors.divider, thickness: 1),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Share options opened'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.share_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      label: Text(
                        'Share',
                        style: AppTextStyles.captionMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.divider,
                ),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Report submitted'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.flag_outlined,
                        color: AppColors.error,
                        size: 20,
                      ),
                      label: Text(
                        'Report Issue',
                        style: AppTextStyles.captionMedium.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
