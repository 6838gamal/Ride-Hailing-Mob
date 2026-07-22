import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/bottom_sheet_handle.dart';

/// TripProgressScreen — Active trip with live driver tracking
/// شاشة الرحلة النشطة مع تتبع السائق الحي
class TripProgressScreen extends StatefulWidget {
  const TripProgressScreen({super.key});

  @override
  State<TripProgressScreen> createState() => _TripProgressScreenState();
}

class _TripProgressScreenState extends State<TripProgressScreen>
    with TickerProviderStateMixin {
  late AnimationController _carController;
  late Animation<LatLng> _carPos;
  int _remainingMin = 12;
  double _progressFraction = 0.0;
  Timer? _progressTimer;
  Timer? _finishTimer;

  static const _tripStart =
      LatLng(AppConstants.defaultLat, AppConstants.defaultLng);
  static const _tripEnd = LatLng(24.7350, 46.6900);

  @override
  void initState() {
    super.initState();

    _carController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _carPos = _LatLngTween(begin: _tripStart, end: _tripEnd).animate(
      CurvedAnimation(parent: _carController, curve: Curves.easeInOut),
    );

    _carController.forward();

    _progressTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _progressFraction =
              (_progressFraction + 1 / 12).clamp(0.0, 1.0);
          if (_remainingMin > 0) _remainingMin--;
        });
      }
    });

    // Navigate to finish after 12 seconds
    _finishTimer = Timer(const Duration(seconds: 12), () {
      if (mounted) context.go(AppRoutes.tripFinished);
    });
  }

  @override
  void dispose() {
    _carController.dispose();
    _progressTimer?.cancel();
    _finishTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Live map
          AnimatedBuilder(
            animation: _carPos,
            builder: (_, __) => FlutterMap(
              options: const MapOptions(
                initialCenter:
                    LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
                initialZoom: AppConstants.tripZoom,
                interactionOptions:
                    InteractionOptions(flags: InteractiveFlag.none),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.ridego.app',
                ),
                PolylineLayer(
                  polylines: [
                    // Traveled path
                    Polyline(
                      points: [_tripStart, _carPos.value],
                      color: AppColors.grey400,
                      strokeWidth: 5,
                    ),
                    // Remaining path
                    Polyline(
                      points: [_carPos.value, _tripEnd],
                      color: AppColors.primary,
                      strokeWidth: 5,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _carPos.value,
                      width: 52,
                      height: 52,
                      child: _TripCarMarker(),
                    ),
                    const Marker(
                      point: _tripEnd,
                      width: 36,
                      height: 36,
                      child: Icon(Icons.location_on_rounded,
                          color: AppColors.error, size: 36),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ETA overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.sm,
            left: AppSpacing.screenPadding,
            right: AppSpacing.screenPadding,
            child: _TripStatusBar(
              remaining: _remainingMin,
              progress: _progressFraction,
            ).animate().fade().slideY(begin: -0.3),
          ),

          // Bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.18,
            maxChildSize: 0.50,
            snap: true,
            builder: (_, ctrl) => Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.sheetTop,
                boxShadow: AppShadows.mapCard,
              ),
              child: CustomScrollView(
                controller: ctrl,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const BottomSheetHandle(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              AppSpacing.screenPadding,
                              AppSpacing.sm,
                              AppSpacing.screenPadding,
                              0),
                          child: Column(
                            children: [
                              // Trip in progress indicator
                              Row(
                                children: [
                                  _PulsingDot(),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text('Trip in progress',
                                      style: AppTypography.titleMedium),
                                  const Spacer(),
                                  Text('SAR 14',
                                      style: AppTypography.titleMedium
                                          .copyWith(color: AppColors.primary)),
                                ],
                              ).animate().fade(delay: 200.ms),

                              const SizedBox(height: AppSpacing.base),

                              // Destination
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.base),
                                decoration: BoxDecoration(
                                  color: AppColors.grey100,
                                  borderRadius: AppRadius.roundedLg,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_rounded,
                                        color: AppColors.error, size: 20),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Riyadh Park Mall',
                                              style:
                                                  AppTypography.titleSmall),
                                          Text('King Abdullah Rd, Al Muruj',
                                              style: AppTypography.bodySmall
                                                  .copyWith(
                                                      color:
                                                          AppColors.grey500)),
                                        ],
                                      ),
                                    ),
                                    Text('${_remainingMin} min',
                                        style: AppTypography.labelMedium
                                            .copyWith(
                                                color: AppColors.primary)),
                                  ],
                                ),
                              ).animate().fade(delay: 300.ms),

                              const SizedBox(height: AppSpacing.base),

                              // Driver info compact
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        AppColors.primaryLighter,
                                    child: const Icon(Icons.person_rounded,
                                        color: AppColors.primary, size: 22),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Ahmed Al-Rashidi',
                                            style: AppTypography.titleSmall),
                                        Text('Toyota Camry · ABC 1234',
                                            style:
                                                AppTypography.bodySmall.copyWith(
                                                    color: AppColors.grey500)),
                                      ],
                                    ),
                                  ),
                                  // Action buttons
                                  IconButton(
                                    icon: const Icon(Icons.message_rounded,
                                        color: AppColors.primary),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.call_rounded,
                                        color: AppColors.primary),
                                    onPressed: () {},
                                  ),
                                ],
                              ).animate().fade(delay: 400.ms),

                              const SizedBox(height: AppSpacing.base),

                              // Emergency button
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.errorLight,
                                    borderRadius: AppRadius.roundedLg,
                                    border: Border.all(
                                        color: AppColors.error
                                            .withOpacity(0.2)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.emergency_rounded,
                                          color: AppColors.error, size: 18),
                                      const SizedBox(width: 8),
                                      Text('Emergency',
                                          style: AppTypography.labelLarge
                                              .copyWith(
                                                  color: AppColors.error)),
                                    ],
                                  ),
                                ),
                              ).animate().fade(delay: 500.ms),

                              const SizedBox(height: AppSpacing.xl),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripStatusBar extends StatelessWidget {
  final int remaining;
  final double progress;

  const _TripStatusBar({required this.remaining, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: AppRadius.roundedXl,
        boxShadow: AppShadows.lg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.access_time_rounded,
                  color: AppColors.accent, size: 16),
              const SizedBox(width: 6),
              Text(
                remaining > 0
                    ? '$remaining min to destination'
                    : 'Almost there!',
                style: AppTypography.titleSmall
                    .copyWith(color: AppColors.white),
              ),
              const Spacer(),
              Text('8.4 km',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.white.withOpacity(0.6))),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: AppRadius.roundedFull,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.white.withOpacity(0.15),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TripCarMarker extends StatefulWidget {
  @override
  State<_TripCarMarker> createState() => _TripCarMarkerState();
}

class _TripCarMarkerState extends State<_TripCarMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, -_ctrl.value * 2),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12 + _ctrl.value * 6,
              )
            ],
          ),
          child: const Icon(Icons.local_taxi_rounded,
              color: AppColors.white, size: 28),
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.success
              .withOpacity(0.6 + _ctrl.value * 0.4),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _LatLngTween extends Tween<LatLng> {
  _LatLngTween({required LatLng begin, required LatLng end})
      : super(begin: begin, end: end);

  @override
  LatLng lerp(double t) {
    return LatLng(
      begin!.latitude + (end!.latitude - begin!.latitude) * t,
      begin!.longitude + (end!.longitude - begin!.longitude) * t,
    );
  }
}
