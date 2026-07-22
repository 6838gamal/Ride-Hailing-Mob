import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../app.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/animation_constants.dart';

/// SplashScreen — Animated brand splash
/// شاشة البداية المتحركة
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _carController;
  late Animation<double> _carX;

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _carController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _carX = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(parent: _carController, curve: Curves.easeOutCubic),
    );

    // Sequence: bg → logo → car → navigate
    Future.delayed(const Duration(milliseconds: 200), () {
      _bgController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _carController.forward();
    });
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) context.go(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          // Animated background gradient
          AnimatedBuilder(
            animation: _bgController,
            builder: (_, __) => Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.3, -0.4),
                  radius: 1.2 * _bgController.value + 0.3,
                  colors: const [
                    Color(0xFF1B4FFF),
                    AppColors.primaryDark,
                  ],
                ),
              ),
            ),
          ),

          // Decorative circles
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.12),
              ),
            )
                .animate(controller: _bgController)
                .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                .fade(),
          ),
          Positioned(
            bottom: -120,
            left: -60,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.08),
              ),
            )
                .animate(controller: _bgController)
                .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                .fade(delay: 200.ms),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo icon
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.4),
                        blurRadius: 32,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_taxi_rounded,
                    color: AppColors.black,
                    size: 48,
                  ),
                )
                    .animate()
                    .fade(delay: 400.ms, duration: 600.ms)
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1, 1),
                      delay: 400.ms,
                      curve: Curves.elasticOut,
                      duration: 800.ms,
                    ),

                const SizedBox(height: 24),

                // App name
                Text(
                  'RideGo',
                  style: AppTypography.headlineLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                )
                    .animate()
                    .fade(delay: 700.ms, duration: 500.ms)
                    .slideY(begin: 0.3, end: 0, delay: 700.ms),

                const SizedBox(height: 8),

                Text(
                  'Your ride, on demand',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white.withOpacity(0.6),
                  ),
                )
                    .animate()
                    .fade(delay: 900.ms, duration: 500.ms),
              ],
            ),
          ),

          // Animated car at bottom
          Positioned(
            bottom: 80,
            child: AnimatedBuilder(
              animation: _carX,
              builder: (_, __) {
                return Transform.translate(
                  offset: Offset(_carX.value, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CarSvg(
                          width: 160,
                          color: AppColors.accent,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Version text
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Text(
              'v1.0.0',
              textAlign: TextAlign.center,
              style: AppTypography.caption,
            ).animate().fade(delay: 1200.ms),
          ),
        ],
      ),
    );
  }
}

/// Simple car illustration widget
class _CarSvg extends StatelessWidget {
  final double width;
  final Color color;

  const _CarSvg({required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width * 0.45,
      child: CustomPaint(
        painter: _CarPainter(color: color),
      ),
    );
  }
}

class _CarPainter extends CustomPainter {
  final Color color;
  _CarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final bodyPaint = Paint()..color = color.withOpacity(0.9);
    final windowPaint = Paint()
      ..color = AppColors.primaryDark.withOpacity(0.7);
    final wheelPaint = Paint()..color = AppColors.grey800;
    final rimPaint = Paint()..color = AppColors.grey400;

    // Car body
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.05, size.height * 0.6);
    bodyPath.lineTo(size.width * 0.18, size.height * 0.25);
    bodyPath.quadraticBezierTo(
        size.width * 0.28, size.height * 0.1, size.width * 0.42, size.height * 0.1);
    bodyPath.lineTo(size.width * 0.62, size.height * 0.1);
    bodyPath.quadraticBezierTo(
        size.width * 0.76, size.height * 0.1, size.width * 0.84, size.height * 0.25);
    bodyPath.lineTo(size.width * 0.97, size.height * 0.6);
    bodyPath.close();
    canvas.drawPath(bodyPath, bodyPaint);

    // Lower body (bumpers)
    final lowerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.03,
        size.height * 0.55,
        size.width * 0.94,
        size.height * 0.2,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(lowerRect, paint);

    // Windows
    final windowPath = Path();
    windowPath.moveTo(size.width * 0.22, size.height * 0.52);
    windowPath.lineTo(size.width * 0.28, size.height * 0.22);
    windowPath.lineTo(size.width * 0.48, size.height * 0.18);
    windowPath.lineTo(size.width * 0.48, size.height * 0.52);
    windowPath.close();
    canvas.drawPath(windowPath, windowPaint);

    final window2Path = Path();
    window2Path.moveTo(size.width * 0.52, size.height * 0.52);
    window2Path.lineTo(size.width * 0.52, size.height * 0.18);
    window2Path.lineTo(size.width * 0.72, size.height * 0.22);
    window2Path.lineTo(size.width * 0.78, size.height * 0.52);
    window2Path.close();
    canvas.drawPath(window2Path, windowPaint);

    // Wheels
    canvas.drawCircle(Offset(size.width * 0.22, size.height * 0.78), size.height * 0.22, wheelPaint);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.78), size.height * 0.22, wheelPaint);
    canvas.drawCircle(Offset(size.width * 0.22, size.height * 0.78), size.height * 0.11, rimPaint);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.78), size.height * 0.11, rimPaint);
  }

  @override
  bool shouldRepaint(_CarPainter old) => old.color != color;
}
