import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/bottom_sheet_handle.dart';

/// HomeScreen — Main map screen with live nearby drivers
/// الشاشة الرئيسية مع الخريطة الحية والسائقين القريبين
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // Simulated nearby drivers
  final List<_NearbyDriver> _nearbyDrivers = [
    _NearbyDriver(id: '1', position: const LatLng(24.7160, 46.6780), heading: 45),
    _NearbyDriver(id: '2', position: const LatLng(24.7110, 46.6720), heading: 120),
    _NearbyDriver(id: '3', position: const LatLng(24.7180, 46.6700), heading: 270),
    _NearbyDriver(id: '4', position: const LatLng(24.7090, 46.6800), heading: 190),
  ];

  late AnimationController _carAnimController;

  @override
  void initState() {
    super.initState();
    _carAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _carAnimController.dispose();
    super.dispose();
  }

  void _onMyLocation() {
    HapticFeedback.lightImpact();
    _mapController.move(
      const LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
      AppConstants.defaultZoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ─── Map Layer ────────────────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter:
                  LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
              initialZoom: AppConstants.defaultZoom,
              minZoom: 8,
              maxZoom: 18,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              // OpenStreetMap tiles
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.ridego.app',
                maxNativeZoom: 18,
              ),

              // Nearby driver markers
              MarkerLayer(
                markers: _nearbyDrivers
                    .map((d) => Marker(
                          point: d.position,
                          width: 56,
                          height: 56,
                          child: _AnimatedCarMarker(
                            heading: d.heading,
                            animController: _carAnimController,
                          ),
                        ))
                    .toList(),
              ),

              // Current location marker
              const MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
                    width: 56,
                    height: 56,
                    child: _CurrentLocationMarker(),
                  ),
                ],
              ),
            ],
          ),

          // ─── Top Bar ──────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  // Menu button
                  IconAppButton(
                    icon: const Icon(Icons.menu_rounded,
                        color: AppColors.grey900, size: 22),
                    onTap: () {},
                    backgroundColor: AppColors.white,
                    shadow: AppShadows.md,
                  ),

                  const Spacer(),

                  // App name / greeting
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedFull,
                      boxShadow: AppShadows.md,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('RideGo',
                            style: AppTypography.titleSmall
                                .copyWith(color: AppColors.grey900)),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Notifications
                  IconAppButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: AppColors.grey900, size: 22),
                    onTap: () {},
                    backgroundColor: AppColors.white,
                    shadow: AppShadows.md,
                  ),
                ],
              ).animate().fade(delay: 200.ms).slideY(begin: -0.3),
            ),
          ),

          // ─── My Location FAB ─────────────────────────────────────────────
          Positioned(
            right: AppSpacing.screenPadding,
            bottom: 260,
            child: IconAppButton(
              icon: const Icon(Icons.my_location_rounded,
                  color: AppColors.primary, size: 22),
              onTap: _onMyLocation,
              backgroundColor: AppColors.white,
              shadow: AppShadows.md,
            ).animate().fade(delay: 400.ms).scale(
                  begin: const Offset(0, 0),
                  curve: Curves.elasticOut,
                  duration: 600.ms,
                ),
          ),

          // ─── Bottom Sheet ─────────────────────────────────────────────────
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.32,
            minChildSize: 0.18,
            maxChildSize: 0.55,
            snap: true,
            snapSizes: const [0.18, 0.32, 0.55],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.sheetTop,
                  boxShadow: AppShadows.mapCard,
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BottomSheetHandle(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                AppSpacing.screenPadding,
                                AppSpacing.sm,
                                AppSpacing.screenPadding,
                                0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Good morning, Ahmed 👋',
                                    style: AppTypography.titleLarge),
                                const SizedBox(height: AppSpacing.xs),
                                Text('Where are you going?',
                                    style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.grey500)),
                                const SizedBox(height: AppSpacing.base),

                                // Destination search tap target
                                GestureDetector(
                                  onTap: () =>
                                      context.go(AppRoutes.searchDestination),
                                  child: Container(
                                    height: 54,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey100,
                                      borderRadius: AppRadius.roundedBase,
                                      border: Border.all(
                                          color: AppColors.grey200),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            color: AppColors.error,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            'Enter destination...',
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                                    color: AppColors.grey400),
                                          ),
                                        ),
                                        Icon(Icons.search_rounded,
                                            color: AppColors.grey400, size: 20),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: AppSpacing.base),

                                // Quick actions
                                Row(
                                  children: [
                                    _QuickAction(
                                      icon: Icons.home_rounded,
                                      label: 'Home',
                                      subtitle: '5 min',
                                      onTap: () => context.go(
                                          AppRoutes.vehicleSelection),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    _QuickAction(
                                      icon: Icons.work_rounded,
                                      label: 'Work',
                                      subtitle: '12 min',
                                      onTap: () => context.go(
                                          AppRoutes.vehicleSelection),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    _QuickAction(
                                      icon: Icons.add_rounded,
                                      label: 'Add',
                                      subtitle: 'Place',
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Recent trips
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            AppSpacing.screenPadding,
                            AppSpacing.xl,
                            AppSpacing.screenPadding,
                            0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recent Places',
                                style: AppTypography.titleMedium),
                            const SizedBox(height: AppSpacing.base),
                          ],
                        ),
                      ),
                    ),

                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          _RecentPlaceItem(
                            icon: Icons.history_rounded,
                            name: 'Riyadh Park Mall',
                            address: 'King Abdullah Rd, Riyadh',
                            onTap: () =>
                                context.go(AppRoutes.vehicleSelection),
                          ),
                          _RecentPlaceItem(
                            icon: Icons.history_rounded,
                            name: 'King Khalid Airport',
                            address: 'Airport Rd, Riyadh',
                            onTap: () =>
                                context.go(AppRoutes.vehicleSelection),
                          ),
                          _RecentPlaceItem(
                            icon: Icons.star_rounded,
                            name: 'Kingdom Centre Tower',
                            address: 'Olaya St, Riyadh',
                            onTap: () =>
                                context.go(AppRoutes.vehicleSelection),
                            iconColor: AppColors.accent,
                          ),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Helper Widgets ──────────────────────────────────────────────────────────

class _NearbyDriver {
  final String id;
  final LatLng position;
  final double heading;
  _NearbyDriver({required this.id, required this.position, required this.heading});
}

class _AnimatedCarMarker extends StatelessWidget {
  final double heading;
  final AnimationController animController;

  const _AnimatedCarMarker({
    required this.heading,
    required this.animController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animController,
      builder: (_, __) {
        final bob = animController.value * 2;
        return Transform.translate(
          offset: Offset(0, bob),
          child: Transform.rotate(
            angle: heading * 3.14159 / 180,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: AppShadows.md,
              ),
              child: const Icon(
                Icons.local_taxi_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CurrentLocationMarker extends StatelessWidget {
  const _CurrentLocationMarker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.15),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 3),
            boxShadow: AppShadows.md,
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.md, horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: AppRadius.roundedLg,
            border: Border.all(color: AppColors.grey200),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(height: AppSpacing.xs),
              Text(label,
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.grey900)),
              Text(subtitle,
                  style: AppTypography.caption
                      .copyWith(color: AppColors.grey500)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentPlaceItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String address;
  final VoidCallback onTap;
  final Color? iconColor;

  const _RecentPlaceItem({
    required this.icon,
    required this.name,
    required this.address,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding, vertical: AppSpacing.xs),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: AppRadius.roundedMd,
        ),
        child: Icon(icon,
            color: iconColor ?? AppColors.grey600, size: 20),
      ),
      title: Text(name, style: AppTypography.titleSmall),
      subtitle: Text(address,
          style: AppTypography.bodySmall
              .copyWith(color: AppColors.grey500)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 14, color: AppColors.grey400),
      onTap: onTap,
    );
  }
}
