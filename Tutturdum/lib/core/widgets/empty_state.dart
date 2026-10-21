import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Boş liste ve içerik bulunamadı durumları için görsel bileşen
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.buttonLabel,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                    .withValues(alpha: 0.12),
              ),
              child: Icon(
                icon,
                size: 48,
                color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.4,
              ),
            ),
            if (buttonLabel != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
