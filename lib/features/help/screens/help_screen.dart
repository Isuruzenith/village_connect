import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../chatbot/screens/chatbot_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<_QuickHelpItem> _quickHelpItems = [
    _QuickHelpItem('How to Apply', Icons.article_outlined, AppColors.accentBlue),
    _QuickHelpItem('Track Request', Icons.track_changes, AppColors.accentGreen),
    _QuickHelpItem('Report Issue', Icons.flag_outlined, AppColors.accentRed),
    _QuickHelpItem('Contact GN', Icons.phone_outlined, AppColors.accentYellow),
  ];

  final List<_FaqItem> _faqItems = [
    _FaqItem(
      question: 'How do I apply for a character certificate?',
      answer:
          'To apply for a character certificate, go to the Home screen and tap "Apply for Documents". Select "Character Certificate" from the list. Fill in the required details including the purpose of the certificate and upload a copy of your NIC. Submit the application and you will receive a reference number for tracking.',
    ),
    _FaqItem(
      question: 'How long does document processing take?',
      answer:
          'Document processing typically takes 3-5 working days after submission. Character certificates usually take 3 days, residence certificates take 5 days, and income certificates may take up to 7 days depending on verification requirements. You will receive a notification when your document is ready for collection.',
    ),
    _FaqItem(
      question: 'How can I track my application?',
      answer:
          'You can track your application by going to the "My Requests" section from the home screen. Each application has a status indicator showing whether it is Pending, In Review, Approved, or Rejected. You can also tap on any application to view detailed status history.',
    ),
    _FaqItem(
      question: 'What documents do I need to upload?',
      answer:
          'The required documents vary by application type. Generally, you will need a clear photo of your National Identity Card (NIC). For income certificates, you may also need proof of employment or a salary slip. For residence certificates, utility bills (electricity, water) may be required as proof of address.',
    ),
    _FaqItem(
      question: 'How do I report a community issue?',
      answer:
          'To report a community issue, navigate to the Home screen and tap "Report Issue". Select the issue category (road, water, electricity, etc.), provide a description, optionally attach a photo, and pin the location on the map. The issue will be forwarded to the relevant GN Officer for action.',
    ),
  ];

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleArea(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 28),
              _buildQuickHelpSection(),
              const SizedBox(height: 28),
              _buildFaqSection(),
              const SizedBox(height: 28),
              _buildContactInfoCard(),
              const SizedBox(height: 20),
              _buildChatButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Help & Support', style: AppTextStyles.h1),
        const SizedBox(height: 4),
        Text(
          'How can we help you?',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: _searchController,
        style: AppTextStyles.body,
        decoration: InputDecoration(
          hintText: 'Search for help topics...',
          hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickHelpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Help', style: AppTextStyles.h3),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: _quickHelpItems.length,
          itemBuilder: (context, index) {
            return _buildQuickHelpCard(_quickHelpItems[index]);
          },
        ),
      ],
    );
  }

  Widget _buildQuickHelpCard(_QuickHelpItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigate to help topic
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: item.backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: item.backgroundColor,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.label,
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frequently Asked Questions', style: AppTextStyles.h3),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: List.generate(_faqItems.length, (index) {
                final faq = _faqItems[index];
                return Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text(
                          faq.question,
                          style: AppTextStyles.bodyMedium,
                        ),
                        iconColor: AppColors.textMuted,
                        collapsedIconColor: AppColors.textMuted,
                        children: [
                          Text(
                            faq.answer,
                            style: AppTextStyles.caption.copyWith(
                              height: 1.6,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < _faqItems.length - 1)
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.divider,
                        indent: 16,
                        endIndent: 16,
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Information', style: AppTextStyles.h3),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildContactRow(
                Icons.phone_outlined,
                'GN Office Phone',
                '+94 11 234 5678',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: AppColors.divider),
              ),
              _buildContactRow(
                Icons.access_time_rounded,
                'Office Hours',
                'Mon - Fri, 8:30 AM - 4:30 PM',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: AppColors.divider),
              ),
              _buildContactRow(
                Icons.location_on_outlined,
                'Office Address',
                'GN Office, Temple Road, Kaduwela',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: AppColors.divider),
              ),
              _buildContactRow(
                Icons.email_outlined,
                'Email',
                'gn.kaduwela@gov.lk',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondarySurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.small.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatbotScreen()),
          );
        },
        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
        label: Text(
          'Need more help? Chat with us',
          style: AppTextStyles.buttonSmall.copyWith(
            color: AppColors.primary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _QuickHelpItem {
  final String label;
  final IconData icon;
  final Color backgroundColor;

  const _QuickHelpItem(this.label, this.icon, this.backgroundColor);
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});
}
