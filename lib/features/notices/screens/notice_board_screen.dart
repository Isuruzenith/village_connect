import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'notice_detail_screen.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<Map<String, String>> _notices = [
    {
      'title': 'Water Supply Maintenance Notice',
      'category': 'General',
      'description':
          'Scheduled maintenance on main water supply lines in Kaduwela area. Residents are advised to store sufficient water for the duration of the maintenance period.',
      'date': 'Feb 22, 2026',
      'content':
          'The National Water Supply and Drainage Board hereby informs all residents of the Kaduwela divisional area that scheduled maintenance work will be carried out on the main water supply lines serving Wards 3, 5, and 7.\n\nThe maintenance is scheduled to commence on February 25, 2026 at 8:00 AM and is expected to be completed by 6:00 PM on the same day. During this period, water supply to the affected areas will be temporarily interrupted.\n\nResidents are kindly advised to store sufficient water for drinking, cooking, and other essential needs prior to the commencement of works. Emergency water bowsers will be stationed at the Kaduwela Community Hall and the Malabe Junction for public use.\n\nFor any inquiries, please contact the Grama Niladhari Office at 011-2xxxxxx during office hours.\n\nWe apologize for any inconvenience caused and appreciate your cooperation.',
      'hasAttachment': 'true',
    },
    {
      'title': 'Dengue Prevention Campaign',
      'category': 'Health',
      'description':
          'Free fumigation service available for all households in the Kaduwela area. Register at your nearest Grama Niladhari office.',
      'date': 'Feb 20, 2026',
      'content':
          'The Ministry of Health, in collaboration with the Kaduwela Divisional Secretariat, is pleased to announce a comprehensive Dengue Prevention Campaign for all residents within the division.\n\nAs part of this initiative, free fumigation services will be provided to all registered households. The campaign will run from February 25 to March 10, 2026.\n\nTo register for the fumigation service, residents are requested to visit their nearest Grama Niladhari office with their National Identity Card and proof of residence. Registration is open from 9:00 AM to 4:00 PM on weekdays.\n\nIn addition, a public awareness programme on dengue prevention will be conducted at the Kaduwela Community Hall on February 28, 2026 at 3:00 PM. All residents are encouraged to attend.\n\nPreventive measures recommended:\n- Eliminate stagnant water around your premises\n- Use mosquito nets and repellents\n- Keep drains and gutters clean\n- Report any suspected dengue cases immediately\n\nFor more information, contact the Public Health Inspector at 011-2xxxxxx.',
      'hasAttachment': 'false',
    },
    {
      'title': 'Road Development Project Update',
      'category': 'General',
      'description':
          'Phase 2 of the Malabe-Kaduwela road development project is now underway. Expect traffic diversions along the main route.',
      'date': 'Feb 18, 2026',
      'content':
          'The Road Development Authority wishes to inform the public that Phase 2 of the Malabe-Kaduwela Road Development Project has officially commenced as of February 15, 2026.\n\nThis phase involves the widening of the road segment from Kaduwela Junction to the Malabe Town limits, spanning approximately 3.2 kilometres. The project is funded under the National Infrastructure Development Programme and is expected to be completed within 8 months.\n\nDuring the construction period, temporary traffic diversions will be in effect. Motorists are advised to use alternative routes via the Athurugiriya bypass where possible. Traffic police and road marshals will be deployed at key intersections to manage traffic flow.\n\nThe project will include improved pedestrian walkways, drainage systems, and street lighting. The Divisional Secretariat will coordinate with affected property owners regarding any land acquisition requirements.\n\nWe seek the patience and cooperation of all road users during this period of development.',
      'hasAttachment': 'true',
    },
    {
      'title': 'Community Health Camp',
      'category': 'Health',
      'description':
          'Free health screening camp organized at Kaduwela Community Hall. Blood pressure, diabetes, and eye tests available.',
      'date': 'Feb 15, 2026',
      'content':
          'The Kaduwela Divisional Health Office is organizing a free Community Health Camp for all residents of the division. The camp will be held at the Kaduwela Community Hall on February 22, 2026 from 8:00 AM to 2:00 PM.\n\nServices available at the health camp include:\n- Blood pressure screening\n- Blood sugar testing for diabetes\n- Eye examination and vision testing\n- BMI assessment and nutritional counselling\n- Dental check-up\n- General medical consultation\n\nAll services will be provided free of charge by qualified medical professionals from the Kaduwela Base Hospital and volunteer medical officers.\n\nResidents are advised to bring their National Identity Card and any existing medical records or prescriptions. Those requiring fasting blood sugar tests are requested to refrain from eating after 10:00 PM the previous night.\n\nFor registration and inquiries, please contact the MOH Office at 011-2xxxxxx.',
      'hasAttachment': 'false',
    },
    {
      'title': 'Village Election Announcement',
      'category': 'Event',
      'description':
          'Annual village committee election scheduled for March 15. Nominations are now open for all eligible residents.',
      'date': 'Feb 12, 2026',
      'content':
          'The Grama Niladhari Office of Kaduwela hereby announces that the Annual Village Committee Election for the year 2026 will be held on March 15, 2026.\n\nNominations are now open for the following positions:\n- Village Committee Chairperson\n- Vice Chairperson\n- Secretary\n- Treasurer\n- Committee Members (5 positions)\n\nEligibility criteria for candidates:\n- Must be a permanent resident of the Kaduwela GN Division\n- Must be above 18 years of age\n- Must possess a valid National Identity Card\n- Must not have any pending criminal charges\n\nNomination forms are available at the Grama Niladhari Office during working hours (9:00 AM - 4:00 PM, Monday to Friday). The deadline for submission of nominations is March 1, 2026.\n\nAll eligible voters within the GN division are encouraged to participate in the election process. Voter registration can be verified at the GN Office.\n\nFor further details, please contact the Grama Niladhari at 011-2xxxxxx.',
      'hasAttachment': 'false',
    },
  ];

  List<Map<String, String>> get _filteredNotices {
    if (_searchQuery.isEmpty) return _notices;
    final query = _searchQuery.toLowerCase();
    return _notices.where((notice) {
      return notice['title']!.toLowerCase().contains(query) ||
          notice['description']!.toLowerCase().contains(query) ||
          notice['category']!.toLowerCase().contains(query);
    }).toList();
  }

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notices = _filteredNotices;

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
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                cursorColor: AppColors.textOnPrimary,
                decoration: InputDecoration(
                  hintText: 'Search announcements...',
                  hintStyle: AppTextStyles.body.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              )
            : const Text(
                'Notice Board',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close_rounded : Icons.search_rounded,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                }
                _isSearching = !_isSearching;
              });
            },
            tooltip: _isSearching ? 'Close search' : 'Search',
          ),
        ],
      ),
      body: notices.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 64,
                    color: AppColors.textMuted.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No announcements found',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Try a different search term',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notice = notices[index];
                return _NoticeCard(
                  title: notice['title']!,
                  description: notice['description']!,
                  date: notice['date']!,
                  category: notice['category']!,
                  categoryColor: _categoryColor(notice['category']!),
                  categoryTextColor: _categoryTextColor(notice['category']!),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NoticeDetailScreen(notice: notice),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String category;
  final Color categoryColor;
  final Color categoryTextColor;
  final VoidCallback? onTap;

  const _NoticeCard({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.categoryColor,
    required this.categoryTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
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
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: AppTextStyles.small.copyWith(
                        color: categoryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: 14,
                          color: AppColors.info,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Official',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.info,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyles.bodySemiBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    date,
                    style: AppTextStyles.small,
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
