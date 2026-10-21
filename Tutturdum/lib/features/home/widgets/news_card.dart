import 'package:flutter/material.dart';
import '../../../data/models/auxiliary_models.dart';
import '../../../core/constants/app_colors.dart';

/// Futbol Haber Kartı
class NewsCard extends StatelessWidget {
  final NewsItem news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    news.badgeText,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                    ),
                  ),
                ),
                Text(
                  news.date,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              news.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              news.summary,
              style: TextStyle(
                fontSize: 13,
                color: theme.textTheme.bodyMedium?.color,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
