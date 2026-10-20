import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../controllers/diary_controller.dart';
import '../widgets/day_selector.dart';
import '../widgets/diary_date.dart';
import '../widgets/diary_editor.dart';
import '../widgets/month_header.dart';

/// [DiaryScreen], Sırdaşım uygulamasının ana ekranıdır.
/// Durum yönetimini yerel [ListenableBuilder] ve [DiaryController] ile sağlar;
/// sayfa düzeyinde ağır `setState` kullanılmaz.
class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late final DiaryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DiaryController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _DiaryAppBar(),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (BuildContext context, _) {
            return _DiaryContent(controller: _controller);
          },
        ),
      ),
    );
  }
}

class _DiaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DiaryAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: <Widget>[
          Icon(Icons.auto_stories_rounded, color: AppColors.primary, size: 26),
          SizedBox(width: 10),
          Text('Sırdaşım'),
        ],
      ),
      actions: const <Widget>[
        _StatusChip(),
        SizedBox(width: 16),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Akıllı Günlük',
        style: TextStyle(
          color: AppColors.onPrimaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DiaryContent extends StatelessWidget {
  const _DiaryContent({required this.controller});
  final DiaryController controller;

  @override
  Widget build(BuildContext context) {
    final DateTime selected = controller.selectedDate;
    final String entryTime = controller.currentEntry?.time ??
        DateFormatter.formatTime(DateTime.now());

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MonthHeader(
            displayMonth: controller.displayMonth,
            onPreviousMonth: controller.previousMonth,
            onNextMonth: controller.nextMonth,
            onJumpToToday: controller.jumpToToday,
          ),
          DaySelector(
            displayMonth: controller.displayMonth,
            selectedDate: selected,
            hasEntryOn: controller.hasEntryOn,
            onSelectDate: controller.selectDate,
          ),
          const SizedBox(height: 8),
          DiaryDate(
            selectedDate: selected,
            entryTime: entryTime,
            selectedMood: controller.selectedMood,
            onMoodSelected: controller.setMood,
          ),
          DiaryEditor(
            entry: controller.currentEntry,
            selectedDate: selected,
            selectedMood: controller.selectedMood,
            onSave: controller.saveEntry,
          ),
        ],
      ),
    );
  }
}
