import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum erişimi
import '../../../core/constants/app_colors.dart'; // Ders renk sabitleri
import '../../../core/utils/date_utils.dart'; // Süre metin formatlayıcı (X sa Y dk)
import '../../../providers/curriculum_provider.dart'; // Ders listesine erişim için provider
import '../../../providers/question_provider.dart'; // Çalışma seansını kaydetmek için provider

/// Pomodoro veya kronometre çalışması bittiğinde, sürenin hangi derse ait olduğunu sorup veritabanına kaydeden diyalog penceresi
class SaveSessionDialog extends StatefulWidget {
  final int durationMinutes; // Tamamlanan çalışma süresi (dakika)
  final String sessionType; // Çalışma sayacı türü ('pomodoro' veya 'stopwatch')

  const SaveSessionDialog({
    super.key,
    required this.durationMinutes,
    required this.sessionType,
  });

  /// Bu diyalog penceresini ekranda gösteren statik yardımcı fonksiyon
  static Future<void> show(
    BuildContext context, {
    required int durationMinutes,
    required String sessionType,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false, // Kullanıcı boş alana tıklayarak yanlışlıkla kapatamasın
      builder: (context) => SaveSessionDialog(
        durationMinutes: durationMinutes,
        sessionType: sessionType,
      ),
    );
  }

  @override
  State<SaveSessionDialog> createState() => _SaveSessionDialogState();
}

class _SaveSessionDialogState extends State<SaveSessionDialog> {
  String? _selectedCourseId; // Kullanıcının seçtiği dersin ID'si (Örn: 'tarih')
  final _noteController = TextEditingController(); // İsteğe bağlı seans notu denetleyicisi

  @override
  void initState() {
    super.initState();
    // İlk dersi varsayılan olarak seçili başlatır
    final courses = context.read<CurriculumProvider>().courses;
    if (courses.isNotEmpty) {
      _selectedCourseId = courses.first.id;
    }
  }

  @override
  void dispose() {
    _noteController.dispose(); // Bellek sızıntısını önlemek için metin denetleyicisini kapatır
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CurriculumProvider>().courses; // Dersler listesi

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Köşeleri 20px yuvarlatılmış diyalog kutusu
      // Diyalog Başlık Satırı
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Oturumu Kaydet',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
        ],
      ),
      // Diyalog İçeriği
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tamamlanan Süreyi Gösteren Bilgi Rozeti
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, color: AppColors.secondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Tamamlanan Süre: ${AppDateUtils.formatDuration(widget.durationMinutes)}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Ders Seçimi Başlığı
            const Text(
              'Hangi derse çalıştın?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            // Ders Seçim Hapları (Wrap ile alt alta dizilebilen çipler)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: courses.map((c) {
                final isSelected = _selectedCourseId == c.id;
                final color = AppColors.getCourseColor(c.id);
                return ChoiceChip(
                  selected: isSelected,
                  label: Text(c.title),
                  selectedColor: color.withValues(alpha: 0.2),
                  side: BorderSide(color: isSelected ? color : Colors.transparent),
                  labelStyle: TextStyle(
                    color: isSelected ? color : null,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _selectedCourseId = c.id); // Seçili dersi güncelle
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            // İsteğe Bağlı Oturum Notu Alanı
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Oturum notu (opsiyonel)',
                prefixIcon: Icon(Icons.edit_note, size: 20),
              ),
            ),
          ],
        ),
      ),
      // Alt İşlem Butonları (İptal ve Kaydet)
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Kaydetmeden kapat
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: _saveSession, // Seansı veritabanına kaydet
          child: const Text('Kaydet'),
        ),
      ],
    );
  }

  /// Seçilen dersi ve süreyi QuestionProvider üzerinden Hive veritabanına ekleyen metot
  void _saveSession() {
    if (_selectedCourseId == null) return;
    context.read<QuestionProvider>().addStudySession(
          courseId: _selectedCourseId!,
          durationInMinutes: widget.durationMinutes,
          date: DateTime.now(),
          type: widget.sessionType,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        );

    Navigator.pop(context); // Diyaloğu kapat
    // Başarı bildirimi göster
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Çalışma süresi başarıyla kaydedildi!'),
        backgroundColor: AppColors.completed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
