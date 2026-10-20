import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';

/// [DaySelector], görüntülenen ayın günlerini yatay bir şeritte listeleyen
/// ve kullanıcının istediği güne tıklayarak geçmesini sağlayan seçici bileşendir.
class DaySelector extends StatelessWidget {
  const DaySelector({
    super.key,
    required this.displayMonth,
    required this.selectedDate,
    required this.hasEntryOn,
    required this.onSelectDate,
  });

  final DateTime displayMonth;
  final DateTime selectedDate;
  final bool Function(DateTime) hasEntryOn;
  final ValueChanged<DateTime> onSelectDate;

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = DateTime(
      displayMonth.year,
      displayMonth.month + 1,
      0,
    ).day;

    return SizedBox(
      height: 78,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final DateTime dayDate = DateTime(
            displayMonth.year,
            displayMonth.month,
            index + 1,
          );
          final bool isSelected = _isSameDay(dayDate, selectedDate);
          final bool hasEntry = hasEntryOn(dayDate);

          return _DayItem(
            date: dayDate,
            isSelected: isSelected,
            hasEntry: hasEntry,
            onTap: () => onSelectDate(dayDate),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.date,
    required this.isSelected,
    required this.hasEntry,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final bool hasEntry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected ? AppColors.primary : AppColors.surface;
    final Color textColor = isSelected ? Colors.white : AppColors.textPrimary;
    final Color subTextColor = isSelected ? Colors.white70 : AppColors.textMuted;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 54,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
          boxShadow: isSelected
              ? <BoxShadow>[
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormatter.formatDayShort(date),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: subTextColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            _DotIndicator(
              hasEntry: hasEntry,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.hasEntry, required this.color});
  final bool hasEntry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (!hasEntry) {
      return const SizedBox(height: 5);
    }
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
