import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DocumentRequestScreen extends StatefulWidget {
  const DocumentRequestScreen({super.key});

  @override
  State<DocumentRequestScreen> createState() => _DocumentRequestScreenState();
}

class _DocumentRequestScreenState extends State<DocumentRequestScreen> {
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Step 1
  int _selectedDocumentIndex = -1;

  // Step 2
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _nicController = TextEditingController();
  final _addressController = TextEditingController();
  final _reasonController = TextEditingController();

  // Step 3
  final List<Map<String, String>> _uploadedFiles = [
    {'name': 'NIC_front.jpg', 'size': '245 KB'},
    {'name': 'NIC_back.jpg', 'size': '198 KB'},
  ];

  // Step 4
  bool _confirmChecked = false;

  final List<Map<String, dynamic>> _documentTypes = [
    {'title': 'Character Certificate', 'icon': Icons.verified_user_outlined},
    {'title': 'Residence Certificate', 'icon': Icons.home_outlined},
    {'title': 'Income Certificate', 'icon': Icons.account_balance_wallet_outlined},
    {'title': 'Birth Certificate', 'icon': Icons.child_care_outlined},
    {'title': 'Identity Verification', 'icon': Icons.badge_outlined},
    {'title': 'Land Ownership Certificate', 'icon': Icons.landscape_outlined},
  ];

  final List<String> _stepLabels = [
    'Select Type',
    'Enter Details',
    'Upload Files',
    'Confirm & Submit',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicController.dispose();
    _addressController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _selectedDocumentIndex >= 0;
      case 1:
        return _fullNameController.text.trim().isNotEmpty &&
            _nicController.text.trim().isNotEmpty &&
            _addressController.text.trim().isNotEmpty &&
            _reasonController.text.trim().isNotEmpty;
      case 2:
        return true;
      case 3:
        return _confirmChecked;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_currentStep == 1 && !_formKey.currentState!.validate()) {
      return;
    }
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitApplication() {
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.success,
                size: 44,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Application Submitted Successfully!',
              style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildSuccessInfoRow(
                    'Tracking ID',
                    'VC-2026-00142',
                    isBold: true,
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.divider, height: 1),
                  const SizedBox(height: 12),
                  _buildSuccessInfoRow(
                    'Estimated Processing',
                    '3-5 working days',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text('Track Application', style: AppTextStyles.button),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Back to Home',
                  style: AppTextStyles.button.copyWith(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessInfoRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(
          value,
          style: isBold
              ? AppTextStyles.bodySemiBold.copyWith(color: AppColors.primary)
              : AppTextStyles.bodyMedium,
        ),
      ],
    );
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
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Apply for Document',
          style: AppTextStyles.h3.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.divider,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildCurrentStep(),
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        children: [
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: AppTextStyles.captionMedium.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_totalSteps, (index) {
              Color barColor;
              if (index < _currentStep) {
                barColor = AppColors.success;
              } else if (index == _currentStep) {
                barColor = AppColors.primary;
              } else {
                barColor = AppColors.disabledBackground;
              }
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < _totalSteps - 1 ? 6 : 0),
                  height: 5,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_totalSteps, (index) {
              final isActive = index == _currentStep;
              final isCompleted = index < _currentStep;
              return Expanded(
                child: Text(
                  _stepLabels[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.small.copyWith(
                    color: isActive
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.textMuted,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 11,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1SelectType();
      case 1:
        return _buildStep2EnterDetails();
      case 2:
        return _buildStep3UploadFiles();
      case 3:
        return _buildStep4Confirm();
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------------------------------------------------------------------------
  // Step 1: Select Document Type
  // ---------------------------------------------------------------------------
  Widget _buildStep1SelectType() {
    return SingleChildScrollView(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What document do you need?', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Text(
            'Select the type of document you wish to request.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 20),
          ...List.generate(_documentTypes.length, (index) {
            final doc = _documentTypes[index];
            final isSelected = _selectedDocumentIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedDocumentIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accentBlue
                          : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            doc['icon'] as IconData,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            doc['title'] as String,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        else
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.border,
                                width: 1.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2: Enter Details
  // ---------------------------------------------------------------------------
  Widget _buildStep2EnterDetails() {
    return SingleChildScrollView(
      key: const ValueKey('step2'),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your details', style: AppTextStyles.h3),
            const SizedBox(height: 6),
            Text(
              'Please provide accurate information for your application.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 24),
            _buildFormField(
              label: 'Full Name',
              controller: _fullNameController,
              hint: 'Enter your full name as per NIC',
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Full name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            _buildFormField(
              label: 'NIC Number',
              controller: _nicController,
              hint: 'e.g., 200012345678',
              icon: Icons.credit_card_outlined,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'NIC number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            _buildFormField(
              label: 'Address',
              controller: _addressController,
              hint: 'Enter your permanent address',
              icon: Icons.location_on_outlined,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Address is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            _buildFormField(
              label: 'Reason for Request',
              controller: _reasonController,
              hint: 'Why do you need this document?',
              icon: Icons.edit_note_rounded,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Reason is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
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
          validator: validator,
          onChanged: (_) => setState(() {}),
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 14, right: 10),
              child: Icon(icon, color: AppColors.textMuted, size: 22),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),
            filled: true,
            fillColor: AppColors.card,
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
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3: Upload Files
  // ---------------------------------------------------------------------------
  Widget _buildStep3UploadFiles() {
    return SingleChildScrollView(
      key: const ValueKey('step3'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload supporting documents', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Text(
            'Attach copies of relevant documents to support your application.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 24),
          // Upload area
          InkWell(
            onTap: () {
              // File upload logic would go here
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: CustomPaint(
                painter: _DashedBorderPainter(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  borderRadius: 12,
                  dashWidth: 8,
                  dashSpace: 5,
                  strokeWidth: 1.5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Tap to upload or take a photo',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Accepted: JPG, PNG, PDF (max 5MB)',
                      style: AppTextStyles.small,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_uploadedFiles.isNotEmpty) ...[
            Text(
              'Uploaded Files',
              style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            ...List.generate(_uploadedFiles.length, (index) {
              final file = _uploadedFiles[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.insert_drive_file_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file['name']!,
                            style: AppTextStyles.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            file['size']!,
                            style: AppTextStyles.small,
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _uploadedFiles.removeAt(index);
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accentRed,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.error,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 4: Confirm & Submit
  // ---------------------------------------------------------------------------
  Widget _buildStep4Confirm() {
    final selectedDocType = _selectedDocumentIndex >= 0
        ? _documentTypes[_selectedDocumentIndex]['title'] as String
        : 'Not selected';

    return SingleChildScrollView(
      key: const ValueKey('step4'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review your application', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Text(
            'Please verify all details before submitting.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 24),
          // Summary card
          Container(
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
                _buildSummaryRow(
                  Icons.description_outlined,
                  'Document Type',
                  selectedDocType,
                ),
                _buildSummaryDivider(),
                _buildSummaryRow(
                  Icons.person_outline_rounded,
                  'Full Name',
                  _fullNameController.text.isNotEmpty
                      ? _fullNameController.text
                      : '-',
                ),
                _buildSummaryDivider(),
                _buildSummaryRow(
                  Icons.credit_card_outlined,
                  'NIC Number',
                  _nicController.text.isNotEmpty ? _nicController.text : '-',
                ),
                _buildSummaryDivider(),
                _buildSummaryRow(
                  Icons.location_on_outlined,
                  'Address',
                  _addressController.text.isNotEmpty
                      ? _addressController.text
                      : '-',
                ),
                _buildSummaryDivider(),
                _buildSummaryRow(
                  Icons.edit_note_rounded,
                  'Reason',
                  _reasonController.text.isNotEmpty
                      ? _reasonController.text
                      : '-',
                ),
                _buildSummaryDivider(),
                _buildSummaryRow(
                  Icons.attach_file_rounded,
                  'Uploaded Files',
                  '${_uploadedFiles.length} file(s)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Confirmation checkbox
          InkWell(
            onTap: () {
              setState(() {
                _confirmChecked = !_confirmChecked;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _confirmChecked ? AppColors.accentGreen : AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _confirmChecked
                      ? AppColors.success.withValues(alpha: 0.4)
                      : AppColors.border,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _confirmChecked,
                      onChanged: (value) {
                        setState(() {
                          _confirmChecked = value ?? false;
                        });
                      },
                      activeColor: AppColors.success,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(color: AppColors.border, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'I confirm that the information provided above is accurate and complete to the best of my knowledge.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.textMuted, size: 20),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: AppTextStyles.caption,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryDivider() {
    return const Divider(color: AppColors.divider, height: 1);
  }

  // ---------------------------------------------------------------------------
  // Bottom Navigation
  // ---------------------------------------------------------------------------
  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        16 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Back button (hidden on step 1)
          if (_currentStep > 0)
            Expanded(
              child: SizedBox(
                height: 52,
                child: TextButton(
                  onPressed: _previousStep,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back_rounded, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Back',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          // Next / Submit button
          Expanded(
            flex: _currentStep > 0 ? 2 : 1,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _canProceed
                    ? (_currentStep == _totalSteps - 1
                        ? _submitApplication
                        : _nextStep)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  disabledBackgroundColor: AppColors.disabledBackground,
                  disabledForegroundColor: AppColors.disabled,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentStep == _totalSteps - 1
                          ? 'Submit Application'
                          : 'Next',
                      style: AppTextStyles.button.copyWith(
                        color: _canProceed
                            ? AppColors.textOnPrimary
                            : AppColors.disabled,
                      ),
                    ),
                    if (_currentStep < _totalSteps - 1) ...[
                      const SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: _canProceed
                            ? AppColors.textOnPrimary
                            : AppColors.disabled,
                      ),
                    ],
                    if (_currentStep == _totalSteps - 1) ...[
                      const SizedBox(width: 6),
                      Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: _canProceed
                            ? AppColors.textOnPrimary
                            : AppColors.disabled,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for dashed border on the upload area
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  _DashedBorderPainter({
    required this.color,
    required this.borderRadius,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? dashWidth : dashSpace;
        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
