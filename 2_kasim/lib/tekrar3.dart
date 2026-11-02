import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// SEPET KONTROL SINIFI
class SepetKontrolu {
  static final SepetKontrolu ornek = SepetKontrolu._dahili();

  SepetKontrolu._dahili();

  final ValueNotifier<int> urunSayisi = ValueNotifier<int>(0);

  void sepeteEkle() {
    urunSayisi.value++;
  }

  void sepetiSifirla() {
    urunSayisi.value = 0;
  }
}

// UYGULAMA ROTALARI
final GoRouter uygulamaRotalari = GoRouter(
  initialLocation: '/vitrin',
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AnaKasaEkrani(ekranGovdesi: child);
      },
      routes: [
        GoRoute(
          path: '/vitrin',
          builder: (context, state) => const VitrinEkrani(),
        ),
        GoRoute(
          path: '/profil',
          builder: (context, state) => const ProfilEkrani(),
        ),
      ],
    ),
  ],
);

// ANA KASA EKRANI
class AnaKasaEkrani extends StatelessWidget {
  final Widget ekranGovdesi;

  const AnaKasaEkrani({super.key, required this.ekranGovdesi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ekranGovdesi,

      bottomNavigationBar: NavigationBar(
        selectedIndex: _aktifIndexiBul(context),

        onDestinationSelected: (yeniIndex) {
          if (yeniIndex == 0) {
            context.go('/vitrin');
          } else if (yeniIndex == 1) {
            context.go('/profil');
          }
        },

        destinations: [
          const NavigationDestination(icon: Icon(Icons.store), label: 'Vitrin'),

          NavigationDestination(
            icon: ValueListenableBuilder<int>(
              valueListenable: SepetKontrolu.ornek.urunSayisi,
              builder: (context, sayi, child) {
                return Badge(
                  label: Text('$sayi'),
                  isLabelVisible: sayi > 0,
                  child: const Icon(Icons.person),
                );
              },
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  int _aktifIndexiBul(BuildContext context) {
    final String konum = GoRouterState.of(context).uri.path;

    if (konum == '/profil') {
      return 1;
    }

    return 0;
  }
}

// VİTRİN EKRANI
class VitrinEkrani extends StatelessWidget {
  const VitrinEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canlı Vitrin (ValueNotifier)')),

      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            SepetKontrolu.ornek.sepeteEkle();
          },
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Sepete Bir Ürün Ekle (+1)'),
        ),
      ),
    );
  }
}

// PROFİL EKRANI
class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kullanıcı Profili')),

      body: Center(
        child: TextButton(
          onPressed: () {
            SepetKontrolu.ornek.sepetiSifirla();
          },
          child: const Text('Sepeti Temizle (0 Yap)'),
        ),
      ),
    );
  }
}
