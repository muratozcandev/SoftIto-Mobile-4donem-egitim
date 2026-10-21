import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onAddMoneyTap;
  final VoidCallback? onTransferTap;

  const BalanceCard({
    super.key,
    required this.onTap,
    this.onAddMoneyTap,
    this.onTransferTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF141C2F),
                  const Color(0xFF0F2338),
                ]
              : [
                  Colors.white,
                  const Color(0xFFECFDF5),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark ? const Color(0xFF1E3A5F) : const Color(0xFFA7F3D0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.primaryMint.withOpacity(0.08)
                : AppColors.primaryEmerald.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.primaryMint.withOpacity(0.15)
                                  : AppColors.primaryEmerald.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 20,
                              color: isDark
                                  ? AppColors.primaryMint
                                  : AppColors.primaryEmerald,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Sanal Portföy Bakiyesi',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.primaryMint.withOpacity(0.2)
                            : AppColors.primaryEmerald.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bolt_rounded,
                            size: 14,
                            color: isDark
                                ? AppColors.primaryMint
                                : AppColors.primaryEmerald,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'Demo',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.primaryMint
                                  : AppColors.primaryEmerald,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<int>(
                  valueListenable: AppController.instance.balance,
                  builder: (context, balanceKurus, _) {
                    final String formatted =
                        AppController.instance.formattedBalance;
                    return Text(
                      formatted,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 6),
                Text(
                  'Detaylı işlem geçmişi ve cüzdan yönetimi için dokunun',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.darkTextMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
                if (onAddMoneyTap != null || onTransferTap != null) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      if (onAddMoneyTap != null)
                        Expanded(
                          child: InkWell(
                            onTap: onAddMoneyTap,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCardVariant
                                    : AppColors.lightCardVariant,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline_rounded,
                                    size: 16,
                                    color: isDark
                                        ? AppColors.primaryMint
                                        : AppColors.primaryEmerald,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Para Ekle',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (onAddMoneyTap != null && onTransferTap != null)
                        const SizedBox(width: 12),
                      if (onTransferTap != null)
                        Expanded(
                          child: InkWell(
                            onTap: onTransferTap,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCardVariant
                                    : AppColors.lightCardVariant,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.send_rounded,
                                    size: 16,
                                    color: AppColors.accentCyan,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Transfer',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
