import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Tutturdum genel yükleme bileşeni
class LoadingView extends StatelessWidget {
  final String? message;

  const LoadingView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 3,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
