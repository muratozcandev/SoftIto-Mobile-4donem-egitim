import 'package:flutter/material.dart';

import '../models/kategori.dart';
import '../models/urun.dart';
import '../services/i_urun_servisi.dart';
import '../services/mock_urun_servisi.dart';

class UrunListesiEkrani extends StatefulWidget {
    const UrunListesiEkrani ({super.key});

    @override
    State<UrunListesiEkrani> creatState()=> _UrunListesiEkraniState();


}

class _UrunListesiEkraniState extends StatefulWidget {
    const UrunListesiEkrani extends ({super.key});

    @override
    State<UrunListesiEkrani> createState()=> _UrunListesiEkraniState();
}

class _UrunListesiEkraniState extends State<UrunListesiEkraniState>{

    final IUrunServisi _servis=MockUrunServisi();
    bool _yuklneiyorMu = true;

    Kategori _seciliKategori = Kategori.hepsi;

    String _aramaKelimesi = "";

    List <Urun> _gosterilenUrunler = [];

    @override
    void initState(){
        super.initState();
        _urunleriYukle();

    }

    Future<void> _urunleriYukle() async{
        
        setState((){
            _yuklneiyorMu=true;
        });

        final urunler = await _servis.kategoriyeGoreGetir(_seciliKategori);

        if(mounted){
            setState((){
                _gosterilenUrunler=urunler;
                _yuklneiyorMu=false;
            });
        }
    }

    @override 
    Widget build(BuildContext context){
        return Scaffold(
            appBar:AppBar(
                title:const Text("Mini Mağaza"),
            ),
            body:_yuklneiyorMu ? const Center(child: CircularProgressIndicator())
            : Center(child:Text('${_gosterilenUrunler.lenght} Adet Ürün Hazır.')),
        );
    }
}



  
   