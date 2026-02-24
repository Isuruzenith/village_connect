import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class VcButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType type;
  final IconData? icon;
  final double? width;

  const VcButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return SizedBox(
          width: width ?? double.infinity,
          height: 48, // Standard shadcn height is usually smaller, but 48 is good for touch
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: _buildChild(AppColors.onPrimary),
          ),
        );
      case ButtonType.secondary:
        // Mapping "Secondary" to shadcn "Outline" or "Secondary"
        // Let's use "Outline" style as it's a common secondary action
        // Or strictly "Secondary" (Zinc 100 bg)
        // Given existing usage was Outlined, let's stick to Outlined but with neutral colors
        return SizedBox(
          width: width ?? double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: _buildChild(AppColors.textPrimary),
          ),
        );
      case ButtonType.text:
        // Mapping "Text" to shadcn "Ghost"
        return SizedBox(
          width: width, // Allow null for intrinsic width
          height: 48,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: _buildChild(AppColors.textPrimary),
          ),
        );
      case ButtonType.danger:
        return SizedBox(
          width: width ?? double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.destructive,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: _buildChild(AppColors.textOnPrimary),
          ),
        );
    }
  }

  Widget _buildChild(Color textColor) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: textColor),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.button.copyWith(color: textColor)),
        ],
      );
    }

    return Text(label, style: AppTextStyles.button.copyWith(color: textColor));
  }
}

enum ButtonType { primary, secondary, text, danger }
