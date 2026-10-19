import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';

/// [MonthHeader], seçili ay ve yılı gösteren, aylar arası geçişi sağlayan üst başlıktır.
class MonthHeader extends StatelessWidget {
  const MonthHeader({
    super.key,
    required this.displayMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onJumpToToday,
  });

  final DateTime displayMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onJumpToToday;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String monthText = DateFormatter.formatMonthYear(displayMonth);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _MonthTitle(title: monthText, theme: theme),
          Row(
            children: <Widget>[
              _TodayButton(onTap: onJumpToToday),
              const SizedBox(width: 8),
              _NavIcon(icon: Icons.chevron_left_rounded, onTap: onPreviousMonth),
              const SizedBox(width: 4),
              _NavIcon(icon: Icons.chevron_right_rounded, onTap: onNextMonth),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthTitle extends StatelessWidget {
  const _MonthTitle({required this.title, required this.theme});
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
    );
  }
}

class _TodayButton extends StatelessWidget {
  const _TodayButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text('Bugün', style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(icon, size: 20, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
