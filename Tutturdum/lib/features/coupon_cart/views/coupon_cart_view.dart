import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/repositories/wallet_repository.dart';
import '../controllers/coupon_cart_controller.dart';
import '../../navigation/views/main_scaffold_view.dart';

/// Kupon Sepeti ve Bahis Onay Ekranı
class CouponCartView extends StatefulWidget {
  const CouponCartView({super.key});

  @override
  State<CouponCartView> createState() => _CouponCartViewState();
}

class _CouponCartViewState extends State<CouponCartView> {
  final TextEditingController _stakeController = TextEditingController();
  bool _isPlaying = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _stakeController.text = CouponCartController.instance.stake.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _stakeController.dispose();
    super.dispose();
  }

  Future<void> _handlePlayCoupon() async {
    final cart = CouponCartController.instance;

    setState(() {
      _isPlaying = true;
      _errorMessage = null;
    });

    try {
      final coupon = await cart.playCoupon();

      if (!mounted) return;

      // Başarılı kupon dialogu
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 28),
              SizedBox(width: 10),
              Text('Kupon Oynandı!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kupon No: ${coupon.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Toplam Oran: ${CurrencyFormatter.formatOdds(coupon.totalOdds)}'),
              Text('Yatırılan Tutar: ${CurrencyFormatter.format(coupon.stake)}'),
              Text('Olası Dönüş: ${CurrencyFormatter.format(coupon.possibleWin)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.success)),
              const SizedBox(height: 12),
              const Text(
                'Simülasyon kuponunuz oluşturuldu ve Kupon Geçmişi sekmesine kaydedildi.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cart = CouponCartController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kupon Sepeti'),
        actions: [
          AnimatedBuilder(
            animation: cart,
            builder: (context, _) {
              if (cart.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_sweep_outlined),
                tooltip: 'Sepeti Temizle',
                onPressed: () {
                  cart.clearCart();
                },
              );
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          if (cart.isEmpty) {
            return EmptyState(
              icon: Icons.shopping_basket_outlined,
              title: 'Kupon Sepetiniz Boş',
              message: 'Bültenden oran seçerek kupon oluşturmaya başlayın. Minimum bahis tutarı 50 ₺ dir.',
              buttonLabel: 'Bültene Git',
              onButtonPressed: () {
                // Kupon oyna sekmesine geçiş
                final navState = context.findAncestorStateOfType<MainScaffoldViewState>();
                if (navState != null) {
                  navState.setIndex(1);
                }
              },
            );
          }

          return Column(
            children: [
              // Seçilen Maçlar Listesi
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: cart.selections.length,
                  itemBuilder: (context, index) {
                    final item = cart.selections[index];
                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Sol Bilgi
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.homeTeam} - ${item.awayTeam}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.marketName}: ${item.selectionName}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Oran ve Kaldır Butonu
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                CurrencyFormatter.formatOdds(item.odds),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              color: Colors.redAccent,
                              onPressed: () => cart.removeSelection(item.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Alt Hesaplama & Onay Paneli
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardSurface : Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                      ],

                      // Hızlı Bahis Tutarı Seçimi
                      Row(
                        children: [
                          const Text('Tutar: ', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          ...[50, 100, 250, 500].map((amt) {
                            final isSelected = cart.stake == amt.toDouble();
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ChoiceChip(
                                label: Text('$amt ₺'),
                                selected: isSelected,
                                selectedColor: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                                onSelected: (sel) {
                                  if (sel) {
                                    cart.setStake(amt.toDouble());
                                    _stakeController.text = '$amt';
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Özel Tutar Girişi ve Toplam Oran
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: TextField(
                                controller: _stakeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Bahis Tutarı (₺)',
                                  prefixIcon: Icon(Icons.currency_lira, size: 18),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                onChanged: (val) {
                                  final parsed = double.tryParse(val.replaceAll(',', '.'));
                                  if (parsed != null && parsed > 0) {
                                    cart.setStake(parsed);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Toplam Oran', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              Text(
                                CurrencyFormatter.formatOdds(cart.totalOdds),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Olası Kazanç & Bakiye Durumu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder<double>(
                            valueListenable: WalletRepository.instance.balanceNotifier,
                            builder: (context, balance, _) {
                              return Text(
                                'Bakiye: ${CurrencyFormatter.format(balance)}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              );
                            },
                          ),
                          Row(
                            children: [
                              const Text('Olası Dönüş: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                              Text(
                                CurrencyFormatter.format(cart.possibleWin),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Kuponu Oyna Butonu
                      AppButton(
                        label: 'Kuponu Oyna (${CurrencyFormatter.format(cart.stake)})',
                        icon: Icons.check_circle_outline,
                        isLoading: _isPlaying,
                        onPressed: _handlePlayCoupon,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
