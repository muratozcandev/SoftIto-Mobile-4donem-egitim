class InvestmentModel {
  final String id;
  final String businessIdeaId;
  final String businessIdeaTitle;
  final String category;
  final int amount; // Kuruş
  final DateTime date;
  final String status;

  const InvestmentModel({
    required this.id,
    required this.businessIdeaId,
    required this.businessIdeaTitle,
    required this.category,
    required this.amount,
    required this.date,
    this.status = 'Aktif Yatırım',
  });

  String get formattedAmount {
    final double tl = amount / 100.0;
    final int rounded = tl.round();
    return '${_formatNumberWithDots(rounded)} ₺';
  }

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String _formatNumberWithDots(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
