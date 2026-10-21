import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Tutturdum genel buton bileşeni
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isOutlined;
  final double height;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isOutlined = false,
    this.height = 50,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent;
    final defaultFg = isDark ? Colors.black : Colors.white;

    final child = isLoading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined ? (foregroundColor ?? defaultBg) : (foregroundColor ?? defaultFg),
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: isOutlined ? (foregroundColor ?? defaultBg) : (foregroundColor ?? defaultFg),
                ),
              ),
            ],
          );

    return SizedBox(
      height: height,
      width: width,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: backgroundColor ?? defaultBg, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? defaultBg,
                foregroundColor: foregroundColor ?? defaultFg,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: child,
            ),
    );
  }
}
