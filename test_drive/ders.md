1. Widget Tree
*İskelet
*İmmutable(değişmez)
*Çok ucuz (hafif)
*saniyee 60-120 kez çöpe atılıp yeniden üretilebilir
*Ekranda çizim yapmaz
*Sadece şablon sunar


2. Element Tree
*Yönetici & Yaşayan Omurga 
*Mutable (durumu ve referanslı hafızada canlı tutar değişir)
*widget ile renderobject arasındaki koordinatördür(orginazasyonu) sunar 

//canUpdate

static bool canUpdate(Widget oldWidget,Widget newWidget){
    return oldWidget.runtimeType=newWidget.runtimeType && oldWidget.key==newWidget.key;
}


State Yaşam döngüsü

*StatefulWidget immutable (olarak değişmez) her rebuild'de yeniden oluşturulur

*State mutable (durum saklar) rebuild sırasında çöpe atılmaz element olarak devam eder

Eğer iki sınıf birleşik olsaydı her rebuild esnasında kullanıcı girdiler yayaçlar controllerlar vb sıfırlanırdı.
