import 'package:flutter/material.dart';

/// AnimationConstants — Complete Motion Design Specifications
/// مواصفات Motion Design الكاملة للتطبيق
class AnimationConstants {
  AnimationConstants._();

  // ─── Duration | المدة الزمنية ─────────────────────────────────────────────
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 700);
  static const Duration slowest = Duration(milliseconds: 1000);

  // Page transitions | انتقالات الصفحة
  static const Duration pageTransition = Duration(milliseconds: 400);
  static const Duration heroTransition = Duration(milliseconds: 500);
  static const Duration sharedElement = Duration(milliseconds: 600);

  // Map animations | حركات الخريطة
  static const Duration mapCameraMove = Duration(milliseconds: 800);
  static const Duration mapZoom = Duration(milliseconds: 500);
  static const Duration carMovement = Duration(milliseconds: 200);
  static const Duration routeDraw = Duration(milliseconds: 1200);

  // Bottom sheets | الأوراق السفلية
  static const Duration sheetExpand = Duration(milliseconds: 400);
  static const Duration sheetCollapse = Duration(milliseconds: 300);

  // State animations | حركات الحالة
  static const Duration searchPulse = Duration(milliseconds: 1500);
  static const Duration loadingLoop = Duration(milliseconds: 1200);
  static const Duration successCelebration = Duration(milliseconds: 800);
  static const Duration errorShake = Duration(milliseconds: 400);

  // ─── Curves | منحنيات الحركة ──────────────────────────────────────────────
  /// Standard easing — for elements entering the screen
  /// Easing قياسي — للعناصر التي تدخل الشاشة
  static const Curve easeIn = Curves.easeIn;

  /// Standard easing — for elements leaving the screen
  /// Easing قياسي — للعناصر التي تغادر الشاشة
  static const Curve easeOut = Curves.easeOut;

  /// Standard easing — for elements staying on screen
  static const Curve easeInOut = Curves.easeInOut;

  /// Decelerate — premium feel for page entry
  /// تباطؤ — شعور Premium لدخول الصفحات
  static const Curve decelerate = Curves.decelerate;

  /// Spring physics — for interactive elements
  /// فيزياء الزنبرك — للعناصر التفاعلية
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve bounceOut = Curves.bounceOut;

  /// Emphasized curve — Material You standard
  static const Curve emphasizedDecelerate = Curves.easeOutCubic;
  static const Curve emphasizedAccelerate = Curves.easeInCubic;
  static const Curve emphasizedStandard = Curves.easeInOutCubic;

  // ─── Spring Physics | فيزياء الزنبرك ─────────────────────────────────────
  // For bottom sheets and drag interactions
  static const double springMass = 1.0;
  static const double springStiffness = 500.0;
  static const double springDamping = 28.0;

  // For card expansion
  static const double cardSpringMass = 1.0;
  static const double cardSpringStiffness = 300.0;
  static const double cardSpringDamping = 24.0;

  // ─── Scale Values | قيم التحجيم ─────────────────────────────────────────
  static const double buttonPressScale = 0.96;
  static const double cardPressScale = 0.98;
  static const double vehicleSelectScale = 1.06;
  static const double markerBounceScale = 1.3;

  // ─── Opacity Values | قيم الشفافية ───────────────────────────────────────
  static const double ghostOpacity = 0.0;
  static const double disabledOpacity = 0.38;
  static const double hintOpacity = 0.6;
  static const double overlayLight = 0.08;
  static const double overlayMedium = 0.16;
  static const double overlayStrong = 0.54;
  static const double overlayDark = 0.72;

  // ─── Pulse Animation | حركة النبض ────────────────────────────────────────
  // Used for searching driver state
  static const double pulseMinScale = 0.85;
  static const double pulseMaxScale = 1.15;
  static const int pulseRings = 3;
  static const Duration pulseRingDelay = Duration(milliseconds: 400);

  // ─── Stagger Delays | تأخيرات متتالية ────────────────────────────────────
  static const Duration staggerBase = Duration(milliseconds: 80);
  static const Duration staggerMedium = Duration(milliseconds: 120);
  static const Duration staggerSlow = Duration(milliseconds: 160);

  // ─── Rotation | الدوران ──────────────────────────────────────────────────
  static const double carRotationSmooth = 0.1; // lerp factor for car heading
  static const Duration carHeadingUpdate = Duration(milliseconds: 300);

  // ─── Elevation Animation | حركة الارتفاع ────────────────────────────────
  static const Duration elevationTransition = Duration(milliseconds: 200);
}
