import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:flutter/services.dart'; // Klavyeden yalnızca sayı girişine izin vermek için formatlayıcılar
import 'package:provider/provider.dart'; // Provider durum erişimi
import '../../../core/constants/app_colors.dart'; // Ders ve durum renkleri
import '../../../core/utils/date_utils.dart'; // Tarih biçimlendirme yardımcısı
import '../../../core/utils/kpss_calculator.dart'; // 4 yanlış 1 doğru net hesaplama aracı
import '../../../providers/curriculum_provider.dart'; // Ders listesini almak için provider
import '../../../providers/question_provider.dart'; // Çözülen soruları kaydetmek için provider

/// Kullanıcının çözdüğü soruları (ders, doğru, yanlış, boş, tarih ve not) sisteme girmesini sağlayan alt form sayfası (BottomSheet)
class AddQuestionSheet extends StatefulWidget {
  const AddQuestionSheet({super.key});

  /// Bu alt form sayfasını modal olarak ekranda açan statik yardımcı metot
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Klavyenin alt formu yukarı itmesi için tam boyuta izin verir
      backgroundColor: Colors.transparent, // Köşeleri yuvarlatılmış kart görünümü için şeffaf zemin
      builder: (context) => const AddQuestionSheet(),
    );
  }

  @override
  State<AddQuestionSheet> createState() => _AddQuestionSheetState();
}

class _AddQuestionSheetState extends State<AddQuestionSheet> {
  String? _selectedCourseId; // Seçilen dersin kimlik kodu (Örn: 'turkce', 'matematik')
  final _correctController = TextEditingController(); // Doğru sayısı giriş kutusu denetleyicisi
  final _wrongController = TextEditingController(); // Yanlış sayısı giriş kutusu denetleyicisi
  final _emptyController = TextEditingController(); // Boş sayısı giriş kutusu denetleyicisi
  final _noteController = TextEditingController(); // İsteğe bağlı not giriş kutusu denetleyicisi
  DateTime _selectedDate = DateTime.now(); // Soru çözüm tarihi (Varsayılan: Bugün)

  double _calculatedNet = 0.0; // Anlık canlı hesaplanan KPSS neti
  int _totalQuestions = 0; // Toplam çözülen/girilen soru sayısı (D + Y + B)

  @override
  void initState() {
    super.initState();
    // İlk dersi varsayılan olarak seçili yapar
    final courses = context.read<CurriculumProvider>().courses;
    if (courses.isNotEmpty) {
      _selectedCourseId = courses.first.id;
    }
    // Her rakam girildiğinde netin ve toplam sorunun canlı güncellenmesi için dinleyiciler ekler
    _correctController.addListener(_recalculate);
    _wrongController.addListener(_recalculate);
    _emptyController.addListener(_recalculate);
  }

  /// Kutulardaki doğru, yanlış ve boş değerlerini okuyarak toplam soru ve neti anında hesaplar
  void _recalculate() {
    final d = int.tryParse(_correctController.text) ?? 0; // Doğru sayısı
    final y = int.tryParse(_wrongController.text) ?? 0; // Yanlış sayısı
    final b = int.tryParse(_emptyController.text) ?? 0; // Boş sayısı
    setState(() {
      _totalQuestions = d + y + b; // Toplam soru
      _calculatedNet = KpssCalculator.calculateNet(d, y); // KPSS 4 yanlış 1 doğru kuralı neti
    });
  }

  @override
  void dispose() {
    // Bellek sızıntılarını engellemek için tüm denetleyicileri serbest bırakır
    _correctController.dispose();
    _wrongController.dispose();
    _emptyController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courses = context.watch<CurriculumProvider>().courses; // Dersler listesi
    // Klavyenin ekranı kapatmaması için klavyenin alt boşluk yüksekliğini alır
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor, // Tema arka planı
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // Üst köşelere 24px ovallik
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset), // Klavye kadar alttan esneme payı bırakır
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Sadece içerik kadar yer kaplar
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üstteki gri tutamaç çizgisi
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Başlık ve Kapatma Butonu Satırı
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Soru Girişi Ekle',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context), // Alt formu kapat
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- 1. Ders Seçimi Bölümü ---
            const Text(
              'Ders Seçimi',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 8),
            // Yatay kaydırılabilir ders seçim hapları (ChoiceChips)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: courses.map((course) {
                  final isSelected = _selectedCourseId == course.id;
                  final color = AppColors.getCourseColor(course.id);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      selected: isSelected, // Seçili mi?
                      label: Text(course.title), // Ders adı
                      selectedColor: color.withValues(alpha: 0.2), // Seçili arka plan
                      side: BorderSide(
                        color: isSelected ? color : Colors.transparent,
                        width: 1.5,
                      ),
                      labelStyle: TextStyle(
                        color: isSelected ? color : null,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                      onSelected: (val) {
                        if (val) {
                          setState(() => _selectedCourseId = course.id); // Seçilen dersi güncelle
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // --- 2. Sayı Girişleri: Doğru, Yanlış ve Boş Kutuları ---
            Row(
              children: [
                // Doğru Soru Giriş Kutusu (Yeşil Vurgulu)
                Expanded(
                  child: _buildNumberInput(
                    controller: _correctController,
                    label: 'Doğru',
                    color: AppColors.correct,
                  ),
                ),
                const SizedBox(width: 12),
                // Yanlış Soru Giriş Kutusu (Kırmızı Vurgulu)
                Expanded(
                  child: _buildNumberInput(
                    controller: _wrongController,
                    label: 'Yanlış',
                    color: AppColors.wrong,
                  ),
                ),
                const SizedBox(width: 12),
                // Boş Soru Giriş Kutusu (Gri Vurgulu)
                Expanded(
                  child: _buildNumberInput(
                    controller: _emptyController,
                    label: 'Boş',
                    color: AppColors.empty,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- 3. Canlı Net Hesaplama ve Önizleme Kutusu ---
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hesaplanan Net',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Toplam Soru: $_totalQuestions (4 Yanlış = 1 Doğru)',
                        style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  // Canlı hesaplanan net değeri (Örn: 23.75)
                  Text(
                    _calculatedNet.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- 4. Tarih Seçici Satırı ---
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Tarih: ${AppDateUtils.formatDate(_selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _pickDate, // Tarih değiştirme takvimini aç
                  child: const Text('Değiştir'),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // --- 5. İsteğe Bağlı Not Girişi ---
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Not veya konu bilgisi (opsiyonel)',
                prefixIcon: Icon(Icons.note_alt_outlined, size: 20),
              ),
            ),
            const SizedBox(height: 24),

            // --- 6. Kaydı Ekle Butonu ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // Toplam soru 0'dan büyükse buton aktif, 0 ise pasif (null)
                onPressed: _totalQuestions > 0 ? _saveQuestionLog : null,
                child: const Text('Kaydı Ekle'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sayısal giriş kutusunu (Doğru/Yanlış/Boş) oluşturan yardımcı fonksiyon
  Widget _buildNumberInput({
    required TextEditingController controller,
    required String label,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number, // Sadece sayısal klavye
          inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Harf yazılmasını engeller
          textAlign: TextAlign.center, // Sayıyı ortalar
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            hintText: '0',
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2), // Odaklanıldığında kendi renginde çerçeve
            ),
          ),
        ),
      ],
    );
  }

  /// Takvim penceresini açarak tarih seçilmesini sağlayan fonksiyon
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked); // Yeni tarihi ata
    }
  }

  /// Girilen soru kayıt verilerini toplayıp QuestionProvider üzerinden Hive'a kaydeden fonksiyon
  void _saveQuestionLog() {
    if (_selectedCourseId == null) return;
    final d = int.tryParse(_correctController.text) ?? 0;
    final y = int.tryParse(_wrongController.text) ?? 0;
    final b = int.tryParse(_emptyController.text) ?? 0;

    // Soru kaydını veritabanına ve listeye ekle
    context.read<QuestionProvider>().addQuestionLog(
          courseId: _selectedCourseId!,
          correct: d,
          wrong: y,
          empty: b,
          date: _selectedDate,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        );

    Navigator.pop(context); // Formu kapat

    // Başarı bildirim çubuğu (SnackBar) göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Soru kaydı başarıyla eklendi! Net: ${_calculatedNet.toStringAsFixed(2)}'),
        backgroundColor: AppColors.completed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
