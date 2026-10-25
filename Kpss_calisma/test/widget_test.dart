import 'package:flutter_test/flutter_test.dart'; // Flutter birim (Unit) ve widget test araçları kütüphanesi
import 'package:kpss/core/utils/kpss_calculator.dart'; // KPSS net ve doğruluk hesaplama fonksiyonları
import 'package:kpss/models/mock_exam.dart'; // Deneme sınavı veri modeli
import 'package:kpss/models/question_log.dart'; // Soru kaydı veri modeli

/// Uygulamanın temel hesaplama algoritmalarını ve veri modellerini doğrulayan otomatik testler
void main() {
  group('KPSS Calculator & Model Tests', () {
    // 1. Test: Net hesaplama algoritmasının doğruluğunu test eder
    test('calculateNet calculates standard 4 wrong 1 correct rule correctly', () {
      // 20 Doğru, 4 Yanlış -> 20 - (4/4) = 19.0 Net olmalı
      expect(KpssCalculator.calculateNet(20, 4), 19.0);
      // 30 Doğru, 2 Yanlış -> 30 - (2/4) = 29.5 Net olmalı
      expect(KpssCalculator.calculateNet(30, 2), 29.5);
      // 0 Doğru, 4 Yanlış -> 0 - (4/4) = -1.0 Net olmalı
      expect(KpssCalculator.calculateNet(0, 4), -1.0);
      // 0 Doğru, 0 Yanlış -> 0.0 Net olmalı
      expect(KpssCalculator.calculateNet(0, 0), 0.0);
      // 40 Doğru, 1 Yanlış -> 40 - (1/4) = 39.75 Net olmalı
      expect(KpssCalculator.calculateNet(40, 1), 39.75);
    });

    // 2. Test: Doğruluk yüzdesi hesaplamasını ve sıfıra bölünme güvenliğini test eder
    test('calculateAccuracy calculates percentage safely without division by zero', () {
      // Toplam 0 soru olduğunda hata fırlatmamalı ve %0 döndürmeli
      expect(KpssCalculator.calculateAccuracy(0, 0), 0.0);
      // 100 soruda 50 doğru -> %50.0 başarı oranı olmalı
      expect(KpssCalculator.calculateAccuracy(50, 100), 50.0);
      // 40 soruda 30 doğru -> %75.0 başarı oranı olmalı
      expect(KpssCalculator.calculateAccuracy(30, 40), 75.0);
    });

    // 3. Test: QuestionLog modelinin Map'e çevrilme (toMap) ve Map'ten üretilme (fromMap) işlemlerini test eder
    test('QuestionLog serialization toMap and fromMap works seamlessly', () {
      final now = DateTime(2026, 10, 24);
      final log = QuestionLog(
        id: 'test_1',
        courseId: 'turkce',
        correct: 25,
        wrong: 4,
        empty: 1,
        date: now,
        note: 'Paragraf çözümü',
      );

      // Toplam soru 25 + 4 + 1 = 30 olmalı
      expect(log.totalQuestions, 30);
      // Net 25 - (4/4) = 24.0 olmalı
      expect(log.netScore, 24.0);

      // Modeli Haritaya (Map/JSON) çevirip tekrar model oluştur
      final map = log.toMap();
      final fromMap = QuestionLog.fromMap(map);

      // Verilerin kayıpsız aktarıldığını doğrula
      expect(fromMap.id, 'test_1');
      expect(fromMap.courseId, 'turkce');
      expect(fromMap.correct, 25);
      expect(fromMap.wrong, 4);
      expect(fromMap.empty, 1);
      expect(fromMap.netScore, 24.0);
    });

    // 4. Test: MockExam modelinin GY, GK ve Toplam Net hesaplamalarını test eder
    test('MockExam calculates GY, GK and Total Net accurately', () {
      final now = DateTime(2026, 10, 24);
      final exam = MockExam(
        id: 'exam_1',
        title: 'Pegem TG-1',
        date: now,
        gyCorrect: 45,
        gyWrong: 8,
        gkCorrect: 50,
        gkWrong: 4,
      );

      // GY Net: 45 - (8/4) = 43.0 olmalı
      expect(exam.gyNet, 43.0);
      // GK Net: 50 - (4/4) = 49.0 olmalı
      expect(exam.gkNet, 49.0);
      // Toplam Net: 43.0 + 49.0 = 92.0 olmalı
      expect(exam.totalNet, 92.0);

      // Serileştirme ve geri dönüştürmeyi doğrula
      final map = exam.toMap();
      final fromMap = MockExam.fromMap(map);
      expect(fromMap.totalNet, 92.0);
      expect(fromMap.title, 'Pegem TG-1');
    });
  });
}
