import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/vc_components.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;
  final int _totalSteps = 3;

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _nicController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreedToTerms = false;

  String _selectedVillage = '';
  String _selectedDistrict = '';

  final List<String> _stepLabels = ['Personal Info', 'Address', 'Password'];

  final List<String> _villages = [
    'Welivita South',
    'Welivita North',
    'Kaduwela East',
    'Kaduwela West',
    'Malabe Central',
  ];

  final List<String> _districts = [
    'Colombo',
    'Gampaha',
    'Kandy',
    'Kalutara',
    'Matara',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0 && !_formKey.currentState!.validate()) return;
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _register() {
    if (_agreedToTerms) {
      context.pop();
    }
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _fullNameController.text.trim().isNotEmpty &&
            _nicController.text.trim().isNotEmpty &&
            _phoneController.text.trim().isNotEmpty;
      case 1:
        return _addressController.text.trim().isNotEmpty &&
            _selectedVillage.isNotEmpty &&
            _selectedDistrict.isNotEmpty;
      case 2:
        return _passwordController.text.trim().isNotEmpty &&
            _confirmPasswordController.text.trim().isNotEmpty &&
            _agreedToTerms;
      default:
        return false;
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
        title: Text('Create Account', style: AppTextStyles.h3),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: AppColors.divider),
          VcStepIndicator(
            currentStep: _currentStep,
            totalSteps: _totalSteps,
            labels: _stepLabels,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildCurrentStep(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildAddressStep();
      case 2:
        return _buildPasswordStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Step 1: Personal Info ─────────────────────────────────────────────
  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Details', style: AppTextStyles.h3),
            const SizedBox(height: 6),
            Text(
              'Enter your details as per your NIC.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 24),
            _buildFormField(
              label: 'Full Name',
              controller: _fullNameController,
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Full name is required'
                  : null,
            ),
            const SizedBox(height: 18),
            _buildFormField(
              label: 'NIC Number',
              controller: _nicController,
              hint: 'e.g., 200012345678',
              icon: Icons.badge_outlined,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'NIC number is required'
                  : null,
            ),
            const SizedBox(height: 18),
            _buildFormField(
              label: 'Phone Number',
              controller: _phoneController,
              hint: '+94 77 123 4567',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Phone number is required'
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ── Step 2: Address ───────────────────────────────────────────────────
  Widget _buildAddressStep() {
    return SingleChildScrollView(
      key: const ValueKey('step2'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Address & Village', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Text(
            'Your village information helps route services correctly.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 24),
          _buildFormField(
            label: 'Home Address',
            controller: _addressController,
            hint: 'Enter your permanent address',
            icon: Icons.location_on_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: 18),
          _buildDropdownField(
            label: 'Village / Division',
            value: _selectedVillage,
            items: _villages,
            icon: Icons.holiday_village_outlined,
            onChanged: (v) => setState(() => _selectedVillage = v ?? ''),
          ),
          const SizedBox(height: 18),
          _buildDropdownField(
            label: 'District',
            value: _selectedDistrict,
            items: _districts,
            icon: Icons.map_outlined,
            onChanged: (v) => setState(() => _selectedDistrict = v ?? ''),
          ),
        ],
      ),
    );
  }

  // ── Step 3: Password ──────────────────────────────────────────────────
  Widget _buildPasswordStep() {
    return SingleChildScrollView(
      key: const ValueKey('step3'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Set Password', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Text(
            'Choose a strong password for your account.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 24),
          _buildFormField(
            label: 'Password',
            controller: _passwordController,
            hint: 'Enter a password',
            icon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 18),
          _buildFormField(
            label: 'Confirm Password',
            controller: _confirmPasswordController,
            hint: 'Re-enter your password',
            icon: Icons.lock_outline_rounded,
            obscureText: _obscureConfirm,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: (v) =>
                          setState(() => _agreedToTerms = v ?? false),
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: AppTextStyles.caption,
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: AppTextStyles.captionMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.captionMedium.copyWith(
                              color: AppColors.primary,
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
        ],
      ),
    );
  }

  // ── Shared form field builder ─────────────────────────────────────────
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          validator: validator,
          onChanged: (_) => setState(() {}),
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
            prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.surfaceGrey,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value.isEmpty ? null : value,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
            filled: true,
            fillColor: AppColors.surfaceGrey,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
          hint: Text(
            'Select $label',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: AppTextStyles.body),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // ── Bottom bar ────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    final isLastStep = _currentStep == _totalSteps - 1;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: _currentStep > 0 ? 2 : 1,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _canProceed
                    ? (isLastStep ? _register : _nextStep)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  disabledBackgroundColor: AppColors.disabledBackground,
                  disabledForegroundColor: AppColors.disabled,
                  elevation: _canProceed ? 2 : 0,
                  shadowColor: AppColors.primary.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLastStep ? 'Create Account' : 'Continue',
                  style: AppTextStyles.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
