/// AppConstants — Application-wide Constants
/// ثوابت التطبيق
class AppConstants {
  AppConstants._();

  // ─── App Info | معلومات التطبيق ───────────────────────────────────────────
  static const String appName = 'RideGo';
  static const String appNameAr = 'رايد جو';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your ride, on demand';
  static const String appTaglineAr = 'رحلتك، في أي وقت';

  // ─── Map | الخريطة ────────────────────────────────────────────────────────
  static const double defaultLat = 24.7136;   // Riyadh
  static const double defaultLng = 46.6753;
  static const double defaultZoom = 14.0;
  static const double nearbyDriversZoom = 13.5;
  static const double tripZoom = 15.0;
  static const double searchZoom = 12.0;
  static const double searchRadius = 5000.0;  // meters

  // ─── Ride Types | أنواع الرحلات ──────────────────────────────────────────
  static const List<Map<String, dynamic>> rideTypes = [
    {
      'id': 'economy',
      'nameEn': 'Economy',
      'nameAr': 'اقتصادي',
      'icon': '🚗',
      'capacity': 4,
      'baseFare': 5.0,
      'perKm': 1.2,
      'perMin': 0.2,
      'eta': '3 min',
    },
    {
      'id': 'comfort',
      'nameEn': 'Comfort',
      'nameAr': 'مريح',
      'icon': '🚙',
      'capacity': 4,
      'baseFare': 8.0,
      'perKm': 1.8,
      'perMin': 0.3,
      'eta': '5 min',
    },
    {
      'id': 'premium',
      'nameEn': 'Premium',
      'nameAr': 'بريميوم',
      'icon': '🏎️',
      'capacity': 4,
      'baseFare': 15.0,
      'perKm': 2.8,
      'perMin': 0.5,
      'eta': '7 min',
    },
    {
      'id': 'xl',
      'nameEn': 'XL',
      'nameAr': 'XL كبير',
      'icon': '🚐',
      'capacity': 7,
      'baseFare': 10.0,
      'perKm': 2.0,
      'perMin': 0.35,
      'eta': '6 min',
    },
  ];

  // ─── Payment Methods | طرق الدفع ─────────────────────────────────────────
  static const List<Map<String, String>> paymentMethods = [
    {'id': 'cash', 'nameEn': 'Cash', 'nameAr': 'نقداً', 'icon': '💵'},
    {'id': 'card', 'nameEn': 'Credit Card', 'nameAr': 'بطاقة ائتمان', 'icon': '💳'},
    {'id': 'wallet', 'nameEn': 'Wallet', 'nameAr': 'المحفظة', 'icon': '👛'},
    {'id': 'apple_pay', 'nameEn': 'Apple Pay', 'nameAr': 'Apple Pay', 'icon': ''},
    {'id': 'google_pay', 'nameEn': 'Google Pay', 'nameAr': 'Google Pay', 'icon': ''},
  ];

  // ─── Animations | الحركات ────────────────────────────────────────────────
  static const int searchingDriverPulseCount = 3;
  static const double nearbyCarAnimationRadius = 120.0;

  // ─── Rating | التقييم ────────────────────────────────────────────────────
  static const int maxRating = 5;
  static const double minGoodRating = 4.0;

  // ─── Trip | الرحلة ────────────────────────────────────────────────────────
  static const int driverSearchTimeoutSeconds = 120;
  static const int driverArrivalBufferMinutes = 2;
  static const int waitingFreeMinutes = 3;

  // ─── Onboarding | الإعداد الأولي ────────────────────────────────────────
  static const List<Map<String, String>> onboardingSlides = [
    {
      'titleEn': 'Get There Fast',
      'titleAr': 'وصل بسرعة',
      'subtitleEn': 'Book a ride in seconds.\nYour driver arrives in minutes.',
      'subtitleAr': 'احجز رحلتك في ثوانٍ.\nسائقك يصل في دقائق.',
      'animation': 'assets/animations/onboarding_1.json',
    },
    {
      'titleEn': 'Track in Real Time',
      'titleAr': 'تتبع في الوقت الحقيقي',
      'subtitleEn': 'See your driver live on the map\nfrom pickup to drop-off.',
      'subtitleAr': 'شاهد سائقك على الخريطة\nمن لحظة الانطلاق حتى الوصول.',
      'animation': 'assets/animations/onboarding_2.json',
    },
    {
      'titleEn': 'Pay Your Way',
      'titleAr': 'ادفع بطريقتك',
      'subtitleEn': 'Cash, card, or wallet —\nyou choose how to pay.',
      'subtitleAr': 'نقداً أو بطاقة أو محفظة —\nأنت تختار طريقة الدفع.',
      'animation': 'assets/animations/onboarding_3.json',
    },
  ];
}
