import 'package:flutter/material.dart';

/// Village Connect — Professional color palette.
///
/// Replaces the flat-pastel "AI-generated" palette with a layered surface
/// system and semantic accent colours that feel deliberate and trustworthy.
/// Inspired by shadcn/ui (Zinc palette).
class AppColors {
  AppColors._();

  // ── Zinc Palette ────────────────────────────────────────────────────────
  static const Color zinc50 = Color(0xFFFAFAFA);
  static const Color zinc100 = Color(0xFFF4F4F5);
  static const Color zinc200 = Color(0xFFE4E4E7);
  static const Color zinc300 = Color(0xFFD4D4D8);
  static const Color zinc400 = Color(0xFFA1A1AA);
  static const Color zinc500 = Color(0xFF71717A);
  static const Color zinc600 = Color(0xFF52525B);
  static const Color zinc700 = Color(0xFF3F3F46);
  static const Color zinc800 = Color(0xFF27272A);
  static const Color zinc900 = Color(0xFF18181B);
  static const Color zinc950 = Color(0xFF09090B);

  // ── Brand Colors ────────────────────────────────────────────────────────
  static const Color brandBlue = Color(0xFF0284C7); // Sky 600
  static const Color primaryDark = Color(0xFF0369A1); // Sky 700
  static const Color primaryAction = Color(0xFF1e293b); // Slate 800
  static const Color primaryColor = Color(0xFF2563EB); // Blue 600

  // ── Colors Mapped to Role ───────────────────────────────────────────────

  static const Color primary = Color(0xFF18181B); // Zinc 900 (Like shadcn default)
  static const Color onPrimary = Color(0xFFFAFAFA); // Zinc 50

  static const Color secondary = Color(0xFFF4F4F5); // Zinc 100
  static const Color onSecondary = Color(0xFF18181B); // Zinc 900

  static const Color destructive = Color(0xFFEF4444); // Red 500
  static const Color destructiveLight = Color(0xFFFEF2F2); // Red 50

  static const Color muted = Color(0xFFF4F4F5); // Zinc 100
  static const Color onMuted = Color(0xFF71717A); // Zinc 500

  static const Color accent = Color(0xFFF4F4F5); // Zinc 100
  static const Color onAccent = Color(0xFF18181B); // Zinc 900

  static const Color popover = Color(0xFFFFFFFF);
  static const Color onPopover = Color(0xFF18181B); // Zinc 900

  static const Color card = Color(0xFFFFFFFF);
  static const Color onCard = Color(0xFF18181B); // Zinc 900

  // ── Surfaces ────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF); // White background for cleanliness
  static const Color surfaceGrey = Color(0xFFF4F4F5); // Zinc 100
  static const Color secondarySurface = Color(0xFFE4E4E7); // Zinc 200

  // ── Text ────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF09090B); // Zinc 950
  static const Color textSecondary = Color(0xFF71717A); // Zinc 500
  static const Color textMuted = Color(0xFFA1A1AA); // Zinc 400
  static const Color textOnPrimary = Color(0xFFFAFAFA); // Zinc 50

  // ── Semantic Status ─────────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successLight = Color(0xFFECFDF5); // Emerald 50
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningLight = Color(0xFFFFFBEB); // Amber 50
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorLight = Color(0xFFFEF2F2); // Red 50
  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoLight = Color(0xFFEFF6FF); // Blue 50

  // ── Borders / Dividers ──────────────────────────────────────────────────
  static const Color border = Color(0xFFE4E4E7); // Zinc 200
  static const Color input = Color(0xFFE4E4E7); // Zinc 200
  static const Color divider = Color(0xFFE4E4E7); // Zinc 200
  static const Color ring = Color(0xFF18181B); // Zinc 900 (Focus ring)

  // ── Disabled ────────────────────────────────────────────────────────────
  static const Color disabled = Color(0xFFA1A1AA); // Zinc 400
  static const Color disabledBackground = Color(0xFFF4F4F5); // Zinc 100

  // ── Shadow ──────────────────────────────────────────────────────────────
  static final Color shadow = const Color(0xFF000000).withOpacity(0.05);
  static final Color shadowLight = const Color(0xFF000000).withOpacity(0.02);

  // ── Legacy Aliases ──────────────────────────────────────────────────────
  // Needed to keep existing code working until refactored
  static const Color primaryLight = Color(0xFFF4F4F5); // Zinc 100
  static const Color primaryDarkLegacy = Color(0xFF18181B); // Zinc 900

  static const Color brand = Color(0xFF2563EB); // Blue 600

  // Legacy accents mapped to new semantic colors or variants
  static const Color accentBlue = infoLight;
  static const Color accentGreen = successLight;
  static const Color accentRed = errorLight;
  static const Color accentYellow = warningLight;
  static const Color accentPurple = infoLight;

  // ── Gradient helpers ────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF18181B), Color(0xFF27272A)], // Zinc 900 -> Zinc 800
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF18181B), Color(0xFF27272A)],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFFAFAFA)],
  );
}
