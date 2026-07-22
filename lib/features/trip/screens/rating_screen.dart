import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/pulse_ring_widget.dart';

/// RatingScreen — Driver rating with optional feedback
/// شاشة تقييم السائق مع ملاحظات اختيارية
class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0;
  final Set<String> _selectedTags = {};
  final _commentCtrl = TextEditingController();
  bool _loading = false;

  final List<_FeedbackTag> _tags = [
    _FeedbackTag('Great driver', Icons.person_rounded),
    _FeedbackTag('Clean car', Icons.cleaning_services_rounded),
    _FeedbackTag('On time', Icons.access_time_rounded),
    _FeedbackTag('Safe driving', Icons.verified_rounded),
    _FeedbackTag('Friendly', Icons.sentiment_very_satisfied_rounded),
    _FeedbackTag('Professional', Icons.work_rounded),
  ];

  void _onSubmit() async {
    if (_rating == 0) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  String get _ratingLabel {
    if (_rating == 0) return 'Tap to rate';
    if (_rating == 1) return 'Poor 😕';
    if (_rating == 2) return 'Fair 😐';
    if (_rating == 3) return 'Good 🙂';
    if (_rating == 4) return 'Great 😊';
    return 'Excellent! 🤩';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xl2),

              // Driver avatar
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLighter,
                          shape: BoxShape.circle,
                        ),
                      ),
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.primaryLighter,
                        child: const Icon(Icons.person_rounded,
                            color: AppColors.primary, size: 48),
                      ),
                    ],
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.6, 0.6),
                        curve: Curves.elasticOut,
                        duration: const Duration(milliseconds: 700),
                      )
                      .fade(),

                  const SizedBox(height: AppSpacing.base),

                  Text('Rate Ahmed Al-Rashidi',
                      style: AppTypography.headlineSmall)
                      .animate()
                      .fade(delay: 200.ms)
                      .slideY(begin: 0.3),

                  const SizedBox(height: AppSpacing.xs),

                  Text(
                    'How was your trip to Riyadh Park Mall?',
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.grey500),
                    textAlign: TextAlign.center,
                  ).animate().fade(delay: 300.ms),
                ],
              ),

              const SizedBox(height: AppSpacing.xl2),

              // Star rating
              Column(
                children: [
                  StarRatingWidget(
                    rating: _rating,
                    size: 52,
                    onRatingChanged: (r) => setState(() => _rating = r),
                  ).animate().fade(delay: 400.ms).scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.elasticOut,
                      ),

                  const SizedBox(height: AppSpacing.sm),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      _ratingLabel,
                      key: ValueKey(_rating),
                      style: AppTypography.titleMedium.copyWith(
                        color: _rating >= 4
                            ? AppColors.success
                            : _rating >= 3
                                ? AppColors.warning
                                : _rating > 0
                                    ? AppColors.error
                                    : AppColors.grey400,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl2),

              // Quick feedback tags
              if (_rating > 0 && _rating >= 4) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('What went well?',
                      style: AppTypography.titleSmall),
                ).animate().fade().slideX(begin: -0.2),

                const SizedBox(height: AppSpacing.sm),

                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _tags
                      .map((tag) => _FeedbackChip(
                            tag: tag,
                            selected: _selectedTags.contains(tag.label),
                            onTap: () => setState(() {
                              _selectedTags.contains(tag.label)
                                  ? _selectedTags.remove(tag.label)
                                  : _selectedTags.add(tag.label);
                            }),
                          ))
                      .toList(),
                ).animate().fade(delay: 100.ms),

                const SizedBox(height: AppSpacing.xl),
              ],

              // Comment box
              if (_rating > 0) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Add a comment (optional)',
                      style: AppTypography.titleSmall),
                ).animate().fade(),

                const SizedBox(height: AppSpacing.sm),

                TextField(
                  controller: _commentCtrl,
                  maxLines: 3,
                  maxLength: 200,
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.grey900),
                  decoration: InputDecoration(
                    hintText: 'Tell us about your experience...',
                    hintStyle: AppTypography.bodyMedium
                        .copyWith(color: AppColors.grey400),
                    filled: true,
                    fillColor: AppColors.grey100,
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.roundedBase,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.roundedBase,
                      borderSide: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                    ),
                    counterStyle: AppTypography.caption,
                  ),
                ).animate().fade(delay: 100.ms),

                const SizedBox(height: AppSpacing.xl),
              ],

              // Tip section
              if (_rating >= 4) ...[
                _TipSection().animate().fade(delay: 200.ms),
                const SizedBox(height: AppSpacing.xl),
              ],

              // Submit
              AppButton(
                label: _rating == 0 ? 'Rate first to submit' : 'Submit Rating',
                onTap: _rating > 0 ? _onSubmit : null,
                loading: _loading,
                gradient: _rating > 0 ? AppColors.primaryGradient : null,
              ).animate().fade(delay: 500.ms).slideY(begin: 0.3),

              const SizedBox(height: AppSpacing.sm),

              TextButton(
                onPressed: () => context.go(AppRoutes.home),
                child: Text('Skip for now',
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.grey500)),
              ).animate().fade(delay: 600.ms),

              const SizedBox(height: AppSpacing.xl2),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackTag {
  final String label;
  final IconData icon;
  const _FeedbackTag(this.label, this.icon);
}

class _FeedbackChip extends StatelessWidget {
  final _FeedbackTag tag;
  final bool selected;
  final VoidCallback onTap;

  const _FeedbackChip({
    required this.tag,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLighter : AppColors.grey100,
          borderRadius: AppRadius.roundedFull,
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tag.icon,
              size: 14,
              color: selected ? AppColors.primary : AppColors.grey600,
            ),
            const SizedBox(width: 6),
            Text(
              tag.label,
              style: AppTypography.labelMedium.copyWith(
                color: selected ? AppColors.primary : AppColors.grey700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipSection extends StatefulWidget {
  @override
  State<_TipSection> createState() => _TipSectionState();
}

class _TipSectionState extends State<_TipSection> {
  double _tip = 0;
  final List<double> _tips = [0, 2, 5, 10];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: AppRadius.roundedXl,
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('💛', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text('Add a tip for Ahmed',
                  style: AppTypography.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: _tips
                .map((t) => Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tip = t),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tip == t
                                ? AppColors.accent
                                : AppColors.white,
                            borderRadius: AppRadius.roundedMd,
                            boxShadow: _tip == t ? AppShadows.accentGlow : null,
                          ),
                          child: Center(
                            child: Text(
                              t == 0 ? 'None' : 'SAR ${t.toInt()}',
                              style: AppTypography.labelMedium.copyWith(
                                color: _tip == t
                                    ? AppColors.black
                                    : AppColors.grey700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
