import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/trip_provider.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/bottom_sheet_handle.dart';

/// VehicleSelectionScreen — Choose vehicle type with fare estimate
/// شاشة اختيار نوع المركبة مع تقدير الأجرة
class VehicleSelectionScreen extends StatefulWidget {
  const VehicleSelectionScreen({super.key});

  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen>
    with SingleTickerProviderStateMixin {
  String _selectedType = 'economy';
  String _selectedPayment = 'cash';
  late AnimationController _routeController;

  final List<_VehicleType> _vehicles = [
    _VehicleType(
      id: 'economy',
      nameEn: 'Economy',
      nameAr: 'اقتصادي',
      icon: Icons.directions_car_rounded,
      color: AppColors.vehicleEconomy,
      capacity: 4,
      eta: '3 min',
      price: 'SAR 12–15',
      description: 'Affordable everyday rides',
    ),
    _VehicleType(
      id: 'comfort',
      nameEn: 'Comfort',
      nameAr: 'مريح',
      icon: Icons.car_rental_rounded,
      color: AppColors.vehicleComfort,
      capacity: 4,
      eta: '5 min',
      price: 'SAR 18–22',
      description: 'Newer cars, extra legroom',
    ),
    _VehicleType(
      id: 'premium',
      nameEn: 'Premium',
      nameAr: 'بريميوم',
      icon: Icons.directions_car_filled_rounded,
      color: AppColors.vehiclePremium,
      capacity: 4,
      eta: '7 min',
      price: 'SAR 32–38',
      description: 'Luxury vehicles & top drivers',
    ),
    _VehicleType(
      id: 'xl',
      nameEn: 'XL',
      nameAr: 'XL كبير',
      icon: Icons.airport_shuttle_rounded,
      color: AppColors.vehicleXL,
      capacity: 7,
      eta: '6 min',
      price: 'SAR 22–28',
      description: 'Extra space for groups',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _routeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _routeController.dispose();
    super.dispose();
  }

  _VehicleType get _selected =>
      _vehicles.firstWhere((v) => v.id == _selectedType);

  void _onBook() {
    context.read<TripProvider>().selectVehicle(_selectedType);
    context.read<TripProvider>().setState(TripState.searchingDriver);
    context.go(AppRoutes.searchingDriver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Map background
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
              initialZoom: AppConstants.tripZoom,
              interactionOptions: InteractionOptions(flags: InteractiveFlag.none),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.ridego.app',
              ),
              // Route polyline
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      const LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
                      const LatLng(24.7350, 46.6900),
                    ],
                    color: AppColors.mapRoute,
                    strokeWidth: 5,
                  ),
                ],
              ),
              // Markers
              const MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
                    child: _PickupMarker(),
                    width: 40,
                    height: 40,
                  ),
                  Marker(
                    point: LatLng(24.7350, 46.6900),
                    child: _DropoffMarker(),
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ],
          ),

          // Back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.md,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  onPressed: () => context.go(AppRoutes.searchDestination),
                ),
              ).animate().fade().scale(
                    begin: const Offset(0, 0),
                    curve: Curves.elasticOut,
                  ),
            ),
          ),

          // Bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.40,
            maxChildSize: 0.75,
            snap: true,
            snapSizes: const [0.40, 0.55, 0.75],
            builder: (_, scrollController) => Container(
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
                      children: [
                        const BottomSheetHandle(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screenPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Trip summary
                              _TripSummary().animate().fade(delay: 100.ms),
                              const SizedBox(height: AppSpacing.xl),

                              Text('Choose a ride',
                                  style: AppTypography.titleLarge)
                                  .animate()
                                  .fade(delay: 150.ms),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                          ),
                        ),

                        // Vehicle list
                        SizedBox(
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.screenPadding),
                            itemCount: _vehicles.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: AppSpacing.sm),
                            itemBuilder: (_, i) => _VehicleCard(
                              vehicle: _vehicles[i],
                              selected: _vehicles[i].id == _selectedType,
                              onTap: () =>
                                  setState(() => _selectedType = _vehicles[i].id),
                              index: i,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screenPadding),
                          child: Column(
                            children: [
                              const SizedBox(height: AppSpacing.xl),

                              // Payment selection
                              _PaymentSelector(
                                selected: _selectedPayment,
                                onChanged: (v) =>
                                    setState(() => _selectedPayment = v),
                              ).animate().fade(delay: 300.ms),

                              const SizedBox(height: AppSpacing.xl),

                              // Book button
                              AppButton(
                                label:
                                    'Book ${_selected.nameEn} · ${_selected.price}',
                                onTap: _onBook,
                                gradient: AppColors.primaryGradient,
                              ).animate().fade(delay: 400.ms).slideY(begin: 0.3),

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

class _VehicleType {
  final String id;
  final String nameEn;
  final String nameAr;
  final IconData icon;
  final Color color;
  final int capacity;
  final String eta;
  final String price;
  final String description;

  const _VehicleType({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.color,
    required this.capacity,
    required this.eta,
    required this.price,
    required this.description,
  });
}

class _VehicleCard extends StatelessWidget {
  final _VehicleType vehicle;
  final bool selected;
  final VoidCallback onTap;
  final int index;

  const _VehicleCard({
    required this.vehicle,
    required this.selected,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? vehicle.color.withOpacity(0.1) : AppColors.grey100,
          borderRadius: AppRadius.roundedXl,
          border: Border.all(
            color: selected ? vehicle.color : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: vehicle.color.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(vehicle.icon,
                color: selected ? vehicle.color : AppColors.grey600, size: 36),
            const SizedBox(height: 8),
            Text(vehicle.nameEn,
                style: AppTypography.titleSmall.copyWith(
                  color: selected ? vehicle.color : AppColors.grey900,
                )),
            const SizedBox(height: 4),
            Text(vehicle.eta,
                style: AppTypography.caption
                    .copyWith(color: AppColors.grey500)),
            const SizedBox(height: 2),
            Text(vehicle.price,
                style: AppTypography.labelSmall.copyWith(
                  color: selected ? vehicle.color : AppColors.grey700,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      )
          .animate()
          .fade(delay: Duration(milliseconds: 100 + index * 60))
          .slideY(begin: 0.3),
    );
  }
}

class _TripSummary extends StatelessWidget {
  const _TripSummary();

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
          Column(
            children: [
              Container(
                  width: 10, height: 10,
                  decoration: const BoxDecoration(
                      color: AppColors.success, shape: BoxShape.circle)),
              Container(
                  width: 1, height: 28,
                  color: AppColors.grey300,
                  margin: const EdgeInsets.symmetric(vertical: 2)),
              Container(
                  width: 10, height: 10,
                  decoration: const BoxDecoration(
                      color: AppColors.error, shape: BoxShape.circle)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Location',
                    style: AppTypography.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Text('Al Malaz, Riyadh',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.grey500)),
                const SizedBox(height: AppSpacing.base),
                Text('Riyadh Park Mall',
                    style: AppTypography.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Text('King Abdullah Rd, Al Muruj',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.grey500)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('8.4 km',
                  style: AppTypography.labelMedium),
              const SizedBox(height: AppSpacing.xs),
              Text('~18 min',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.grey500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _PaymentSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final methods = [
      ('cash', '💵', 'Cash'),
      ('card', '💳', 'Card'),
      ('wallet', '👛', 'Wallet'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: methods
              .map((m) => Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(m.$1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: AppSpacing.xs),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: selected == m.$1
                              ? AppColors.primaryLighter
                              : AppColors.grey100,
                          borderRadius: AppRadius.roundedMd,
                          border: Border.all(
                            color: selected == m.$1
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(m.$2,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 4),
                            Text(m.$3,
                                style: AppTypography.caption.copyWith(
                                  color: selected == m.$1
                                      ? AppColors.primary
                                      : AppColors.grey600,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _PickupMarker extends StatelessWidget {
  const _PickupMarker();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: AppShadows.md,
      ),
      child: const Icon(Icons.person_pin_circle_rounded,
          color: AppColors.white, size: 22),
    );
  }
}

class _DropoffMarker extends StatelessWidget {
  const _DropoffMarker();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.error,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: AppShadows.md,
      ),
      child: const Icon(Icons.location_on_rounded,
          color: AppColors.white, size: 22),
    );
  }
}
