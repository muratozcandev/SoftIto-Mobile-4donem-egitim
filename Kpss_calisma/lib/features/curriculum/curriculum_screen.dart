import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum erişimi için kütüphane
import '../../core/constants/app_colors.dart'; // Ders ve durum renkleri
import '../../core/constants/app_constants.dart'; // Durum sabitleri
import '../../models/topic.dart'; // Ders ve konu veri modelleri
import '../../providers/curriculum_provider.dart'; // Müfredat yöneticisi provider
import 'widgets/topic_item_tile.dart'; // Konu kartı bileşeni

/// KPSS derslerinin ve konularının listelendiği, filtrelendiği ve tamamlanma oranlarının takip edildiği ekran
class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // Üstteki ders sekmelerini (Türkçe, Matematik vb.) kontrol eden animasyonlu denetleyici
  int _selectedFilter = -1; // Seçili filtre: -1: Tümü, 0: Çalışılmadı, 1: Tekrar Edilecek, 2: Bitirdim

  @override
  void initState() {
    super.initState();
    // Mevcut ders sayısına göre TabController'ı başlatır
    final courses = context.read<CurriculumProvider>().courses;
    _tabController = TabController(length: courses.isEmpty ? 5 : courses.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Bellek sızıntısını önlemek için TabController'ı kapatır
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CurriculumProvider'ı dinleyerek veri değişikliklerinde ekranı otomatik günceller
    final curriculumProv = context.watch<CurriculumProvider>();
    final courses = curriculumProv.courses; // Yüklenen dersler

    // Veriler henüz yükleniyorsa veya liste boşsa dönen yükleme göstergesi (spinner) gösterir
    if (curriculumProv.isLoading || courses.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Ders sayısı değiştiyse sekme denetleyicisini yeni sayıya göre yeniden oluşturur
    if (_tabController.length != courses.length) {
      _tabController.dispose();
      _tabController = TabController(length: courses.length, vsync: this);
    }

    return Scaffold(
      // Sayfanın üst başlık çubuğu ve ders sekmeleri
      appBar: AppBar(
        title: const Text('Müfredat ve Konular'), // Sayfa başlığı
        bottom: TabBar(
          controller: _tabController, // Sekme denetleyicisi
          isScrollable: true, // Sekmelerin yatayda kaydırılabilmesini sağlar
          tabAlignment: TabAlignment.start, // Sekmeleri sola hizalar
          indicatorColor: AppColors.primary, // Seçili sekme alt çizgi rengi
          indicatorWeight: 3, // Seçili sekme alt çizgi kalınlığı
          labelPadding: const EdgeInsets.symmetric(horizontal: 16), // Sekme iç yatay boşluğu
          // Her bir ders için renkli noktalı sekme başlığı oluşturur
          tabs: courses.map((course) {
            final color = AppColors.getCourseColor(course.id); // Dersin kimlik rengi
            return Tab(
              child: Row(
                children: [
                  // Ders rengindeki küçük yuvarlak gösterge
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(course.title), // Ders adı (Örn: Türkçe)
                ],
              ),
            );
          }).toList(),
        ),
      ),
      // Seçili dersin konularını ve ilerlemesini gösteren sayfa görünümü
      body: TabBarView(
        controller: _tabController,
        children: courses.map((course) {
          return _buildCourseContent(context, course, curriculumProv);
        }).toList(),
      ),
    );
  }

  /// Belirli bir derse ait ilerleme kartını, filtreleme çiplerini ve konu listesini oluşturan widget
  Widget _buildCourseContent(
    BuildContext context,
    Course course,
    CurriculumProvider prov,
  ) {
    final theme = Theme.of(context);
    final courseColor = AppColors.getCourseColor(course.id); // Dersin rengi
    final completedCount = prov.getCourseCompletedTopics(course.id); // Bu derste bitirilen konu sayısı
    final totalCount = course.topics.length; // Toplam konu sayısı
    final progress = prov.getCourseProgress(course.id); // Ders tamamlama oranı (0.0 - 1.0)

    // Kullanıcının seçtiği duruma göre konuları filtreler
    final filteredTopics = course.topics.where((t) {
      if (_selectedFilter == -1) return true; // Filtre -1 ise tüm konuları göster
      final status = prov.getTopicStatus(t.id);
      return status == _selectedFilter; // Sadece seçilen durumdaki konuları getir
    }).toList();

    return Column(
      children: [
        // --- 1. Ders İlerleme Durumu Özeti Kartı ---
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            children: [
              // Kategori ve yüzde tamamlanma oranı başlığı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${course.category} • ${course.questionCount} Soru',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '%${(progress * 100).toInt()} Tamamlandı',
                    style: TextStyle(
                      color: courseColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Çizgisel İlerleme Çubuğu (LinearProgressIndicator)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress, // İlerleme değeri
                  minHeight: 8, // Çubuk yüksekliği
                  backgroundColor: courseColor.withValues(alpha: 0.15), // Pasif arka plan rengi
                  valueColor: AlwaysStoppedAnimation<Color>(courseColor), // İlerleme rengi
                ),
              ),
              const SizedBox(height: 10),
              // Konu tamamlama sayıları özeti
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$completedCount / $totalCount konu bitti',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    '${totalCount - completedCount} konu kaldı',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),

        // --- 2. Yatay Kaydırılabilir Filtreleme Çipleri (Filter Chips) ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Yatay kaydırma aktif
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Tümü filtresi
              _buildFilterChip(-1, 'Tümü (${course.topics.length})'),
              const SizedBox(width: 8),
              // Bitirdim filtresi
              _buildFilterChip(
                AppConstants.statusCompleted,
                'Bitirdim ($completedCount)',
                color: AppColors.completed,
              ),
              const SizedBox(width: 8),
              // Tekrar Edilecek filtresi
              _buildFilterChip(
                AppConstants.statusNeedsReview,
                'Tekrar Edilecek (${course.topics.where((t) => prov.getTopicStatus(t.id) == AppConstants.statusNeedsReview).length})',
                color: AppColors.needsReview,
              ),
              const SizedBox(width: 8),
              // Çalışılmadı filtresi
              _buildFilterChip(
                AppConstants.statusNotStarted,
                'Çalışılmadı (${course.topics.where((t) => prov.getTopicStatus(t.id) == AppConstants.statusNotStarted).length})',
                color: AppColors.notStarted,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // --- 3. Filtrelenmiş Konu Listesi ---
        Expanded(
          child: filteredTopics.isEmpty
              ? Center(
                  // Filtrede konu kalmadıysa boş durum uyarısı gösterir
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list_off, size: 48, color: theme.disabledColor),
                      const SizedBox(height: 12),
                      Text(
                        'Bu filtrede konu bulunamadı',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filteredTopics.length, // Gösterilecek konu sayısı
                  itemBuilder: (context, index) {
                    final topic = filteredTopics[index];
                    final status = prov.getTopicStatus(topic.id); // Konunun güncel durumu
                    return TopicItemTile(
                      topic: topic,
                      status: status,
                      courseColor: courseColor,
                      onStatusChanged: (newStatus) {
                        // Durum değiştiğinde provider üzerinden kaydet ve güncelle
                        prov.setTopicStatus(topic.id, newStatus);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  /// Filtreleme çipi (ChoiceChip) üreten yardımcı fonksiyon
  Widget _buildFilterChip(int value, String label, {Color? color}) {
    final isSelected = _selectedFilter == value; // Çipin seçili olup olmadığını kontrol eder
    return ChoiceChip(
      label: Text(label), // Çip metni
      selected: isSelected, // Seçim durumu
      onSelected: (selected) {
        setState(() {
          // Zaten seçiliyse kaldır (-1 yap), değilse bu filtreyi seç
          _selectedFilter = selected ? value : -1;
        });
      },
      selectedColor: (color ?? AppColors.primary).withValues(alpha: 0.2), // Seçildiğindeki arka plan rengi
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? (color ?? AppColors.primary) : null,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? (color ?? AppColors.primary) : Colors.transparent,
        ),
      ),
    );
  }
}
