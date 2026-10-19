// mixin UcmaYetkisi{
//   int ucusIrtifasiMetre = 100;

//   void gogeYuksel(){
//     print("Uçuş yetisi: kanatlarını açtı ve $ucusIrtifasiMetre m yükseldi");
//   }
// }

// mixin GorunmezlikYetkisi{
//   void pelerinOrt(){
//     print("Görünmezlik: Düşmanların gözünden tamamen kayboldu!");
//   }
// }

// mixin AtesGucuYetkisi {
//   void alevSaldirisi(){
//     print("Ateş gücü: kılıcını alevlendirdi ve alanı yaktı");
//   }
// }

// class TemelKarakter{
//   final String ad;
//   TemelKarakter({required this.ad});
// }

// class EfsaneviEjderBinici extends TemelKarakter with UcmaYetkisi, AtesGucuYetkisi{
//   final String ejderhaAdi;
  
//   EfsaneviEjderBinici({
//     required this.ejderhaAdi,
//     required super.ad,
//   });

//   void hucumEt(){
//     print("$ad ve ejderhası $ejderhaAdi savaşa atılıyor");
//     gogeYuksel();
//     alevSaldirisi();
//   }
// }

// class GolgeSuikastcisi extends TemelKarakter with GorunmezlikYetkisi{
//   GolgeSuikastcisi({required super.ad});

//   void suikastYap(){
//     print("$ad hedefe sessice yaklaşıyor");
//     pelerinOrt();
//     print("Kritik darbe vurdu");

//   }
// }

// void main() {
//   print("Süper güçler başlatılıyor");
//   final birinci = EfsaneviEjderBinici(ejderhaAdi: "Kadim", ad: "Draven");
//   birinci.hucumEt();

//   final ikinci = GolgeSuikastcisi(ad: "Rengar");
//   ikinci.suikastYap();

// }

