import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

/// RegisterScreen — New user registration
/// شاشة تسجيل مستخدم جديد
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _loading = false;
  bool _acceptTerms = false;

  void _onRegister() async {
    if (!_acceptTerms) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) {
      setState(() => _loading = false);
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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

                    IconAppButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: AppColors.grey900),
                      onTap: () => context.go(AppRoutes.login),
                      shadow: AppShadows.sm,
                    ).animate().fade(),

                    const SizedBox(height: AppSpacing.xl3),

                    Text('Create Account', style: AppTypography.headlineMedium)
                        .animate()
                        .fade(delay: 100.ms)
                        .slideY(begin: 0.3),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      'Join RideGo for premium rides.',
                      style: AppTypography.bodyLarge
                          .copyWith(color: AppColors.grey500),
                    ).animate().fade(delay: 200.ms),

                    const SizedBox(height: AppSpacing.xl3),

                    // Profile photo
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLighter,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 48,
                              color: AppColors.primary,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.white, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt_rounded,
                                  size: 14, color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fade(delay: 250.ms).scale(
                          begin: const Offset(0.8, 0.8),
                          curve: Curves.elasticOut,
                          duration: 600.ms,
                        ),

                    const SizedBox(height: AppSpacing.xl2),

                    AppTextField(
                      hint: 'Full Name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefix: const Icon(Icons.person_outline_rounded,
                          color: AppColors.grey400),
                    ).animate().fade(delay: 300.ms).slideY(begin: 0.2),

                    const SizedBox(height: AppSpacing.md),

                    AppTextField(
                      hint: '+966 50 123 4567',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      prefix: const Icon(Icons.phone_outlined,
                          color: AppColors.grey400),
                    ).animate().fade(delay: 380.ms).slideY(begin: 0.2),

                    const SizedBox(height: AppSpacing.md),

                    AppTextField(
                      hint: 'Email (optional)',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      prefix: const Icon(Icons.email_outlined,
                          color: AppColors.grey400),
                    ).animate().fade(delay: 460.ms).slideY(begin: 0.2),

                    const SizedBox(height: AppSpacing.xl),

                    // Terms checkbox
                    GestureDetector(
                      onTap: () =>
                          setState(() => _acceptTerms = !_acceptTerms),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: _acceptTerms
                                  ? AppColors.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color: _acceptTerms
                                    ? AppColors.primary
                                    : AppColors.grey400,
                                width: 1.5,
                              ),
                              borderRadius: AppRadius.roundedXs,
                            ),
                            child: _acceptTerms
                                ? const Icon(Icons.check_rounded,
                                    size: 14, color: AppColors.white)
                                : null,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: AppTypography.bodySmall,
                                children: [
                                  const TextSpan(
                                      text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fade(delay: 540.ms),

                    const SizedBox(height: AppSpacing.xl2),

                    AppButton(
                      label: 'Create Account',
                      loading: _loading,
                      onTap: _acceptTerms ? _onRegister : null,
                    ).animate().fade(delay: 600.ms).slideY(begin: 0.3),

                    const Spacer(),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style: AppTypography.bodyMedium),
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.login),
                            child: Text(
                              'Sign In',
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
