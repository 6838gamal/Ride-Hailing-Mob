import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/app_button.dart';

/// OnboardingScreen — Premium animated onboarding flow
/// شاشة الإعداد الأولي المتحركة
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _slides = [
    _OnboardingData(
      titleEn: 'Get There Fast',
      titleAr: 'وصل بسرعة',
      subtitleEn: 'Book a ride in seconds.\nYour driver arrives in minutes.',
      subtitleAr: 'احجز رحلتك في ثوانٍ.\nسائقك يصل في دقائق.',
      icon: Icons.rocket_launch_rounded,
      color: AppColors.primary,
      bgColor: AppColors.primaryLighter,
    ),
    _OnboardingData(
      titleEn: 'Track in Real Time',
      titleAr: 'تتبع في الوقت الحقيقي',
      subtitleEn: 'See your driver live on the map\nfrom pickup to drop-off.',
      subtitleAr: 'شاهد سائقك على الخريطة\nمن لحظة الانطلاق حتى الوصول.',
      icon: Icons.location_on_rounded,
      color: const Color(0xFF10B981),
      bgColor: const Color(0xFFD1FAE5),
    ),
    _OnboardingData(
      titleEn: 'Pay Your Way',
      titleAr: 'ادفع بطريقتك',
      subtitleEn: 'Cash, card, or wallet —\nyou choose how to pay.',
      subtitleAr: 'نقداً أو بطاقة أو محفظة —\nأنت تختار طريقة الدفع.',
      icon: Icons.payments_rounded,
      color: const Color(0xFFF59E0B),
      bgColor: const Color(0xFFFEF3C7),
    ),
  ];

  void _onNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.base),
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: Text(
                    'Skip',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ),
              ),
            ).animate().fade(delay: 300.ms),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (_, index) =>
                    _OnboardingPage(data: _slides[index], isActive: index == _currentPage),
              ),
            ),

            // Bottom controls
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.xl,
                AppSpacing.screenPadding,
                AppSpacing.xl2,
              ),
              child: Column(
                children: [
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _slides.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: _slides[_currentPage].color,
                      dotColor: AppColors.grey300,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl2),

                  // CTA Button
                  AppButton(
                    label: _currentPage == _slides.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onTap: _onNext,
                    gradient: LinearGradient(
                      colors: [
                        _slides[_currentPage].color,
                        _slides[_currentPage].color.withOpacity(0.7),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.base),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTypography.bodySmall,
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutes.login),
                        child: Text(
                          'Sign In',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const _OnboardingData({
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  final bool isActive;

  const _OnboardingPage({required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            width: isActive ? 220 : 180,
            height: isActive ? 220 : 180,
            decoration: BoxDecoration(
              color: data.bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.color.withOpacity(0.2),
                  blurRadius: 48,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Icon(
              data.icon,
              size: isActive ? 88 : 72,
              color: data.color,
            ),
          ),

          const SizedBox(height: AppSpacing.xl3),

          // Title
          Text(
            data.titleEn,
            textAlign: TextAlign.center,
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.grey900,
            ),
          ).animate(target: isActive ? 1 : 0).fade().slideY(begin: 0.2, end: 0),

          const SizedBox(height: AppSpacing.base),

          // Subtitle
          Text(
            data.subtitleEn,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.grey600,
              height: 1.6,
            ),
          ).animate(target: isActive ? 1 : 0).fade(delay: 100.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}
