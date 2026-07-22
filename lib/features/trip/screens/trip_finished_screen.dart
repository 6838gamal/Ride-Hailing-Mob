import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';

/// TripFinishedScreen — Trip summary and payment confirmation
/// شاشة انتهاء الرحلة وتأكيد الدفع
class TripFinishedScreen extends StatefulWidget {
  const TripFinishedScreen({super.key});

  @override
  State<TripFinishedScreen> createState() => _TripFinishedScreenState();
}

class _TripFinishedScreenState extends State<TripFinishedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _celebrationCtrl;

  @override
  void initState() {
    super.initState();
    _celebrationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _celebrationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl3),

                // Success animation
                _SuccessCircle()
                    .animate()
                    .scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      curve: Curves.elasticOut,
                      duration: const Duration(milliseconds: 800),
                    )
                    .fade(),

                const SizedBox(height: AppSpacing.xl2),

                Text(
                  'Trip Completed! 🎉',
                  style: AppTypography.headlineMedium,
                  textAlign: TextAlign.center,
                ).animate().fade(delay: 300.ms).slideY(begin: 0.3),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'You arrived at Riyadh Park Mall',
                  style: AppTypography.bodyLarge
                      .copyWith(color: AppColors.grey500),
                  textAlign: TextAlign.center,
                ).animate().fade(delay: 400.ms),

                const SizedBox(height: AppSpacing.xl3),

                // Trip stats
                _TripStatsCard()
                    .animate()
                    .fade(delay: 500.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: AppSpacing.xl),

                // Payment card
                _PaymentCard()
                    .animate()
                    .fade(delay: 600.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: AppSpacing.xl3),

                // Rate CTA
                AppButton(
                  label: 'Rate your trip',
                  onTap: () => context.go(AppRoutes.rating),
                  gradient: AppColors.primaryGradient,
                ).animate().fade(delay: 700.ms).slideY(begin: 0.3),

                const SizedBox(height: AppSpacing.base),

                AppButton(
                  label: 'Back to Home',
                  onTap: () => context.go(AppRoutes.home),
                  variant: AppButtonVariant.ghost,
                ).animate().fade(delay: 800.ms),

                const SizedBox(height: AppSpacing.xl2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessCircle extends StatelessWidget {
  const _SuccessCircle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow ring
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        // Inner ring
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
        // Center
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded,
              color: AppColors.white, size: 44),
        ),
      ],
    );
  }
}

class _TripStatsCard extends StatelessWidget {
  const _TripStatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: AppRadius.roundedXl,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Stat(
            icon: Icons.route_rounded,
            value: '8.4 km',
            label: 'Distance',
            color: AppColors.primary,
          ),
          _VerticalDivider(),
          _Stat(
            icon: Icons.access_time_rounded,
            value: '18 min',
            label: 'Duration',
            color: AppColors.success,
          ),
          _VerticalDivider(),
          _Stat(
            icon: Icons.speed_rounded,
            value: '42 km/h',
            label: 'Avg Speed',
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(value, style: AppTypography.titleSmall),
        Text(label,
            style: AppTypography.caption.copyWith(color: AppColors.grey500)),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: AppColors.grey300,
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.roundedXl,
        border: Border.all(color: AppColors.grey200),
        boxShadow: AppShadows.sm,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Payment Summary',
                  style: AppTypography.titleSmall),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: AppRadius.roundedFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: AppColors.success, size: 12),
                    const SizedBox(width: 4),
                    Text('Paid',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.base),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          _PayRow(label: 'Base fare', value: 'SAR 5.00'),
          _PayRow(label: 'Distance (8.4 km)', value: 'SAR 10.08'),
          _PayRow(label: 'Time (18 min)', value: 'SAR 3.60'),
          const SizedBox(height: AppSpacing.sm),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          _PayRow(
            label: 'Total',
            value: 'SAR 18.68',
            bold: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.payments_rounded,
                  color: AppColors.grey500, size: 16),
              const SizedBox(width: 6),
              Text('Paid by Cash',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.grey500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PayRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _PayRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label,
              style: bold
                  ? AppTypography.titleSmall
                  : AppTypography.bodyMedium
                      .copyWith(color: AppColors.grey600)),
          const Spacer(),
          Text(value,
              style: bold
                  ? AppTypography.titleMedium
                      .copyWith(color: AppColors.primary)
                  : AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
