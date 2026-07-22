import 'package:flutter/material.dart';

/// AppColors — Complete Design System Color Tokens
/// نظام الألوان الكامل للتطبيق
class AppColors {
  AppColors._();

  // ─── Brand Colors | ألوان العلامة التجارية ───────────────────────────────
  static const Color primaryDark = Color(0xFF0A1628);
  static const Color primary = Color(0xFF1B4FFF);
  static const Color primaryLight = Color(0xFF4B7BFF);
  static const Color primaryLighter = Color(0xFFE8EEFF);

  static const Color accent = Color(0xFFFFD60A);
  static const Color accentDark = Color(0xFFE6BF00);
  static const Color accentLight = Color(0xFFFFF4B0);

  // ─── Neutral Colors | الألوان المحايدة ───────────────────────────────────
  static const Color black = Color(0xFF0A0A0A);
  static const Color grey900 = Color(0xFF1A1A2E);
  static const Color grey800 = Color(0xFF2D2D44);
  static const Color grey700 = Color(0xFF4A4A6A);
  static const Color grey600 = Color(0xFF6B7280);
  static const Color grey500 = Color(0xFF9CA3AF);
  static const Color grey400 = Color(0xFFD1D5DB);
  static const Color grey300 = Color(0xFFE5E7EB);
  static const Color grey200 = Color(0xFFF3F4F6);
  static const Color grey100 = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);

  // ─── Semantic Colors | الألوان الدلالية ─────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDFEEFF);

  // ─── Surface Colors | ألوان الأسطح ──────────────────────────────────────
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F7FA);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F7FA);

  // Dark Mode Surfaces | أسطح الوضع المظلم
  static const Color darkSurface = Color(0xFF0D0D1A);
  static const Color darkSurfaceVariant = Color(0xFF16213E);
  static const Color darkBackground = Color(0xFF0A0E1A);
  static const Color darkCard = Color(0xFF1A1F35);

  // ─── Map Colors | ألوان الخريطة ─────────────────────────────────────────
  static const Color mapRoute = Color(0xFF1B4FFF);
  static const Color mapRouteAlt = Color(0xFF6B7280);
  static const Color mapPickup = Color(0xFF10B981);
  static const Color mapDropoff = Color(0xFFEF4444);
  static const Color mapSurge = Color(0xFFFF6B35);
  static const Color mapSurgeLight = Color(0x40FF6B35);
  static const Color mapNearbyDriver = Color(0xFF1B4FFF);

  // ─── Vehicle Type Colors | ألوان أنواع المركبات ─────────────────────────
  static const Color vehicleEconomy = Color(0xFF10B981);
  static const Color vehicleComfort = Color(0xFF1B4FFF);
  static const Color vehiclePremium = Color(0xFFFFD60A);
  static const Color vehicleXL = Color(0xFF8B5CF6);

  // ─── Gradients | التدرجات ────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B4FFF), Color(0xFF0A1628)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFD60A), Color(0xFFFF9500)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A1628), Color(0xFF16213E)],
  );

  static const LinearGradient surfaceFadeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)],
  );

  static const LinearGradient darkFadeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x000A0E1A), Color(0xFF0A0E1A)],
  );
}
