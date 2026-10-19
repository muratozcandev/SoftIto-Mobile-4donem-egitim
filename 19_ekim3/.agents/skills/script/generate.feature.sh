#!/usr/bin/env bash
# ==============================================================================
# Flutter Modüler Feature Kod Üreteci (Feature Scaffold Generator)
#
# Standartlar: Clean Architecture, ValueNotifier Reaktif State,
# <40 Satır UI Build Kuralı, Immutability, Otomatik Birim Test Üretimi
#
# Kullanım:
#   ./generate.feature.sh <feature_name>
#
# Örnek:
#   ./generate.feature.sh water_tracker
#   ./generate.feature.sh sleep_monitor
# ==============================================================================

set -euo pipefail

# ANSI Renk Kodları
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Yardım Fonksiyonu
show_help() {
  cat << EOF
Flutter Modüler Feature Üreteci (Susadım v1 & Clean Scaffold)

Kullanım:
  $0 <feature_name> [seçenekler]

Argümanlar:
  feature_name    Modülün snake_case adı (örn: water_tracker, workout, calorie_tracker)

Seçenekler:
  -h, --help      Bu yardım iletisini gösterir
  -f, --force     Mevcut dosyaların üzerine yazar

Örnek:
  $0 step_counter
  $0 water_tracker --force
EOF
}

# Parametre Kontrolü
FORCE=0
FEATURE_INPUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    -f|--force)
      FORCE=1
      shift
      ;;
    *)
      if [[ -z "$FEATURE_INPUT" ]]; then
        FEATURE_INPUT="$1"
      else
        echo -e "${RED}Hata: Bilinmeyen parametre '$1'${NC}"
        show_help
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ -z "$FEATURE_INPUT" ]]; then
  echo -e "${RED}Hata: Lütfen bir feature adı giriniz!${NC}"
  echo -e "${YELLOW}Kullanım: $0 <feature_name>${NC}"
  exit 1
fi

# snake_case doğrulama
if [[ ! "$FEATURE_INPUT" =~ ^[a-z0-9_]+$ ]]; then
  echo -e "${RED}Hata: Feature adı yalnızca küçük harf, rakam ve alt tire içerebilir (snake_case)!${NC}"
  echo -e "${YELLOW}Örnek: water_tracker, workout_summary${NC}"
  exit 1
fi

FEATURE_NAME="$FEATURE_INPUT"

# PascalCase Dönüştürücü (örn: water_tracker -> WaterTracker)
to_pascal_case() {
  echo "$1" | awk -F_ '{for(i=1;i<=NF;i++) printf toupper(substr($i,1,1)) substr($i,2); print ""}'
}

# Başlık Dönüştürücü (örn: water_tracker -> Water Tracker)
to_title_case() {
  echo "$1" | awk -F_ '{for(i=1;i<=NF;i++) printf toupper(substr($i,1,1)) substr($i,2) (i==NF?"":" "); print ""}'
}

PASCAL_NAME=$(to_pascal_case "$FEATURE_NAME")
TITLE_NAME=$(to_title_case "$FEATURE_NAME")

# Hedef Dizinler
LIB_BASE="lib/features/$FEATURE_NAME"
TEST_BASE="test/features/$FEATURE_NAME"

CONTROLLER_DIR="$LIB_BASE/controllers"
MODEL_DIR="$LIB_BASE/models"
VIEW_DIR="$LIB_BASE/views"
WIDGET_DIR="$LIB_BASE/widgets"

CONTROLLER_FILE="$CONTROLLER_DIR/${FEATURE_NAME}_controller.dart"
MODEL_FILE="$MODEL_DIR/${FEATURE_NAME}_model.dart"
VIEW_FILE="$VIEW_DIR/${FEATURE_NAME}_view.dart"
CARD_FILE="$WIDGET_DIR/${FEATURE_NAME}_card.dart"
TEST_FILE="$TEST_BASE/${FEATURE_NAME}_controller_test.dart"

echo -e "${CYAN}=== Flutter Feature Scaffold Üretimi Başlatılıyor ===${NC}"
echo -e "Feature:   ${GREEN}$FEATURE_NAME${NC}"
echo -e "Sınıflar:  ${GREEN}${PASCAL_NAME}Controller, ${PASCAL_NAME}Model, ${PASCAL_NAME}View${NC}"
echo -e "Konum:     ${GREEN}$LIB_BASE${NC}"
echo ""

# Dizinleri Oluştur
mkdir -p "$CONTROLLER_DIR"
mkdir -p "$MODEL_DIR"
mkdir -p "$VIEW_DIR"
mkdir -p "$WIDGET_DIR"
mkdir -p "$TEST_BASE"

write_file_safely() {
  local target_file="$1"
  local content="$2"

  if [[ -f "$target_file" && $FORCE -eq 0 ]]; then
    echo -e "${YELLOW}[ATLANDI] Dosya zaten mevcut: $target_file (--force ile ezebilirsiniz)${NC}"
  else
    printf "%s\n" "$content" > "$target_file"
    echo -e "${GREEN}[OLUŞTURULDU]${NC} $target_file"
  fi
}

# 1. Controller Dosyasını Oluştur
CONTROLLER_CONTENT=$(cat << EOF
import 'package:flutter/foundation.dart';
import '../models/${FEATURE_NAME}_model.dart';

/// ${TITLE_NAME} iş mantığını ve reaktif ValueNotifier durumunu yöneten Controller.
/// 
/// Görünüm katmanından (UI) bağımsızdır ve doğrudan saf Dart testleriyle doğrulanabilir.
class ${PASCAL_NAME}Controller {
  /// Birincil sayısal durum bildiricisi
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  /// Veri geçmişi listesi bildiricisi
  final ValueNotifier<List<${PASCAL_NAME}Model>> items = ValueNotifier<List<${PASCAL_NAME}Model>>([]);

  /// Asenkron yüklenme durumu
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  /// Günlük veya hedef eşik değeri
  final int targetGoal = 100;

  /// İlerleme oranı [0.0 - 1.0] aralığında
  double get progressRatio => (counter.value / targetGoal).clamp(0.0, 1.0);

  /// Durum artırma aksiyonu
  void increment([int step = 1]) {
    if (step <= 0) return;

    counter.value += step;

    final newItem = ${PASCAL_NAME}Model(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      value: counter.value,
      timestamp: DateTime.now(),
    );

    // Reaktif tetikleme için referans yenilenir
    items.value = [newItem, ...items.value];
  }

  /// Durumu başlangıç değerine sıfırlar
  void reset() {
    counter.value = 0;
    items.value = [];
  }

  /// Reaktif kaynakları temizler ve bellek sızıntısını önler
  void dispose() {
    counter.dispose();
    items.dispose();
    isLoading.dispose();
  }
}
EOF
)
write_file_safely "$CONTROLLER_FILE" "$CONTROLLER_CONTENT"

# 2. Model Dosyasını Oluştur
MODEL_CONTENT=$(cat << EOF
import 'package:flutter/foundation.dart';

/// ${TITLE_NAME} veri modeli
/// 
/// Sınıf '@immutable' olarak işaretlenmiş olup tüm alanları değişmezdir.
@immutable
class ${PASCAL_NAME}Model {
  final String id;
  final int value;
  final DateTime timestamp;

  const ${PASCAL_NAME}Model({
    required this.id,
    required this.value,
    required this.timestamp,
  });

  /// Değişmez nesnenin yeni kopyasını üretir
  ${PASCAL_NAME}Model copyWith({
    String? id,
    int? value,
    DateTime? timestamp,
  }) {
    return ${PASCAL_NAME}Model(
      id: id ?? this.id,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// JSON verisinden model üretir
  factory ${PASCAL_NAME}Model.fromJson(Map<String, dynamic> json) {
    return ${PASCAL_NAME}Model(
      id: json['id'] as String? ?? '',
      value: (json['value'] as num?)?.toInt() ?? 0,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  /// Modeli JSON haritasına dönüştürür
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ${PASCAL_NAME}Model &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          value == other.value &&
          timestamp == other.timestamp;

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ timestamp.hashCode;
}
EOF
)
write_file_safely "$MODEL_FILE" "$MODEL_CONTENT"

# 3. Card Widget Dosyasını Oluştur (<40 Satır Kuralı)
CARD_CONTENT=$(cat << EOF
import 'package:flutter/material.dart';
import '../controllers/${FEATURE_NAME}_controller.dart';

/// ${TITLE_NAME} özet ve aksiyon kartı
/// 
/// Build metodu 40 satır kuralına uygun olarak izole edilmiştir.
class ${PASCAL_NAME}Card extends StatelessWidget {
  final ${PASCAL_NAME}Controller controller;

  const ${PASCAL_NAME}Card({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: controller.counter,
              builder: (context, val, _) {
                return Text(
                  'Mevcut Değer: \$val',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.increment,
                    child: const Text('Artır'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: controller.reset,
                  child: const Text('Sıfırla'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
EOF
)
write_file_safely "$CARD_FILE" "$CARD_CONTENT"

# 4. View Dosyasını Oluştur (<40 Satır Build Kuralı)
VIEW_CONTENT=$(cat << EOF
import 'package:flutter/material.dart';
import '../controllers/${FEATURE_NAME}_controller.dart';
import '../widgets/${FEATURE_NAME}_card.dart';

/// ${TITLE_NAME} modülü ana görünüm ekranı
class ${PASCAL_NAME}View extends StatelessWidget {
  final ${PASCAL_NAME}Controller controller;

  const ${PASCAL_NAME}View({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${TITLE_NAME}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ${PASCAL_NAME}Card(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
EOF
)
write_file_safely "$VIEW_FILE" "$VIEW_CONTENT"

# 5. Unit Test Dosyasını Oluştur
TEST_CONTENT=$(cat << EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:susadim/features/${FEATURE_NAME}/controllers/${FEATURE_NAME}_controller.dart';

void main() {
  group('${PASCAL_NAME}Controller Birim Testleri', () {
    late ${PASCAL_NAME}Controller controller;

    setUp(() {
      controller = ${PASCAL_NAME}Controller();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Başlangıç değerleri sıfır olmalı', () {
      expect(controller.counter.value, 0);
      expect(controller.progressRatio, 0.0);
      expect(controller.items.value, isEmpty);
    });

    test('increment metodu durumu ve kayıt listesini güncellemeli', () {
      controller.increment(5);

      expect(controller.counter.value, 5);
      expect(controller.items.value.length, 1);
      expect(controller.items.value.first.value, 5);
    });

    test('reset metodu tüm durumu sıfırlamalı', () {
      controller.increment(10);
      controller.reset();

      expect(controller.counter.value, 0);
      expect(controller.items.value, isEmpty);
    });
  });
}
EOF
)
write_file_safely "$TEST_FILE" "$TEST_CONTENT"

echo ""
echo -e "${GREEN}✓ Feature başarıyla üretildi!${NC}"
echo -e "Doğrulamak için:"
echo -e "  ${YELLOW}flutter analyze${NC}"
echo -e "  ${YELLOW}flutter test $TEST_FILE${NC}"
