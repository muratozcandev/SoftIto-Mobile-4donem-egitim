import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'home_view.dart';
import '../../rental/views/my_rentals_view.dart';
import '../../damage_report/views/damage_report_view.dart';
import '../../profile/views/profile_view.dart';

/// [MainNavigationShell] widget'ı, AraÇek uygulamasının ana gezinme omurgasıdır.
/// Alt taraftaki (BottomNavigationBar) sekmeleri ve ekran geçişlerini yönetir:
/// - 0: Keşfet (HomeView)
/// - 1: Kiralamalarım (MyRentalsView)
/// - 2: AraÇek Kamera (DamageReportView)
/// - 3: Profil (ProfileView)
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  // Aktif sekme indeksi (Varsayılan: 0 - Ana Sayfa)
  int _currentIndex = 0;

  // Sekmeler listesi
  final List<Widget> _pages = const [
    HomeView(),
    MyRentalsView(),
    DamageReportView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded, color: AppColors.primary),
            label: 'Keşfet',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car_rounded, color: AppColors.primary),
            label: 'Kiralamalarım',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt_rounded, color: AppColors.accent),
            label: 'AraÇek (Foto)',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
