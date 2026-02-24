import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'login_screen.dart';

/// Registration screen for Village Connect.
/// Presents a step-based form with a progress indicator covering NIC,
/// personal details, village selection, and password creation.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Form keys for each step.
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();

  // Controllers.
  final _nicController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State.
  int _currentStep = 0; // 0 = personal info, 1 = password
  static const int _totalSteps = 2;

  String? _selectedVillage;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreedToTerms = false;
  bool _isLoading = false;

  // Village / Division options.
  static const List<String> _villages = [
    'Kaduwela',
    'Malabe',
    'Battaramulla',
    'Rajagiriya',
    'Nugegoda',
  ];

  @override
  void dispose() {
    _nicController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------------
  // Navigation helpers
  // ------------------------------------------------------------------

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (!(_step1Key.currentState?.validate() ?? false)) return;
      if (_selectedVillage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your Village / Division'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      setState(() => _currentStep = 1);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  Future<void> _onRegister() async {
    if (!(_step2Key.currentState?.validate() ?? false)) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms & Privacy Policy'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate registration network call.
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    setState(() => _isLoading = false);

    // Show success and go to login.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful! Please log in.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.success,
      ),
    );

    _goToLogin();
  }

  // ------------------------------------------------------------------
  // Validators
  // ------------------------------------------------------------------

  String? _validateNic(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your NIC number';
    }
    final trimmed = value.trim();
    final oldFormat = RegExp(r'^\d{9}[VvXx]$');
    final newFormat = RegExp(r'^\d{12}$');
    if (!oldFormat.hasMatch(trimmed) && !newFormat.hasMatch(trimmed)) {
      return 'Enter a valid NIC (e.g. 123456789V or 200012345678)';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // ------------------------------------------------------------------
  // Build
  // ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          iconSize: 24,
          onPressed: _currentStep > 0 ? _prevStep : () => Navigator.pop(context),
          tooltip: _currentStep > 0 ? 'Previous step' : 'Back to Login',
        ),
        title: Text(
          'Create Account',
          style: AppTextStyles.h3.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            _buildProgressBar(),

            // Form body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Progress bar
  // ------------------------------------------------------------------

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Step ${_currentStep + 1} of $_totalSteps',
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              Text(
                _currentStep == 0 ? 'Personal Details' : 'Security',
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / _totalSteps,
              minHeight: 6,
              backgroundColor: AppColors.border,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Step 1 -- Personal Details
  // ------------------------------------------------------------------

  Widget _buildStep1() {
    return Form(
      key: _step1Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          Text(
            'Personal Information',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 4),
          Text(
            'Enter your details as they appear on your NIC',
            style: AppTextStyles.caption,
          ),

          const SizedBox(height: 28),

          // NIC Number
          _buildLabel('NIC Number'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _nicController,
            hint: 'e.g. 123456789V',
            prefixIcon: Icons.badge_outlined,
            validator: _validateNic,
            keyboardType: TextInputType.text,
          ),

          const SizedBox(height: 20),

          // Full Name
          _buildLabel('Full Name'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _fullNameController,
            hint: 'Enter your full name',
            prefixIcon: Icons.person_outline_rounded,
            validator: (v) => _validateRequired(v, 'full name'),
          ),

          const SizedBox(height: 20),

          // Address
          _buildLabel('Address'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _addressController,
            hint: 'Enter your home address',
            prefixIcon: Icons.home_outlined,
            validator: (v) => _validateRequired(v, 'address'),
            maxLines: 2,
          ),

          const SizedBox(height: 20),

          // Phone (optional)
          _buildLabel('Phone Number'),
          const SizedBox(height: 2),
          Text('Optional', style: AppTextStyles.small),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _phoneController,
            hint: 'e.g. 071 234 5678',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 20),

          // Village / Division dropdown
          _buildLabel('Village / Division'),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: _selectedVillage,
            hint: Text(
              'Select your village',
              style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
            ),
            onChanged: (val) => setState(() => _selectedVillage = val),
            style: AppTextStyles.body,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textMuted,
            ),
            decoration: _inputDecoration(prefixIcon: Icons.location_on_outlined),
            items: _villages
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
          ),

          const SizedBox(height: 32),

          // Next button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('NEXT', style: AppTextStyles.button),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Already have an account
          _buildLoginLink(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Step 2 -- Password & Terms
  // ------------------------------------------------------------------

  Widget _buildStep2() {
    return Form(
      key: _step2Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          Text(
            'Create Password',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 4),
          Text(
            'Choose a strong password to secure your account',
            style: AppTextStyles.caption,
          ),

          const SizedBox(height: 28),

          // Password
          _buildLabel('Password'),
          const SizedBox(height: 6),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            validator: _validatePassword,
            style: AppTextStyles.body,
            decoration: _inputDecoration(
              prefixIcon: Icons.lock_outline_rounded,
              hint: 'At least 6 characters',
            ).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                  size: 22,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                splashRadius: 24,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Confirm Password
          _buildLabel('Confirm Password'),
          const SizedBox(height: 6),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirm,
            validator: _validateConfirmPassword,
            style: AppTextStyles.body,
            decoration: _inputDecoration(
              prefixIcon: Icons.lock_outline_rounded,
              hint: 'Re-enter your password',
            ).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                  size: 22,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                splashRadius: 24,
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Terms & Privacy checkbox
          InkWell(
            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: (val) =>
                          setState(() => _agreedToTerms = val ?? false),
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text.rich(
                        TextSpan(
                          text: 'I agree to the ',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of Service',
                              style: AppTextStyles.bodySemiBold.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTextStyles.bodySemiBold.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Register button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                disabledBackgroundColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text('REGISTER', style: AppTextStyles.button),
            ),
          ),

          const SizedBox(height: 24),

          // Already have an account
          _buildLoginLink(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Reusable widgets
  // ------------------------------------------------------------------

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.label);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTextStyles.body,
      decoration: _inputDecoration(prefixIcon: prefixIcon, hint: hint),
    );
  }

  InputDecoration _inputDecoration({
    required IconData prefixIcon,
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
      prefixIcon: Icon(prefixIcon, color: AppColors.textMuted, size: 22),
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: _goToLogin,
          child: Text(
            'Login',
            style: AppTextStyles.bodySemiBold.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
