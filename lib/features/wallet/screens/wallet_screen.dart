import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';

/// WalletScreen — Wallet balance, transactions, and payment methods
/// شاشة المحفظة والمدفوعات
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Wallet', style: AppTypography.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.grey900),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      body: ListView(
        children: [
          // Balance card
          _BalanceCard().animate().fade().slideY(begin: -0.1),

          const SizedBox(height: AppSpacing.xl),

          // Quick actions
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding),
            child: Row(
              children: [
                _WalletAction(
                  icon: Icons.add_rounded,
                  label: 'Top Up',
                  color: AppColors.primary,
                  onTap: () {},
                ),
                const SizedBox(width: AppSpacing.sm),
                _WalletAction(
                  icon: Icons.send_rounded,
                  label: 'Send',
                  color: AppColors.success,
                  onTap: () {},
                ),
                const SizedBox(width: AppSpacing.sm),
                _WalletAction(
                  icon: Icons.history_rounded,
                  label: 'History',
                  color: AppColors.warning,
                  onTap: () {},
                ),
              ],
            ),
          ).animate().fade(delay: 100.ms),

          const SizedBox(height: AppSpacing.xl),

          // Payment methods
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment Methods', style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.base),
                _PaymentMethodCard(
                  icon: Icons.credit_card_rounded,
                  name: 'Visa ···· 4242',
                  sub: 'Expires 12/26',
                  isDefault: true,
                  color: const Color(0xFF1A1F71),
                ),
                const SizedBox(height: AppSpacing.sm),
                _PaymentMethodCard(
                  icon: Icons.credit_card_rounded,
                  name: 'Mastercard ···· 8888',
                  sub: 'Expires 09/25',
                  isDefault: false,
                  color: const Color(0xFFEB001B),
                ),
                const SizedBox(height: AppSpacing.sm),
                // Add card button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.base),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedXl,
                      border: Border.all(
                          color: AppColors.grey200, style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_rounded, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text('Add Payment Method',
                            style: AppTypography.titleSmall
                                .copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fade(delay: 200.ms),

          const SizedBox(height: AppSpacing.xl),

          // Recent transactions
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Recent Transactions',
                        style: AppTypography.titleMedium),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text('See all',
                          style: AppTypography.labelMedium
                              .copyWith(color: AppColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ..._transactions.asMap().entries.map((e) =>
                    _TransactionItem(tx: e.value)
                        .animate()
                        .fade(delay: Duration(milliseconds: 250 + e.key * 50))
                        .slideX(begin: 0.1)),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl2),
        ],
      ),
    );
  }
}

final _transactions = [
  _Tx('Trip to Riyadh Park Mall', 'Jul 22, 2026', -18.68, false),
  _Tx('Top Up', 'Jul 20, 2026', 100.0, true),
  _Tx('Trip to King Khalid Airport', 'Jul 18, 2026', -45.00, false),
  _Tx('Promo Credit', 'Jul 15, 2026', 20.0, true),
  _Tx('Trip to Kingdom Centre', 'Jul 14, 2026', -22.50, false),
];

class _Tx {
  final String name;
  final String date;
  final double amount;
  final bool isCredit;
  const _Tx(this.name, this.date, this.amount, this.isCredit);
}

class _BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: AppRadius.roundedXl2,
        boxShadow: AppShadows.primaryGlow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Wallet Balance',
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.white.withOpacity(0.7))),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.15),
                  borderRadius: AppRadius.roundedFull,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_rounded,
                        color: AppColors.white, size: 14),
                    const SizedBox(width: 4),
                    Text('RideGo Pay',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'SAR 234.50',
            style: AppTypography.displaySmall
                .copyWith(color: AppColors.white, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.base),
          // Mini stats
          Row(
            children: [
              _MiniStat('Earned', 'SAR 120'),
              const SizedBox(width: AppSpacing.xl),
              _MiniStat('Spent', 'SAR 885.50'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  const _MiniStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.caption
                .copyWith(color: AppColors.white.withOpacity(0.6))),
        Text(value,
            style: AppTypography.titleSmall
                .copyWith(color: AppColors.white)),
      ],
    );
  }
}

class _WalletAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _WalletAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.roundedLg,
            boxShadow: AppShadows.xs,
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 6),
              Text(label,
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.grey700)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String sub;
  final bool isDefault;
  final Color color;

  const _PaymentMethodCard({
    required this.icon,
    required this.name,
    required this.sub,
    required this.isDefault,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.roundedXl,
        border: Border.all(
          color: isDefault ? AppColors.primary : AppColors.grey200,
          width: isDefault ? 1.5 : 1,
        ),
        boxShadow: isDefault ? AppShadows.sm : AppShadows.xs,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: AppRadius.roundedMd,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.titleSmall),
                Text(sub,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.grey500)),
              ],
            ),
          ),
          if (isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryLighter,
                borderRadius: AppRadius.roundedFull,
              ),
              child: Text('Default',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final _Tx tx;
  const _TransactionItem({required this.tx});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.roundedLg,
        boxShadow: AppShadows.xs,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tx.isCredit
                  ? AppColors.successLight
                  : AppColors.grey100,
              borderRadius: AppRadius.roundedMd,
            ),
            child: Icon(
              tx.isCredit ? Icons.add_rounded : Icons.local_taxi_rounded,
              color: tx.isCredit ? AppColors.success : AppColors.grey600,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.name, style: AppTypography.titleSmall,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(tx.date,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.grey500)),
              ],
            ),
          ),
          Text(
            '${tx.isCredit ? '+' : '-'} SAR ${tx.amount.abs().toStringAsFixed(2)}',
            style: AppTypography.titleSmall.copyWith(
              color: tx.isCredit ? AppColors.success : AppColors.grey900,
            ),
          ),
        ],
      ),
    );
  }
}
