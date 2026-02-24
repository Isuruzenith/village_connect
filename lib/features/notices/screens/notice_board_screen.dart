import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  String _selectedCategory = 'All';
  final _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'General',
    'Development',
    'Emergency',
    'Health',
  ];

  final List<_Notice> _notices = [
    _Notice(
      title: 'New Road Development Project',
      body:
          'Construction of new asphalt road from Kaduwela junction to Welivita temple will commence on March 5. Expected completion: June 2026.',
      category: 'Development',
      date: '24 Feb 2026',
      isOfficial: true,
    ),
    _Notice(
      title: 'Dengue Prevention Campaign',
      body:
          'All residents are requested to destroy mosquito breeding sites. Village-wide fogging scheduled for February 28 from 6 PM.',
      category: 'Health',
      date: '23 Feb 2026',
      isOfficial: true,
    ),
    _Notice(
      title: 'GN Office Hours Change',
      body:
          'Starting March 1, 2026, the GN Office will be open from 8:30 AM to 4:30 PM (Monday–Friday). Saturday hours remain 9 AM – 12 PM.',
      category: 'General',
      date: '22 Feb 2026',
      isOfficial: true,
    ),
    _Notice(
      title: 'Water Supply Interruption',
      body:
          'Water supply will be interrupted on Feb 26 from 8 AM to 5 PM due to pipeline maintenance. Please store sufficient water.',
      category: 'Emergency',
      date: '21 Feb 2026',
      isOfficial: true,
    ),
    _Notice(
      title: 'Annual Village Sports Festival',
      body:
          'The annual sports festival will be held on March 15 at Kaduwela Playground. Registration open for all age groups. Contact GN Office for details.',
      category: 'General',
      date: '20 Feb 2026',
      isOfficial: false,
    ),
  ];

  List<_Notice> get _filteredNotices {
    var filtered = _notices;
    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((n) => n.category == _selectedCategory)
          .toList();
    }
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered
          .where(
            (n) =>
                n.title.toLowerCase().contains(query) ||
                n.body.toLowerCase().contains(query),
          )
          .toList();
    }
    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 16),
            Expanded(child: _buildNoticesList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Text(
        'Notice Board',
        style: AppTextStyles.displayLarge.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: 'Search notices...',
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.textMuted,
              size: 24,
            ),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
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
                cat,
                style: AppTextStyles.captionMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoticesList() {
    final filtered = _filteredNotices;
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
                Icons.article_rounded,
                size: 36,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No notices found',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters.',
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
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: _buildNoticeCard(filtered[index])),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoticeCard(_Notice notice) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _categoryColor(notice.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notice.category,
                      style: AppTextStyles.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _categoryColor(notice.category),
                      ),
                    ),
                  ),
                  if (notice.isOfficial) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Official',
                            style: AppTextStyles.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    notice.date,
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                notice.title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                notice.body,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Emergency':
        return AppColors.error;
      case 'Health':
        return AppColors.success;
      case 'Development':
        return AppColors.info;
      default:
        return AppColors.primary;
    }
  }
}

class _Notice {
  final String title;
  final String body;
  final String category;
  final String date;
  final bool isOfficial;

  const _Notice({
    required this.title,
    required this.body,
    required this.category,
    required this.date,
    required this.isOfficial,
  });
}
