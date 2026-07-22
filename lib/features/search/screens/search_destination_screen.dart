import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';

/// SearchDestinationScreen — Destination search with suggestions
/// شاشة البحث عن الوجهة
class SearchDestinationScreen extends StatefulWidget {
  const SearchDestinationScreen({super.key});

  @override
  State<SearchDestinationScreen> createState() =>
      _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
  final _pickupCtrl = TextEditingController(text: 'Current Location');
  final _destCtrl = TextEditingController();
  final _destFocus = FocusNode();
  String _query = '';

  final List<_Place> _suggestions = [
    _Place('Riyadh Park Mall', 'King Abdullah Rd, Al Muruj',
        Icons.local_mall_rounded, AppColors.primary),
    _Place('King Khalid Airport', 'Airport Rd, North Riyadh',
        Icons.flight_rounded, AppColors.info),
    _Place('Kingdom Centre Tower', 'Olaya St, Al Olaya',
        Icons.business_rounded, AppColors.accent),
    _Place('Al Faisaliah Tower', 'King Fahd Rd, Al Olaya',
        Icons.apartment_rounded, AppColors.success),
    _Place('Riyadh Gallery Mall', 'Al Urubah Rd, Al Malaz',
        Icons.shopping_bag_rounded, AppColors.primary),
    _Place('King Abdullah Financial District', 'KAFD, North Riyadh',
        Icons.location_city_rounded, AppColors.grey600),
  ];

  List<_Place> get _filtered => _query.isEmpty
      ? _suggestions
      : _suggestions
          .where((p) =>
              p.name.toLowerCase().contains(_query.toLowerCase()) ||
              p.address.toLowerCase().contains(_query.toLowerCase()))
          .toList();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _destFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _destCtrl.dispose();
    _destFocus.dispose();
    super.dispose();
  }

  void _selectPlace(_Place place) {
    HapticFeedback.selectionClick();
    context.go(AppRoutes.vehicleSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Search Header ─────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.sm,
                AppSpacing.screenPadding,
                AppSpacing.base,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: AppShadows.sm,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconAppButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: AppColors.grey900),
                        onTap: () => context.go(AppRoutes.home),
                        shadow: [],
                        backgroundColor: AppColors.grey100,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text('Where to?', style: AppTypography.titleLarge),
                      ),
                    ],
                  ).animate().fade().slideX(begin: -0.2),

                  const SizedBox(height: AppSpacing.base),

                  // Route inputs card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: AppRadius.roundedXl,
                    ),
                    child: Column(
                      children: [
                        _RouteInput(
                          controller: _pickupCtrl,
                          hint: 'Pickup location',
                          dotColor: AppColors.success,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: List.generate(
                              4,
                              (_) => Container(
                                width: 2,
                                height: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 2),
                                color: AppColors.grey300,
                              ),
                            ),
                          ),
                        ),
                        _RouteInput(
                          controller: _destCtrl,
                          focusNode: _destFocus,
                          hint: 'Where to?',
                          dotColor: AppColors.error,
                          onChanged: (v) => setState(() => _query = v),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 100.ms),
                ],
              ),
            ),

            // ─── Suggestions List ─────────────────────────────────────────
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                children: [
                  if (_query.isEmpty) ...[
                    _SectionHeader('Saved Places'),
                    _SavedPlaceTile(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      address: 'Al Malaz, Riyadh',
                      onTap: () => context.go(AppRoutes.vehicleSelection),
                    ),
                    _SavedPlaceTile(
                      icon: Icons.work_rounded,
                      label: 'Work',
                      address: 'Olaya, Riyadh',
                      onTap: () => context.go(AppRoutes.vehicleSelection),
                    ),
                    _SectionHeader('Nearby Places'),
                  ],
                  ..._filtered.asMap().entries.map((e) => _SuggestionTile(
                        place: e.value,
                        delay: e.key * 40,
                        onTap: () => _selectPlace(e.value),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Data Models ─────────────────────────────────────────────────────────────

class _Place {
  final String name;
  final String address;
  final IconData icon;
  final Color iconColor;
  const _Place(this.name, this.address, this.icon, this.iconColor);
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _RouteInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hint;
  final Color dotColor;
  final ValueChanged<String>? onChanged;

  const _RouteInput({
    required this.controller,
    this.focusNode,
    required this.hint,
    required this.dotColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: dotColor.withOpacity(0.3), blurRadius: 6),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppRadius.roundedMd,
            ),
            child: Center(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: onChanged,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey900,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: AppTypography.bodyMedium
                      .copyWith(color: AppColors.grey400),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
          AppSpacing.base, AppSpacing.screenPadding, AppSpacing.xs),
      child: Text(title,
          style: AppTypography.labelMedium.copyWith(color: AppColors.grey500)),
    );
  }
}

class _SavedPlaceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String address;
  final VoidCallback onTap;

  const _SavedPlaceTile({
    required this.icon,
    required this.label,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding, vertical: 0),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primaryLighter,
          borderRadius: AppRadius.roundedMd,
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(label, style: AppTypography.titleSmall),
      subtitle: Text(address,
          style:
              AppTypography.bodySmall.copyWith(color: AppColors.grey500)),
      onTap: onTap,
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  final _Place place;
  final int delay;
  final VoidCallback onTap;

  const _SuggestionTile({
    required this.place,
    required this.delay,
    required this.onTap,
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
          color: place.iconColor.withOpacity(0.1),
          borderRadius: AppRadius.roundedMd,
        ),
        child: Icon(place.icon, color: place.iconColor, size: 20),
      ),
      title: Text(place.name, style: AppTypography.titleSmall),
      subtitle: Text(place.address,
          style:
              AppTypography.bodySmall.copyWith(color: AppColors.grey500)),
      trailing: const Icon(Icons.north_west_rounded,
          size: 16, color: AppColors.grey300),
      onTap: onTap,
    ).animate().fade(delay: Duration(milliseconds: delay)).slideX(begin: 0.1);
  }
}
