import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/views/home_view.dart';
import '../../leagues/views/leagues_view.dart';
import '../../coupon_cart/views/coupon_cart_view.dart';
import '../../coupon_cart/controllers/coupon_cart_controller.dart';
import '../../coupon_history/views/coupon_history_view.dart';
import '../../chat/views/chat_view.dart';

/// Ana Uygulama İskeleti (5 Sekmeli Alt Navigasyon)
class MainScaffoldView extends StatefulWidget {
  const MainScaffoldView({super.key});

  @override
  State<MainScaffoldView> createState() => MainScaffoldViewState();
}

class MainScaffoldViewState extends State<MainScaffoldView> {
  int _currentIndex = 0;

  final List<Widget> _views = const [
    HomeView(),
    LeaguesView(),
    CouponCartView(),
    CouponHistoryView(),
    ChatView(),
  ];

  void setIndex(int index) {
    if (index >= 0 && index < _views.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CouponCartController.instance;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          return NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: setIndex,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.newspaper_outlined),
                selectedIcon: Icon(Icons.newspaper),
                label: 'Bülten',
              ),
              const NavigationDestination(
                icon: Icon(Icons.sports_soccer_outlined),
                selectedIcon: Icon(Icons.sports_soccer),
                label: 'Kupon Oyna',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: cart.itemCount > 0,
                  label: Text('${cart.itemCount}'),
                  backgroundColor: AppColors.darkPrimaryAccent,
                  textColor: Colors.black,
                  child: const Icon(Icons.shopping_basket_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: cart.itemCount > 0,
                  label: Text('${cart.itemCount}'),
                  backgroundColor: AppColors.darkPrimaryAccent,
                  textColor: Colors.black,
                  child: const Icon(Icons.shopping_basket),
                ),
                label: 'Sepet',
              ),
              const NavigationDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: 'Geçmiş',
              ),
              const NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: 'Sohbet',
              ),
            ],
          );
        },
      ),
    );
  }
}
