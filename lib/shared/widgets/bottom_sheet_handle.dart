import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// BottomSheetHandle — Drag handle indicator for bottom sheets
/// مقبض السحب للأوراق السفلية
class BottomSheetHandle extends StatelessWidget {
  final Color? color;

  const BottomSheetHandle({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSpacing.sheetHandleWidth,
        height: AppSpacing.sheetHandleHeight,
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        decoration: BoxDecoration(
          color: color ?? AppColors.grey300,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

/// AppBottomSheet — Animated drag-able bottom sheet container
/// حاوية الورقة السفلية القابلة للسحب
class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final bool showHandle;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.showHandle = true,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: AppRadius.sheetTop,
        boxShadow: AppShadows.mapCard,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle) const BottomSheetHandle(),
          Padding(
            padding: padding ??
                const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.sm,
                  AppSpacing.screenPadding,
                  AppSpacing.xl,
                ),
            child: child,
          ),
        ],
      ),
    );
  }
}
