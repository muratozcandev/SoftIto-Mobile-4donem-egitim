import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Maç bahis seçeneği ve oran butonu
class OddsButton extends StatelessWidget {
  final String label;
  final double odds;
  final bool isSelected;
  final VoidCallback onTap;
  final String? subtitle;
  final double? width;
  final double height;

  const OddsButton({
    super.key,
    required this.label,
    required this.odds,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
    this.width,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final activeBg = isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent;
    final activeText = Colors.black;
    final defaultBg = isDark ? const Color(0xFF141D26) : const Color(0xFFF1F5F9);
    final defaultBorder = isDark ? AppColors.darkDivider : AppColors.lightDivider;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          width: width,
          constraints: BoxConstraints(minHeight: height),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : defaultBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? activeBg : defaultBorder,
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeBg.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? activeText
                      : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                odds.toStringAsFixed(2),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isSelected
                      ? activeText
                      : (isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText),
                ),
              ),
              if (subtitle != null) ...[
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: isSelected ? activeText.withValues(alpha: 0.8) : Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
