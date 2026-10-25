import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:flutter/services.dart'; // Klavyeden yalnızca rakam girişine izin veren formatlayıcılar için
import 'package:provider/provider.dart'; // MockExamProvider erişimi için
import '../../../core/constants/app_colors.dart'; // Renk sabitleri
import '../../../core/utils/date_utils.dart'; // Tarih formatlayıcı
import '../../../core/utils/kpss_calculator.dart'; // KPSS 4 yanlış 1 doğru kuralı net hesaplayıcı
import '../../../providers/mock_exam_provider.dart'; // Deneme sınavlarını kaydeden provider

/// Kullanıcının yeni bir KPSS Genel Yetenek - Genel Kültür deneme sınavı sonucu girmesini sağlayan alt sayfa (BottomSheet)
class AddMockExamSheet extends StatefulWidget {
  const AddMockExamSheet({super.key});

  /// Bu alt sayfayı çağıran ve ekranda açılmasını sağlayan statik yardımcı fonksiyon
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Klavyenin formu yukarı itmesine ve tam boyuta olanak tanır
      backgroundColor: Colors.transparent, // Köşelerin yuvarlak görünmesi için şeffaf zemin
      builder: (context) => const AddMockExamSheet(),
    );
  }

  @override
  State<AddMockExamSheet> createState() => _AddMockExamSheetState();
}

class _AddMockExamSheetState extends State<AddMockExamSheet> {
  // --- Metin Kutusu Denetleyicileri (Controllers) ---
  final _titleController = TextEditingController(); // Deneme sınavının adı/yayıncısı için denetleyici
  final _gyCorrectController = TextEditingController(); // Genel Yetenek doğru sayısı
  final _gyWrongController = TextEditingController(); // Genel Yetenek yanlış sayısı
  final _gkCorrectController = TextEditingController(); // Genel Kültür doğru sayısı
  final _gkWrongController = TextEditingController(); // Genel Kültür yanlış sayısı
  final _noteController = TextEditingController(); // İsteğe bağlı not metni
  DateTime _selectedDate = DateTime.now(); // Sınav tarihi (Varsayılan: Bugün)

  // Canlı (anlık) hesaplanan net değerleri
  double _gyNet = 0.0; // Anlık GY Neti
  double _gkNet = 0.0; // Anlık GK Neti
  double _totalNet = 0.0; // Anlık Toplam Net (GY Net + GK Net)

  @override
  void initState() {
    super.initState();
    // Kutulara her rakam yazıldığında netlerin anında canlı hesaplanması için dinleyiciler eklenir
    _gyCorrectController.addListener(_recalc);
    _gyWrongController.addListener(_recalc);
    _gkCorrectController.addListener(_recalc);
    _gkWrongController.addListener(_recalc);
  }

  /// Doğru ve yanlış kutularındaki değerleri okuyup netleri yeniden hesaplayan fonksiyon
  void _recalc() {
    final gyC = int.tryParse(_gyCorrectController.text) ?? 0; // GY Doğru
    final gyW = int.tryParse(_gyWrongController.text) ?? 0; // GY Yanlış
    final gkC = int.tryParse(_gkCorrectController.text) ?? 0; // GK Doğru
    final gkW = int.tryParse(_gkWrongController.text) ?? 0; // GK Yanlış

    setState(() {
      _gyNet = KpssCalculator.calculateNet(gyC, gyW); // GY Net = D - (Y / 4)
      _gkNet = KpssCalculator.calculateNet(gkC, gkW); // GK Net = D - (Y / 4)
      _totalNet = _gyNet + _gkNet; // Toplam Net
    });
  }

  @override
  void dispose() {
    // Bellek sızıntılarını önlemek için tüm denetleyicileri serbest bırakır
    _titleController.dispose();
    _gyCorrectController.dispose();
    _gyWrongController.dispose();
    _gkCorrectController.dispose();
    _gkWrongController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Klavyenin ekranı kapatmaması için klavye alt boşluğunu hesaplar
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor, // Temanın arka plan rengi
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // Üst köşelere 24px ovallik
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset), // Klavye yüksekliği kadar alttan pay bırakır
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // İçerik kadar yükseklik kaplar
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üstteki tutamaç çizgisi (Sheet drag handle)
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
            
            // Başlık ve Kapatma Çarpı Butonu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Deneme Sınavı Ekle',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context), // Pencereyi kapatır
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Deneme Adı / Yayıncı Giriş Kutusu
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Deneme Adı / Yayın (Örn: Pegem TG-1, Yediiklim)',
                prefixIcon: Icon(Icons.assignment),
              ),
            ),
            const SizedBox(height: 16),

            // --- Genel Yetenek Bölümü (Türkçe + Matematik = 60 Soru) ---
            _buildSectionHeader('Genel Yetenek (GY - 60 Soru)', AppColors.courseTurkce),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildInput(
                    controller: _gyCorrectController,
                    label: 'GY Doğru',
                    color: AppColors.correct, // Yeşil etiket
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInput(
                    controller: _gyWrongController,
                    label: 'GY Yanlış',
                    color: AppColors.wrong, // Kırmızı etiket
                  ),
                ),
                const SizedBox(width: 12),
                // GY Canlı Net Rozeti
                _buildNetBadge('GY Net', _gyNet, AppColors.courseTurkce),
              ],
            ),
            const SizedBox(height: 16),

            // --- Genel Kültür Bölümü (Tarih + Coğrafya + Vatandaşlık = 60 Soru) ---
            _buildSectionHeader('Genel Kültür (GK - 60 Soru)', AppColors.courseTarih),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildInput(
                    controller: _gkCorrectController,
                    label: 'GK Doğru',
                    color: AppColors.correct,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInput(
                    controller: _gkWrongController,
                    label: 'GK Yanlış',
                    color: AppColors.wrong,
                  ),
                ),
                const SizedBox(width: 12),
                // GK Canlı Net Rozeti
                _buildNetBadge('GK Net', _gkNet, AppColors.courseTarih),
              ],
            ),
            const SizedBox(height: 16),

            // --- Toplam Canlı Net Önizleme Kartı (Büyük Renkli Kapsül) ---
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark], // İndigo degrade
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Toplam Deneme Neti:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _totalNet.toStringAsFixed(2), // Virgülden sonra 2 hane net
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Tarih Seçici Satırı ---
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Tarih: ${AppDateUtils.formatDate(_selectedDate)}', // Seçili tarihi göster
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _pickDate, // Takvim açma fonksiyonu
                  child: const Text('Değiştir'),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // İsteğe Bağlı Not Alanı
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Sınav hakkında notlar (opsiyonel)',
                prefixIcon: Icon(Icons.note_alt_outlined, size: 20),
              ),
            ),
            const SizedBox(height: 24),

            // Kaydet Butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveMockExam, // Denemeyi veritabanına ekle
                child: const Text('Deneme Sonucunu Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// GY ve GK bölümlerinin renkli dikey çizgili başlıklarını üretir
  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: color),
        ),
      ],
    );
  }

  /// Doğru veya Yanlış giriş kutusu oluşturan yardımcı widget
  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: color),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number, // Sadece sayı klavyesi
          inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Harf girişini engeller
          textAlign: TextAlign.center, // Sayıyı ortaya hizalar
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
            hintText: '0',
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }

  /// Anlık GY veya GK netini gösteren küçük renkli rozet kutusu
  Widget _buildNetBadge(String title, double net, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(
            net.toStringAsFixed(2),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }

  /// Takvim penceresini açıp kullanıcının sınav tarihini seçmesini sağlayan fonksiyon
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

  /// Formdaki tüm verileri toplayıp MockExamProvider üzerinden kaydeden fonksiyon
  void _saveMockExam() {
    final title = _titleController.text.trim();
    final gyC = int.tryParse(_gyCorrectController.text) ?? 0;
    final gyW = int.tryParse(_gyWrongController.text) ?? 0;
    final gkC = int.tryParse(_gkCorrectController.text) ?? 0;
    final gkW = int.tryParse(_gkWrongController.text) ?? 0;

    // Provider üzerinden yeni denemeyi Hive'a ve listeye ekle
    context.read<MockExamProvider>().addExam(
          title: title.isEmpty ? 'KPSS Denemesi' : title,
          date: _selectedDate,
          gyCorrect: gyC,
          gyWrong: gyW,
          gkCorrect: gkC,
          gkWrong: gkW,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        );

    Navigator.pop(context); // Alt sayfayı kapat
    // Başarı bildirim çubuğunu göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deneme başarıyla kaydedildi! Toplam Net: ${_totalNet.toStringAsFixed(2)}'),
        backgroundColor: AppColors.completed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
