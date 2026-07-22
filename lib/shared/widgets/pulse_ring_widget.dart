import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/animation_constants.dart';

/// PulseRingWidget — Animated pulsing rings (searching driver, live location)
/// حلقات نابضة متحركة للبحث عن السائق والموقع الحي
class PulseRingWidget extends StatefulWidget {
  final Widget child;
  final Color color;
  final int ringCount;
  final double maxRadius;
  final Duration period;

  const PulseRingWidget({
    super.key,
    required this.child,
    this.color = AppColors.primary,
    this.ringCount = 3,
    this.maxRadius = 80,
    this.period = const Duration(milliseconds: 2000),
  });

  @override
  State<PulseRingWidget> createState() => _PulseRingWidgetState();
}

class _PulseRingWidgetState extends State<PulseRingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.period,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return SizedBox(
          width: widget.maxRadius * 2,
          height: widget.maxRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rings
              for (int i = 0; i < widget.ringCount; i++)
                _PulseRing(
                  progress: (_controller.value +
                          i / widget.ringCount) %
                      1.0,
                  color: widget.color,
                  maxRadius: widget.maxRadius,
                ),
              // Center child
              child!,
            ],
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _PulseRing extends StatelessWidget {
  final double progress;
  final Color color;
  final double maxRadius;

  const _PulseRing({
    required this.progress,
    required this.color,
    required this.maxRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = progress * maxRadius;
    final opacity = (1 - progress) * 0.6;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(opacity),
          width: 1.5,
        ),
      ),
    );
  }
}

/// SearchingAnimation — Three-dot bouncing loader
class SearchingDotsAnimation extends StatefulWidget {
  final Color color;
  final double dotSize;

  const SearchingDotsAnimation({
    super.key,
    this.color = AppColors.primary,
    this.dotSize = 8,
  });

  @override
  State<SearchingDotsAnimation> createState() => _SearchingDotsAnimationState();
}

class _SearchingDotsAnimationState extends State<SearchingDotsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final offset = ((_controller.value - i * 0.15) % 1.0);
          final bounce = offset < 0.5
              ? offset * 2
              : (1 - offset) * 2;
          final y = -bounce * 8;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Transform.translate(
              offset: Offset(0, y),
              child: Container(
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// StarRatingWidget — Interactive star rating
class StarRatingWidget extends StatefulWidget {
  final double rating;
  final int starCount;
  final double size;
  final ValueChanged<double>? onRatingChanged;
  final bool readOnly;

  const StarRatingWidget({
    super.key,
    this.rating = 0,
    this.starCount = 5,
    this.size = 40,
    this.onRatingChanged,
    this.readOnly = false,
  });

  @override
  State<StarRatingWidget> createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (i) {
        final filled = i < _rating;
        final halfFilled = i + 0.5 <= _rating && i + 1 > _rating;

        return GestureDetector(
          onTap: widget.readOnly
              ? null
              : () {
                  setState(() => _rating = (i + 1).toDouble());
                  widget.onRatingChanged?.call(_rating);
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedContainer(
              duration: AnimationConstants.fast,
              child: Icon(
                filled
                    ? Icons.star_rounded
                    : halfFilled
                        ? Icons.star_half_rounded
                        : Icons.star_outline_rounded,
                color: filled || halfFilled
                    ? AppColors.accent
                    : AppColors.grey300,
                size: widget.size,
              ),
            ),
          ),
        );
      }),
    );
  }
}
