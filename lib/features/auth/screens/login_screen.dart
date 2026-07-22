import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

/// LoginScreen — Phone number or email login with OTP flow
/// شاشة تسجيل الدخول
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  bool _loading = false;
  bool _isPhone = true;

  void _onContinue() async {
    if (_phoneController.text.isEmpty) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() => _loading = false);
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl2),

                    // Back button
                    IconAppButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: AppColors.grey900,
                      ),
                      onTap: () => context.go(AppRoutes.onboarding),
                      shadow: AppShadows.sm,
                    ).animate().fade().slideX(begin: -0.3),

                    const SizedBox(height: AppSpacing.xl3),

                    // Header
                    Text(
                      'Welcome back 👋',
                      style: AppTypography.headlineMedium,
                    ).animate().fade(delay: 100.ms).slideY(begin: 0.3),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      'Sign in to continue your journey.',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.grey500,
                      ),
                    ).animate().fade(delay: 200.ms).slideY(begin: 0.3),

                    const SizedBox(height: AppSpacing.xl3),

                    // Toggle: Phone / Email
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: AppRadius.roundedLg,
                      ),
                      child: Row(
                        children: [
                          _TabButton(
                            label: 'Phone',
                            active: _isPhone,
                            onTap: () => setState(() => _isPhone = true),
                          ),
                          _TabButton(
                            label: 'Email',
                            active: !_isPhone,
                            onTap: () => setState(() => _isPhone = false),
                          ),
                        ],
                      ),
                    ).animate().fade(delay: 300.ms),

                    const SizedBox(height: AppSpacing.xl),

                    // Input
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _isPhone
                          ? _PhoneField(controller: _phoneController)
                          : AppTextField(
                              hint: 'you@email.com',
                              controller: _phoneController,
                              keyboardType: TextInputType.emailAddress,
                              prefix: const Icon(Icons.email_outlined,
                                  color: AppColors.grey400),
                            ),
                    ).animate().fade(delay: 350.ms),

                    const SizedBox(height: AppSpacing.xl2),

                    // Continue button
                    AppButton(
                      label: 'Continue',
                      loading: _loading,
                      onTap: _onContinue,
                    ).animate().fade(delay: 450.ms).slideY(begin: 0.3),

                    const SizedBox(height: AppSpacing.xl2),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.base),
                          child: Text(
                            'or continue with',
                            style: AppTypography.bodySmall,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ).animate().fade(delay: 500.ms),

                    const SizedBox(height: AppSpacing.xl),

                    // Social auth
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialButton(
                          label: 'Google',
                          icon: Icons.g_mobiledata_rounded,
                          color: const Color(0xFFEA4335),
                          onTap: () => context.go(AppRoutes.home),
                        ),
                        const SizedBox(width: AppSpacing.base),
                        _SocialButton(
                          label: 'Apple',
                          icon: Icons.apple_rounded,
                          color: AppColors.black,
                          onTap: () => context.go(AppRoutes.home),
                        ),
                      ],
                    ).animate().fade(delay: 600.ms),

                    const Spacer(),

                    // Register link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTypography.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.register),
                            child: Text(
                              'Sign Up',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fade(delay: 700.ms),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 40,
          decoration: BoxDecoration(
            color: active ? AppColors.white : Colors.transparent,
            borderRadius: AppRadius.roundedMd,
            boxShadow: active ? AppShadows.xs : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: active ? AppColors.grey900 : AppColors.grey500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const _PhoneField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: AppRadius.roundedBase,
          ),
          child: Row(
            children: [
              const Text('🇸🇦', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Text('+966', style: AppTypography.bodyMedium),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down_rounded,
                  size: 16, color: AppColors.grey500),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: AppTextField(
            controller: controller,
            hint: '50 123 4567',
            keyboardType: TextInputType.phone,
            prefix: const Icon(Icons.phone_outlined, color: AppColors.grey400),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: AppRadius.roundedBase,
          border: Border.all(color: AppColors.grey200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 8),
            Text(label, style: AppTypography.labelLarge),
          ],
        ),
      ),
    );
  }
}
