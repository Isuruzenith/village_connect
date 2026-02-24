import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock profile data
  final Map<String, String> _profileData = {
    'fullName': 'Kamal Perera',
    'nic': '199012345678',
    'dob': '15 March 1990',
    'phone': '+94 77 123 4567',
    'address': '42/A, Temple Road, Kaduwela, Colombo',
    'village': 'Welivita South',
    'gnDivision': 'Kaduwela 521',
    'district': 'Colombo',
  };

  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Go back',
        ),
        title: Text(
          'My Profile',
          style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 28),
            _buildSectionLabel('Personal Information'),
            const SizedBox(height: 12),
            _buildPersonalInfoCard(),
            const SizedBox(height: 24),
            _buildSectionLabel('Village Information'),
            const SizedBox(height: 12),
            _buildVillageInfoCard(),
            const SizedBox(height: 24),
            _buildSectionLabel('Settings'),
            const SizedBox(height: 12),
            _buildSettingsCard(),
            const SizedBox(height: 32),
            _buildLogoutButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'KP',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textOnPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _profileData['fullName']!,
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 4),
          Text(
            'NIC: ${_profileData['nic']}',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () {
                // Edit profile action
              },
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: Text(
                'Edit Profile',
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Text(
      title,
      style: AppTextStyles.bodySemiBold.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    final items = [
      _InfoRowData(Icons.person_outline_rounded, 'Full Name', _profileData['fullName']!),
      _InfoRowData(Icons.badge_outlined, 'NIC Number', _profileData['nic']!),
      _InfoRowData(Icons.calendar_today_outlined, 'Date of Birth', _profileData['dob']!),
      _InfoRowData(Icons.phone_outlined, 'Phone Number', _profileData['phone']!),
      _InfoRowData(Icons.location_on_outlined, 'Address', _profileData['address']!),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.label,
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.value,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (index < items.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.divider,
                  indent: 48,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildVillageInfoCard() {
    final items = [
      _InfoRowData(Icons.holiday_village_outlined, 'Village / Division', _profileData['village']!),
      _InfoRowData(Icons.map_outlined, 'GN Division', _profileData['gnDivision']!),
      _InfoRowData(Icons.location_city_outlined, 'District', _profileData['district']!),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.label,
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.value,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (index < items.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.divider,
                  indent: 48,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _showLanguageSelector();
              },
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    const Icon(
                      Icons.language_rounded,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Language',
                        style: AppTextStyles.body,
                      ),
                    ),
                    Text(
                      _selectedLanguage,
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.divider,
            indent: 48,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigate to About App
              },
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'About App',
                        style: AppTextStyles.body,
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
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {
          _showLogoutConfirmation();
        },
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: Text(
          'Logout',
          style: AppTextStyles.button.copyWith(color: AppColors.error),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.disabled,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Select Language', style: AppTextStyles.h3),
                const SizedBox(height: 16),
                _buildLanguageOption('English'),
                _buildLanguageOption('Sinhala'),
                _buildLanguageOption('Tamil'),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    final isSelected = _selectedLanguage == language;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedLanguage = language;
          });
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  language,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Logout', style: AppTextStyles.h3),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.buttonSmall.copyWith(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout
              },
              child: Text(
                'Logout',
                style: AppTextStyles.buttonSmall.copyWith(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InfoRowData {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRowData(this.icon, this.label, this.value);
}
