import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/constants/animation_constants.dart';

/// AppTextField — Design System Input Component
/// مكون حقل الإدخال
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.errorText,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focus;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(() {
      setState(() => _isFocused = _focus.hasFocus);
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AnimationConstants.fast,
      decoration: BoxDecoration(
        color: _isFocused ? AppColors.white : AppColors.grey100,
        borderRadius: AppRadius.roundedBase,
        border: Border.all(
          color: widget.errorText != null
              ? AppColors.error
              : _isFocused
                  ? AppColors.primary
                  : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: _isFocused ? AppShadows.sm : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focus,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.grey900),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.base,
          ),
          hintStyle: AppTypography.bodyLarge.copyWith(
            color: AppColors.grey400,
          ),
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: _isFocused ? AppColors.primary : AppColors.grey500,
          ),
          errorText: widget.errorText,
          errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}

/// SearchField — Specialized search input for location search
class SearchField extends StatelessWidget {
  final String hint;
  final Color? dotColor;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  const SearchField({
    super.key,
    required this.hint,
    this.dotColor,
    this.onTap,
    this.controller,
    this.onChanged,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: AppRadius.roundedBase,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor ?? AppColors.grey400,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: onTap != null
                  ? Text(
                      hint,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.grey400,
                      ),
                    )
                  : TextField(
                      controller: controller,
                      onChanged: onChanged,
                      autofocus: autofocus,
                      style: AppTypography.bodyLarge
                          .copyWith(color: AppColors.grey900),
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
          ],
        ),
      ),
    );
  }
}
