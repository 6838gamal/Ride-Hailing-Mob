import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';

/// ProfileScreen — User profile and settings
/// شاشة الملف الشخصي والإعدادات
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('My Profile', style: AppTypography.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.grey900),
          onPressed: () => context.go(AppRoutes.home),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Hero card
          _ProfileHeroCard().animate().fade().slideY(begin: -0.1),

          const SizedBox(height: AppSpacing.xl),

          // Stats
          _StatsRow().animate().fade(delay: 100.ms),

          const SizedBox(height: AppSpacing.xl),

          // Menu sections
          _MenuSection(
            title: 'Account',
            items: [
              _MenuItem(Icons.person_outline_rounded, 'Personal Info', () {}),
              _MenuItem(Icons.payments_outlined, 'Payment Methods',
                  () => context.go(AppRoutes.wallet)),
              _MenuItem(Icons.local_offer_outlined, 'Promotions & Coupons', () {}),
              _MenuItem(Icons.history_rounded, 'Trip History',
                  () => context.go(AppRoutes.tripHistory)),
            ],
          ).animate().fade(delay: 150.ms),

          const SizedBox(height: AppSpacing.base),

          _MenuSection(
            title: 'Support',
            items: [
              _MenuItem(Icons.help_outline_rounded, 'Help & Support', () {}),
              _MenuItem(Icons.report_outlined, 'Report an Issue', () {}),
              _MenuItem(Icons.star_outline_rounded, 'Rate the App', () {}),
            ],
          ).animate().fade(delay: 200.ms),

          const SizedBox(height: AppSpacing.base),

          _MenuSection(
            title: 'Preferences',
            items: [
              _MenuItem(Icons.notifications_outlined, 'Notifications', () {}),
              _MenuItem(Icons.language_rounded, 'Language (English)', () {}),
              _MenuItem(Icons.dark_mode_outlined, 'Dark Mode', () {}),
            ],
          ).animate().fade(delay: 250.ms),

          const SizedBox(height: AppSpacing.xl),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding),
            child: AppButton(
              label: 'Sign Out',
              onTap: () => context.go(AppRoutes.onboarding),
              variant: AppButtonVariant.outline,
            ).animate().fade(delay: 300.ms),
          ),

          const SizedBox(height: AppSpacing.xl2),

          Center(
            child: Text('RideGo v1.0.0',
                style: AppTypography.caption),
          ).animate().fade(delay: 350.ms),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _ProfileHeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: AppRadius.roundedXl2,
        boxShadow: AppShadows.primaryGlow,
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.white.withOpacity(0.2),
                child: const Icon(Icons.person_rounded,
                    color: AppColors.white, size: 40),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt_rounded,
                      size: 10, color: AppColors.black),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ahmed Al-Mahmoud',
                    style: AppTypography.titleLarge
                        .copyWith(color: AppColors.white)),
                const SizedBox(height: 4),
                Text('+966 50 123 4567',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.white.withOpacity(0.7))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.accent, size: 14),
                    const SizedBox(width: 4),
                    Text('4.8 Rating',
                        style: AppTypography.labelSmall
                            .copyWith(color: AppColors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          _StatCard(value: '127', label: 'Total Trips', icon: Icons.route_rounded),
          const SizedBox(width: AppSpacing.sm),
          _StatCard(value: 'SAR 1,240', label: 'Total Spent', icon: Icons.wallet_rounded),
          const SizedBox(width: AppSpacing.sm),
          _StatCard(value: '3 yrs', label: 'Member Since', icon: Icons.calendar_month_rounded),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.roundedLg,
          boxShadow: AppShadows.xs,
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 6),
            Text(value,
                style: AppTypography.titleSmall,
                textAlign: TextAlign.center),
            Text(label,
                style: AppTypography.caption
                    .copyWith(color: AppColors.grey500),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
              0, AppSpacing.screenPadding, AppSpacing.sm),
          child: Text(title,
              style: AppTypography.labelMedium
                  .copyWith(color: AppColors.grey500)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.roundedXl,
            boxShadow: AppShadows.xs,
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final isLast = e.key == items.length - 1;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: AppRadius.roundedMd,
                      ),
                      child: Icon(e.value.icon,
                          color: AppColors.grey700, size: 18),
                    ),
                    title: Text(e.value.label,
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.grey900)),
                    trailing: const Icon(Icons.chevron_right_rounded,
                        color: AppColors.grey400, size: 20),
                    onTap: e.value.onTap,
                  ),
                  if (!isLast)
                    const Divider(
                        height: 1,
                        indent: 70,
                        endIndent: AppSpacing.screenPadding),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem(this.icon, this.label, this.onTap);
}
