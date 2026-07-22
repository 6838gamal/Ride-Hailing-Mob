import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppSpacing — Design System Spacing, Radius, Elevation & Shadows
/// نظام المسافات والزوايا والظلال
class AppSpacing {
  AppSpacing._();

  // ─── Spacing Scale (4pt grid) | سلم المسافات ──────────────────────────────
  static const double xs2 = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xl2 = 32;
  static const double xl3 = 40;
  static const double xl4 = 48;
  static const double xl5 = 56;
  static const double xl6 = 64;
  static const double xl7 = 80;
  static const double xl8 = 96;

  // ─── Semantic Spacing | مسافات دلالية ────────────────────────────────────
  static const double screenPadding = 20;
  static const double cardPadding = 20;
  static const double sectionSpacing = 32;
  static const double itemSpacing = 12;
  static const double iconSpacing = 8;
  static const double buttonHeight = 56;
  static const double inputHeight = 56;
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 80;
  static const double bottomSheetRadius = 28;
  static const double sheetHandleHeight = 4;
  static const double sheetHandleWidth = 40;

  // Safe area helpers
  static const double bottomSafeArea = 34; // iOS safe area approximation
  static const double topSafeArea = 44;

  // Map UI
  static const double mapButtonSize = 48;
  static const double mapButtonRadius = 14;
  static const double markerSize = 48;
  static const double carMarkerSize = 56;

  // Touch targets (min 44pt per WCAG)
  static const double minTouchTarget = 44;
  static const double iconButtonSize = 44;
}

/// AppRadius — Border Radius Tokens
/// رموز نصف قطر الحواف
class AppRadius {
  AppRadius._();

  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 14;
  static const double lg = 16;
  static const double xl = 20;
  static const double xl2 = 24;
  static const double xl3 = 28;
  static const double full = 100;

  static const BorderRadius roundedNone = BorderRadius.zero;
  static const BorderRadius roundedXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius roundedBase = BorderRadius.all(Radius.circular(base));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius roundedXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius roundedXl2 = BorderRadius.all(Radius.circular(xl2));
  static const BorderRadius roundedXl3 = BorderRadius.all(Radius.circular(xl3));
  static const BorderRadius roundedFull = BorderRadius.all(Radius.circular(full));

  static const BorderRadius sheetTop = BorderRadius.vertical(
    top: Radius.circular(28),
  );
}

/// AppShadows — Elevation & Shadow Tokens
/// رموز الظل والارتفاع
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get none => [];

  static List<BoxShadow> get xs => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.04),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get sm => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: AppColors.black.withOpacity(0.04),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get md => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: AppColors.black.withOpacity(0.04),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get lg => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.10),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: AppColors.black.withOpacity(0.06),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get xl => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.14),
          blurRadius: 48,
          offset: const Offset(0, 16),
        ),
        BoxShadow(
          color: AppColors.black.withOpacity(0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get primaryGlow => [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.36),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get accentGlow => [
        BoxShadow(
          color: AppColors.accent.withOpacity(0.4),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get mapCard => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.12),
          blurRadius: 24,
          spreadRadius: 0,
          offset: const Offset(0, -4),
        ),
      ];
}
