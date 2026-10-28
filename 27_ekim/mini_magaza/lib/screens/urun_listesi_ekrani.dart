
import 'package:flutter/material.dart';
import '../models/kategori.dart';
import '../models/urun.dart';
import '../services/i_urun_servisi.dart';
import '../services/mock_urun_servisi.dart';
import '../widgets/urun_karti.dart';

class UrunListesiEkrani extends StatefulWidget {
  const UrunListesiEkrani({super.key});

  @override
  State<UrunListesiEkrani> createState() =>
      _UrunListesiEkraniState();
}

class _UrunListesiEkraniState extends State<UrunListesiEkrani> {
  final IUrunServisi _servis = MockUrunServisi();
  final TextEditingController _aramaController =
      TextEditingController();

  bool _yukleniyorMu = true;
  Kategori _seciliKategori = Kategori.hepsi;
  List<Urun> _filtrelenmisUrunler = [];
  List<Urun> _tumUrunler = [];

  @override
  void initState() {
    super.initState();
    _urunleriYukle();
  }

  @override
  void dispose() {
    _aramaController.dispose();
    super.dispose();
  }

  Future<void> _urunleriYukle() async {
    setState(() {
      _yukleniyorMu = true;
    });

    try {
      final urunler = await _servis.tumUrunleriGetir();

      if (!mounted) return;

      setState(() {
        _tumUrunler = urunler;
        _filtrelenmisUrunler = urunler;
        _yukleniyorMu = false;
      });

      _filtreyiUygula();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _yukleniyorMu = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ürünler yüklenemedi: $e')),
      );
    }
  }

  void _filtreyiUygula() {
    final aranan = _aramaController.text.trim().toLowerCase();

    setState(() {
      _filtrelenmisUrunler = _tumUrunler.where((urun) {
        final kategoriUygunMu =
            _seciliKategori == Kategori.hepsi ||
            urun.kategori == _seciliKategori;

        final aramaUygunMu = aranan.isEmpty ||
            urun.baslik.toLowerCase().contains(aranan) ||
            urun.aciklama.toLowerCase().contains(aranan);

        return kategoriUygunMu && aramaUygunMu;
      }).toList();
    });
  }

  void _favoriyiDegistir(Urun hedefUrun) {
    final index =
        _tumUrunler.indexWhere((u) => u.id == hedefUrun.id);

    if (index == -1) return;

    setState(() {
      _tumUrunler[index] = hedefUrun.copyWith(
        favoriMi: !hedefUrun.favoriMi,
      );
    });

    _filtreyiUygula();
  }

  void _urunDetayiniGoster(Urun urun) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(urun.baslik),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(urun.aciklama),
            const SizedBox(height: 12),
            Text('Fiyat: ${urun.fiyat.toStringAsFixed(2)} TL'),
            Text('Stok: ${urun.stokAdedi}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriSayisi =
        _tumUrunler.where((u) => u.favoriMi).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Mağaza',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite, color: Colors.red),
                const SizedBox(width: 4),
                Text(
                  '$favoriSayisi',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _aramaController,
              onChanged: (_) => _filtreyiUygula(),
              decoration: InputDecoration(
                hintText: 'Ürün veya marka ara...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _aramaController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _aramaController.clear();
                          _filtreyiUygula();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              children: Kategori.values.map((kategori) {
                final seciliMi = _seciliKategori == kategori;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: ChoiceChip(
                    avatar: Text(kategori.ikon),
                    label: Text(kategori.baslik),
                    selected: seciliMi,
                    onSelected: (secildi) {
                      if (secildi) {
                        setState(() {
                _seciliKategori = kategori;
              });
              _filtreyiUygula();
            }
          },
        ),
      );
    }).toList(),
  ),
),
          Expanded(
            child: _yukleniyorMu
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _filtrelenmisUrunler.isEmpty
                    ? const Center(
                        child: Text('Ürün bulunamadı.'),
                      )
                    : RefreshIndicator(
                        onRefresh: _urunleriYukle,
                        child: ListView.builder(ƒ
                          padding:
                              const EdgeInsets.only(bottom: 16),
                          itemCount: _filtrelenmisUrunler.length,
                          itemBuilder: (context, index) {
                            final urun =
                                _filtrelenmisUrunler[index];

                            return UrunKarti(
                              urun: urun,
                              onFavoriTiklandi: () =>
                                  _favoriyiDegistir(urun),
                              onDetayTiklandi: () =>
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${urun.baslik} tıklandı!'),
                                  duration: const Duration(
                                      milliseconds: 600),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
