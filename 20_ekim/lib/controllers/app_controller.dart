import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../models/business_idea_model.dart';
import '../models/investment_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';

class AppController {
  static final AppController instance = AppController._internal();
  AppController._internal() {
    _initData();
  }

  // 100.000 TL = 10.000.000 Kuruş
  static const int initialBalanceKurus = 10000000;

  // Reaktif Durumlar (ValueNotifiers)
  final ValueNotifier<UserModel?> currentUser =
      ValueNotifier<UserModel?>(DemoData.initialUser);

  final ValueNotifier<int> balance =
      ValueNotifier<int>(initialBalanceKurus);

  final ValueNotifier<List<BusinessIdeaModel>> businessIdeas =
      ValueNotifier<List<BusinessIdeaModel>>([]);

  final ValueNotifier<List<InvestmentModel>> investments =
      ValueNotifier<List<InvestmentModel>>([]);

  final ValueNotifier<List<TransactionModel>> transactions =
      ValueNotifier<List<TransactionModel>>([]);

  final ValueNotifier<List<BusinessIdeaModel>> myIdeas =
      ValueNotifier<List<BusinessIdeaModel>>([]);

  void _initData() {
    currentUser.value = DemoData.initialUser;
    balance.value = initialBalanceKurus;
    businessIdeas.value = List<BusinessIdeaModel>.from(DemoData.initialBusinessIdeas);
    investments.value = [];
    transactions.value = List<TransactionModel>.from(DemoData.initialTransactions);
    myIdeas.value = [];
  }

  // --- KULLANICI İŞLEMLERİ ---
  bool login(String email, String password) {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }
    final String name = email.split('@').first;
    final String initials = name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : name.toUpperCase();

    currentUser.value = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name[0].toUpperCase() + name.substring(1),
      email: email.trim(),
      avatarInitials: initials,
    );
    return true;
  }

  bool register(String name, String email, String password) {
    if (name.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }
    final List<String> parts = name.trim().split(' ');
    final String initials = parts.length > 1
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();

    currentUser.value = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: email.trim(),
      avatarInitials: initials,
    );
    return true;
  }

  void logout() {
    currentUser.value = null;
  }

  // --- BAKİYE & PARA İŞLEMLERİ ---
  bool addMoney(int amountInKurus, {String source = 'Kredi Kartı Simülasyonu'}) {
    if (amountInKurus <= 0) return false;

    balance.value += amountInKurus;

    final tx = TransactionModel(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: TransactionType.deposit,
      title: 'Bakiye Yükleme',
      description: source,
      amount: amountInKurus,
      date: DateTime.now(),
      isPositive: true,
    );

    transactions.value = [tx, ...transactions.value];
    return true;
  }

  bool transferMoney(int amountInKurus, String recipient, String note) {
    if (amountInKurus <= 0) return false;
    if (balance.value < amountInKurus) return false;

    balance.value -= amountInKurus;

    final tx = TransactionModel(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: TransactionType.transfer,
      title: 'Para Transferi',
      description: 'Alıcı: $recipient ${note.isNotEmpty ? "($note)" : ""}',
      amount: amountInKurus,
      date: DateTime.now(),
      isPositive: false,
    );

    transactions.value = [tx, ...transactions.value];
    return true;
  }

  // --- YATIRIM İŞLEMİ ---
  bool makeInvestment(BusinessIdeaModel idea) {
    if (idea.investmentAmount <= 0) return false;
    if (balance.value < idea.investmentAmount) return false;

    // Bakiyeden düş
    balance.value -= idea.investmentAmount;

    // Yatırımı kaydet
    final investment = InvestmentModel(
      id: 'inv_${DateTime.now().millisecondsSinceEpoch}',
      businessIdeaId: idea.id,
      businessIdeaTitle: idea.title,
      category: idea.category,
      amount: idea.investmentAmount,
      date: DateTime.now(),
    );

    investments.value = [investment, ...investments.value];

    // İşlem geçmişine ekle
    final tx = TransactionModel(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: TransactionType.investment,
      title: 'Yatırım: ${idea.title}',
      description: 'Resmi Sözleşme Onaylandı (${idea.category})',
      amount: idea.investmentAmount,
      date: DateTime.now(),
      isPositive: false,
    );
    transactions.value = [tx, ...transactions.value];

    // İlgili fikri yatırım yapıldı olarak güncelle
    businessIdeas.value = businessIdeas.value.map((item) {
      if (item.id == idea.id) {
        return item.copyWith(
          isInvested: true,
          fundingPercentage: 1.0,
        );
      }
      return item;
    }).toList();

    return true;
  }

  // --- YENİ İŞ FİKRİ EKLEME ---
  void addMyIdea({
    required String title,
    required String category,
    required String shortDescription,
    required String fullDescription,
    required String businessModel,
    required String targetAudience,
    required int investmentAmountInKurus,
    required IconData icon,
  }) {
    final newIdea = BusinessIdeaModel(
      id: 'idea_custom_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      category: category,
      shortDescription: shortDescription,
      fullDescription: fullDescription,
      businessModel: businessModel,
      targetAudience: targetAudience,
      investmentAmount: investmentAmountInKurus,
      icon: icon,
      founderName: currentUser.value?.name ?? 'Benim Girişimim',
      fundingPercentage: 0.05,
      isUserCreated: true,
    );

    myIdeas.value = [newIdea, ...myIdeas.value];
    businessIdeas.value = [newIdea, ...businessIdeas.value];
  }

  // --- DEMO VERİLERİNİ SIFIRLAMA ---
  void resetDemoData() {
    _initData();
  }

  // --- YARDIMCI BİLGİ GETTER'LARI ---
  String get formattedBalance {
    final double tl = balance.value / 100.0;
    return '${_formatNumberWithDots(tl.round())} ₺';
  }

  int get totalInvestedKurus {
    int sum = 0;
    for (final inv in investments.value) {
      sum += inv.amount;
    }
    return sum;
  }

  String get formattedTotalInvested {
    final double tl = totalInvestedKurus / 100.0;
    return '${_formatNumberWithDots(tl.round())} ₺';
  }

  static String _formatNumberWithDots(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void dispose() {
    currentUser.dispose();
    balance.dispose();
    businessIdeas.dispose();
    investments.dispose();
    transactions.dispose();
    myIdeas.dispose();
  }
}
