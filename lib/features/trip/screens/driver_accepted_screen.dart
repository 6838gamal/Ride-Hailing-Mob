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

/// DriverAcceptedScreen — Driver matched, arriving state
/// شاشة قبول السائق وحالة الوصول
class DriverAcceptedScreen extends StatefulWidget {
  const DriverAcceptedScreen({super.key});

  @override
  State<DriverAcceptedScreen> createState() => _DriverAcceptedScreenState();
}

class _DriverAcceptedScreenState extends State<DriverAcceptedScreen>
    with TickerProviderStateMixin {
  late AnimationController _carController;
  late Animation<LatLng> _carPosition;
  int _eta = 4;
  Timer? _etaTimer;
  Timer? _tripTimer;

  static const _driverStart = LatLng(24.7200, 46.6810);
  static const _pickup = LatLng(AppConstants.defaultLat, AppConstants.defaultLng);

  @override
  void initState() {
    super.initState();

    _carController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _carPosition = _LatLngTween(begin: _driverStart, end: _pickup)
        .animate(CurvedAnimation(
      parent: _carController,
      curve: Curves.easeInOut,
    ));

    _carController.forward();

    // ETA countdown
    _etaTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _eta > 0) setState(() => _eta--);
    });

    // Auto-start trip after 8 seconds
    _tripTimer = Timer(const Duration(seconds: 8), () {
      if (mounted) context.go(AppRoutes.tripProgress);
    });
  }

  @override
  void dispose() {
    _carController.dispose();
    _etaTimer?.cancel();
    _tripTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Map
          AnimatedBuilder(
            animation: _carPosition,
            builder: (_, __) => FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
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
                MarkerLayer(
                  markers: [
                    // Driver car marker
                    Marker(
                      point: _carPosition.value,
                      width: 52,
                      height: 52,
                      child: _AnimatedDriverCar(),
                    ),
                    // Pickup marker
                    const Marker(
                      point: _pickup,
                      width: 40,
                      height: 40,
                      child: _PickupPin(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ETA bubble
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.base,
            left: 0,
            right: 0,
            child: Center(
              child: _EtaBubble(eta: _eta)
                  .animate()
                  .fade()
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    curve: Curves.elasticOut,
                  ),
            ),
          ),

          // Driver info bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.42,
            minChildSize: 0.28,
            maxChildSize: 0.65,
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
                              // Status
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Driver is on the way',
                                    style: AppTypography.titleMedium
                                        .copyWith(color: AppColors.success),
                                  ),
                                ],
                              ).animate().fade(delay: 200.ms),

                              const SizedBox(height: AppSpacing.xl),

                              // Driver card
                              _DriverCard().animate().fade(delay: 300.ms),

                              const SizedBox(height: AppSpacing.xl),

                              // Vehicle info
                              _VehicleInfoCard().animate().fade(delay: 400.ms),

                              const SizedBox(height: AppSpacing.xl),

                              // Actions
                              Row(
                                children: [
                                  Expanded(
                                    child: _ActionButton(
                                      icon: Icons.message_rounded,
                                      label: 'Message',
                                      onTap: () {},
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: _ActionButton(
                                      icon: Icons.call_rounded,
                                      label: 'Call',
                                      onTap: () {},
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: _ActionButton(
                                      icon: Icons.cancel_outlined,
                                      label: 'Cancel',
                                      color: AppColors.error,
                                      onTap: () => context.go(AppRoutes.home),
                                    ),
                                  ),
                                ],
                              ).animate().fade(delay: 500.ms),

                              const SizedBox(height: AppSpacing.xl2),
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

class _AnimatedDriverCar extends StatefulWidget {
  @override
  State<_AnimatedDriverCar> createState() => _AnimatedDriverCarState();
}

class _AnimatedDriverCarState extends State<_AnimatedDriverCar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))
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
        offset: Offset(0, -_ctrl.value * 3),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.4 + _ctrl.value * 0.2),
                blurRadius: 16 + _ctrl.value * 8,
              )
            ],
          ),
          child: const Icon(Icons.local_taxi_rounded,
              color: AppColors.black, size: 28),
        ),
      ),
    );
  }
}

class _PickupPin extends StatelessWidget {
  const _PickupPin();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.location_on_rounded,
        color: AppColors.primary, size: 36);
  }
}

class _EtaBubble extends StatelessWidget {
  final int eta;
  const _EtaBubble({required this.eta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: AppRadius.roundedFull,
        boxShadow: AppShadows.lg,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time_rounded,
              color: AppColors.accent, size: 18),
          const SizedBox(width: 8),
          Text(
            eta <= 0 ? 'Arriving now' : 'Arriving in $eta min',
            style: AppTypography.titleSmall
                .copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  const _DriverCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryLighter,
              child: const Icon(Icons.person_rounded,
                  color: AppColors.primary, size: 32),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: AppRadius.roundedFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.white, size: 10),
                    const SizedBox(width: 2),
                    Text('4.9',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: AppSpacing.base),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ahmed Al-Rashidi', style: AppTypography.titleMedium),
              Text('1,247 trips completed',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.grey500)),
            ],
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLighter,
            borderRadius: AppRadius.roundedFull,
          ),
          child: Text('OTP: 4821',
              style: AppTypography.labelMedium
                  .copyWith(color: AppColors.primary)),
        ),
      ],
    );
  }
}

class _VehicleInfoCard extends StatelessWidget {
  const _VehicleInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: AppRadius.roundedLg,
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_car_rounded,
              color: AppColors.grey600, size: 28),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Toyota Camry 2023 · White',
                  style: AppTypography.titleSmall),
              Text('ABC 1234',
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.grey500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: c.withOpacity(0.08),
          borderRadius: AppRadius.roundedLg,
          border: Border.all(color: c.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: c, size: 22),
            const SizedBox(height: 4),
            Text(label,
                style: AppTypography.caption.copyWith(
                  color: c,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}

// Lerp helper for LatLng animation
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
