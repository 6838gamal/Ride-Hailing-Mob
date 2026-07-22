import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/constants/animation_constants.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger }
enum AppButtonSize { sm, md, lg }

/// AppButton — Design System Button Component
/// مكون الزر في نظام التصميم
class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool loading;
  final bool fullWidth;
  final LinearGradient? gradient;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.lg,
    this.leading,
    this.trailing,
    this.loading = false,
    this.fullWidth = true,
    this.gradient,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConstants.fast,
    );
    _scale = Tween<double>(begin: 1.0, end: AnimationConstants.buttonPressScale)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: AnimationConstants.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    HapticFeedback.lightImpact();
    _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() => _controller.reverse();

  double get _height {
    switch (widget.size) {
      case AppButtonSize.sm:
        return 40;
      case AppButtonSize.md:
        return 48;
      case AppButtonSize.lg:
        return AppSpacing.buttonHeight;
    }
  }

  EdgeInsets get _padding {
    switch (widget.size) {
      case AppButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 16);
      case AppButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 20);
      case AppButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24);
    }
  }

  Color get _bgColor {
    if (widget.onTap == null) return AppColors.grey300;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppColors.primary;
      case AppButtonVariant.secondary:
        return AppColors.accent;
      case AppButtonVariant.outline:
        return Colors.transparent;
      case AppButtonVariant.ghost:
        return Colors.transparent;
      case AppButtonVariant.danger:
        return AppColors.error;
    }
  }

  Color get _fgColor {
    if (widget.onTap == null) return AppColors.grey500;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppColors.white;
      case AppButtonVariant.secondary:
        return AppColors.black;
      case AppButtonVariant.outline:
        return AppColors.primary;
      case AppButtonVariant.ghost:
        return AppColors.primary;
      case AppButtonVariant.danger:
        return AppColors.white;
    }
  }

  Border? get _border {
    switch (widget.variant) {
      case AppButtonVariant.outline:
        return Border.all(color: AppColors.primary, width: 1.5);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null || widget.loading;

    return GestureDetector(
      onTapDown: isDisabled ? null : _onTapDown,
      onTapUp: isDisabled ? null : _onTapUp,
      onTapCancel: isDisabled ? null : _onTapCancel,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: AnimatedOpacity(
          opacity: isDisabled && !widget.loading ? 0.5 : 1.0,
          duration: AnimationConstants.fast,
          child: Container(
            height: _height,
            width: widget.fullWidth ? double.infinity : null,
            padding: _padding,
            decoration: BoxDecoration(
              color: widget.gradient == null ? _bgColor : null,
              gradient: widget.gradient,
              borderRadius: AppRadius.roundedLg,
              border: _border,
              boxShadow: widget.variant == AppButtonVariant.primary &&
                      widget.onTap != null
                  ? AppShadows.primaryGlow
                  : null,
            ),
            child: Center(
              child: widget.loading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(_fgColor),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.leading != null) ...[
                          widget.leading!,
                          const SizedBox(width: AppSpacing.sm),
                        ],
                        Text(
                          widget.label,
                          style: AppTypography.buttonText.copyWith(
                            color: _fgColor,
                            fontSize: widget.size == AppButtonSize.sm ? 14 : 16,
                          ),
                        ),
                        if (widget.trailing != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          widget.trailing!,
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// IconAppButton — Circular icon button
class IconAppButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final List<BoxShadow>? shadow;

  const IconAppButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.size = AppSpacing.iconButtonSize,
    this.shadow,
  });

  @override
  State<IconAppButton> createState() => _IconAppButtonState();
}

class _IconAppButtonState extends State<IconAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: AnimationConstants.fast,
      lowerBound: 0.9,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        _ctrl.reverse();
      },
      onTapUp: (_) {
        _ctrl.forward();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.forward(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => Transform.scale(scale: _ctrl.value, child: child),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.surface,
            borderRadius: AppRadius.roundedFull,
            boxShadow: widget.shadow ?? AppShadows.md,
          ),
          child: Center(child: widget.icon),
        ),
      ),
    );
  }
}
