import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pulse_ring_widget.dart';

/// TripHistoryScreen — Past trips list with filtering
/// شاشة سجل الرحلات السابقة مع التصفية
class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  String _filter = 'All';

  final _filters = ['All', 'Completed', 'Cancelled', 'Scheduled'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Trip History', style: AppTypography.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.grey900),
          onPressed: () => context.go(AppRoutes.home),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.grey700),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              itemCount: _filters.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, i) {
                final f = _filters[i];
                final selected = f == _filter;
                return GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.white,
                      borderRadius: AppRadius.roundedFull,
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.grey200,
                      ),
                      boxShadow: selected ? AppShadows.primaryGlow : null,
                    ),
                    child: Text(
                      f,
                      style: AppTypography.labelMedium.copyWith(
                        color: selected
                            ? AppColors.white
                            : AppColors.grey700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ).animate().fade().slideX(begin: -0.1),

          const SizedBox(height: AppSpacing.base),

          // Trip list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              itemCount: _trips.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (_, i) => _TripHistoryCard(trip: _trips[i])
                  .animate()
                  .fade(delay: Duration(milliseconds: i * 60))
                  .slideY(begin: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripData {
  final String destination;
  final String origin;
  final String date;
  final String fare;
  final bool completed;
  final double rating;
  final String vehicleType;

  const _TripData({
    required this.destination,
    required this.origin,
    required this.date,
    required this.fare,
    required this.completed,
    required this.rating,
    required this.vehicleType,
  });
}

final _trips = [
  _TripData(
    destination: 'Riyadh Park Mall',
    origin: 'Al Malaz',
    date: 'Today, 2:30 PM',
    fare: 'SAR 18.68',
    completed: true,
    rating: 5,
    vehicleType: 'Economy',
  ),
  _TripData(
    destination: 'King Khalid Airport',
    origin: 'Olaya',
    date: 'Jul 20, 8:15 AM',
    fare: 'SAR 45.00',
    completed: true,
    rating: 4,
    vehicleType: 'Premium',
  ),
  _TripData(
    destination: 'Kingdom Centre',
    origin: 'Al Sulaimaniyah',
    date: 'Jul 18, 6:45 PM',
    fare: 'SAR 22.50',
    completed: true,
    rating: 5,
    vehicleType: 'Comfort',
  ),
  _TripData(
    destination: 'Faisaliah Tower',
    origin: 'Diplomatic Quarter',
    date: 'Jul 16, 3:20 PM',
    fare: 'SAR 0.00',
    completed: false,
    rating: 0,
    vehicleType: 'Economy',
  ),
  _TripData(
    destination: 'Riyadh Gallery',
    origin: 'Al Malaz',
    date: 'Jul 14, 11:00 AM',
    fare: 'SAR 15.20',
    completed: true,
    rating: 4,
    vehicleType: 'Economy',
  ),
];

class _TripHistoryCard extends StatelessWidget {
  final _TripData trip;

  const _TripHistoryCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.roundedXl,
        boxShadow: AppShadows.xs,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: trip.completed
                      ? AppColors.primaryLighter
                      : AppColors.errorLight,
                  borderRadius: AppRadius.roundedMd,
                ),
                child: Icon(
                  trip.completed
                      ? Icons.local_taxi_rounded
                      : Icons.cancel_rounded,
                  color: trip.completed
                      ? AppColors.primary
                      : AppColors.error,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.destination,
                        style: AppTypography.titleSmall),
                    Text('From ${trip.origin}',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.grey500)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    trip.fare,
                    style: AppTypography.titleSmall.copyWith(
                      color: trip.completed
                          ? AppColors.grey900
                          : AppColors.error,
                    ),
                  ),
                  Text(trip.vehicleType,
                      style: AppTypography.caption
                          .copyWith(color: AppColors.grey500)),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.access_time_rounded,
                  color: AppColors.grey400, size: 14),
              const SizedBox(width: 4),
              Text(trip.date,
                  style:
                      AppTypography.caption.copyWith(color: AppColors.grey500)),
              const Spacer(),
              if (trip.completed && trip.rating > 0) ...[
                StarRatingWidget(
                  rating: trip.rating,
                  size: 14,
                  readOnly: true,
                ),
              ] else if (!trip.completed) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: AppRadius.roundedFull,
                  ),
                  child: Text('Cancelled',
                      style: AppTypography.caption
                          .copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
                ),
              ],
              const SizedBox(width: AppSpacing.sm),
              // Re-book button
              if (trip.completed)
                TextButton(
                  onPressed: () => context.go(AppRoutes.home),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: AppColors.primaryLighter,
                    shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.roundedFull),
                  ),
                  child: Text('Rebook',
                      style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
