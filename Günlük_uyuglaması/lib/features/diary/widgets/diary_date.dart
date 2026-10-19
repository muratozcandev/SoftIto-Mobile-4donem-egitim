import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';

/// [DiaryDate], seçili günün tam tarihini, saati ve ruh hali (mood) seçimini gösteren bilgi kartıdır.
class DiaryDate extends StatelessWidget {
  const DiaryDate({
    super.key,
    required this.selectedDate,
    required this.entryTime,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  final DateTime selectedDate;
  final String entryTime;
  final String selectedMood;
  final ValueChanged<String> onMoodSelected;

  static const List<String> availableMoods = <String>[
    '😊',
    '😌',
    '✨',
    '☕',
    '⚡',
    '🌧️',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String fullDate = DateFormatter.formatFullDate(selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _DateAndTimeRow(fullDate: fullDate, time: entryTime, theme: theme),
            const SizedBox(height: 12),
            _MoodSelector(
              selectedMood: selectedMood,
              moods: availableMoods,
              onSelect: onMoodSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateAndTimeRow extends StatelessWidget {
  const _DateAndTimeRow({
    required this.fullDate,
    required this.time,
    required this.theme,
  });

  final String fullDate;
  final String time;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  fullDate,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        _TimeBadge(time: time),
      ],
    );
  }
}

class _TimeBadge extends StatelessWidget {
  const _TimeBadge({required this.time});
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.timeBadgeBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.access_time_filled_rounded,
            size: 13,
            color: AppColors.timeBadgeText,
          ),
          const SizedBox(width: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.timeBadgeText,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  const _MoodSelector({
    required this.selectedMood,
    required this.moods,
    required this.onSelect,
  });

  final String selectedMood;
  final List<String> moods;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          'Ruh Hali:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: moods.map((String mood) {
                final bool isSelected = mood == selectedMood;
                return Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => onSelect(mood),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryContainer
                            : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        mood,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
