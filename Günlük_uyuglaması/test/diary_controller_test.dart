import 'package:flutter_test/flutter_test.dart';
import 'package:sirdasim/core/utils/date_formatter.dart';
import 'package:sirdasim/features/diary/controllers/diary_controller.dart';

void main() {
  group('DateFormatter Tests', () {
    test('Tarih formatlama doğru çalışmalı', () {
      final DateTime testDate = DateTime(2026, 10, 19, 14, 30);
      expect(DateFormatter.formatMonthYear(testDate), 'Ekim 2026');
      expect(DateFormatter.formatDayShort(testDate), 'Pzt');
      expect(DateFormatter.formatDayFull(testDate), 'Pazartesi');
      expect(DateFormatter.formatTime(testDate), '14:30');
      expect(DateFormatter.toDateKey(testDate), '2026-10-19');
    });
  });

  group('DiaryController Tests', () {
    test('Başlangıçta örnek veriler ve bugünün tarihi atanmalı', () {
      final DiaryController controller = DiaryController();
      expect(controller.entries.isNotEmpty, isTrue);
      expect(controller.currentEntry, isNotNull);
      expect(controller.selectedMood, isNotEmpty);
      controller.dispose();
    });

    test('Günlük kaydı ekleme ve güncelleme çalışmalı', () {
      final DiaryController controller = DiaryController();
      final DateTime date = DateTime(2026, 10, 15);
      controller.selectDate(date);

      controller.saveEntry(
        title: 'Test Başlığı',
        content: 'Test günlüğü içeriği.',
        mood: '⚡',
      );

      expect(controller.currentEntry, isNotNull);
      expect(controller.currentEntry?.title, 'Test Başlığı');
      expect(controller.currentEntry?.content, 'Test günlüğü içeriği.');
      expect(controller.currentEntry?.mood, '⚡');
      expect(controller.hasEntryOn(date), isTrue);

      controller.dispose();
    });

    test('Ay değiştirme fonksiyonları çalışmalı', () {
      final DiaryController controller = DiaryController();
      final int initialMonth = controller.displayMonth.month;

      controller.nextMonth();
      final int nextMonth = controller.displayMonth.month;
      expect(nextMonth == (initialMonth % 12) + 1, isTrue);

      controller.previousMonth();
      expect(controller.displayMonth.month, initialMonth);

      controller.dispose();
    });
  });
}
