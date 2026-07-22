import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pulse_ring_widget.dart';

/// SearchingDriverScreen — Animated driver search state
/// شاشة البحث عن السائق مع حركة النبض
class SearchingDriverScreen extends StatefulWidget {
  const SearchingDriverScreen({super.key});

  @override
  State<SearchingDriverScreen> createState() => _SearchingDriverScreenState();
}

class _SearchingDriverScreenState extends State<SearchingDriverScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotateController;
  int _dots = 0;
  Timer? _timer;
  Timer? _autoAcceptTimer;

  @override
  void initState() {
    super.initState();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    // Animate searching dots
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) setState(() => _dots = (_dots + 1) % 4);
    });

    // Auto-accept after 3 seconds for demo
    _autoAcceptTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) context.go(AppRoutes.driverAccepted);
    });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _timer?.cancel();
    _autoAcceptTimer?.cancel();
    super.dispose();
  }

  String get _dotsStr => '.' * _dots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          // Animated background
          _AnimatedSearchBackground(controller: _rotateController),

          SafeArea(
            child: Column(
              children: [
                // Cancel button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.base),
                    child: TextButton(
                      onPressed: () => context.go(AppRoutes.home),
                      child: Text(
                        'Cancel',
                        style: AppTypography.labelLarge
                            .copyWith(color: AppColors.white.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ).animate().fade(delay: 500.ms),

                const Spacer(),

                // Pulse animation center
                PulseRingWidget(
                  color: AppColors.accent,
                  maxRadius: 90,
                  ringCount: 3,
                  period: const Duration(milliseconds: 2000),
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 32,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.local_taxi_rounded,
                      color: AppColors.black,
                      size: 44,
                    ),
                  ),
                ).animate().scale(
                      begin: const Offset(0.5, 0.5),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                    ),

                const SizedBox(height: AppSpacing.xl3),

                Text(
                  'Finding your driver$_dotsStr',
                  style: AppTypography.headlineSmall
                      .copyWith(color: AppColors.white),
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'This usually takes less than a minute',
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.white.withOpacity(0.6)),
                ),

                const SizedBox(height: AppSpacing.xl3),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl3),
                  child: _SearchProgress(controller: _rotateController),
                ),

                const Spacer(),

                // Trip summary card
                Container(
                  margin: const EdgeInsets.all(AppSpacing.screenPadding),
                  padding: const EdgeInsets.all(AppSpacing.base),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.08),
                    borderRadius: AppRadius.roundedXl,
                    border: Border.all(
                        color: AppColors.white.withOpacity(0.15)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: AppRadius.roundedMd,
                        ),
                        child: const Icon(Icons.directions_car_rounded,
                            color: AppColors.black),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Economy',
                                style: AppTypography.titleSmall.copyWith(
                                    color: AppColors.white)),
                            Text('Riyadh Park Mall',
                                style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.white.withOpacity(0.6))),
                          ],
                        ),
                      ),
                      Text('SAR 14',
                          style: AppTypography.titleMedium
                              .copyWith(color: AppColors.accent)),
                    ],
                  ),
                ).animate().fade(delay: 400.ms).slideY(begin: 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedSearchBackground extends StatelessWidget {
  final AnimationController controller;
  const _AnimatedSearchBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                0.5 * (controller.value * 2 - 1),
                -0.3,
              ),
              radius: 1.5,
              colors: [
                const Color(0xFF1B4FFF).withOpacity(0.8),
                AppColors.primaryDark,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SearchProgress extends StatelessWidget {
  final AnimationController controller;
  const _SearchProgress({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return ClipRRect(
          borderRadius: AppRadius.roundedFull,
          child: LinearProgressIndicator(
            value: null,
            backgroundColor: AppColors.white.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.accent.withOpacity(0.8)),
            minHeight: 4,
          ),
        );
      },
    );
  }
}
