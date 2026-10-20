import 'package:flutter/material.dart';

/// [AuthTextField] widget'ı, giriş ve kayıt formlarında kullanılan
/// estetik, Material 3 standartlarında ve hata doğrulamalı ortak metin giriş alanıdır.
class AuthTextField extends StatelessWidget {
  /// Giriş alanı etiketi (Örn: "E-posta veya Telefon")
  final String labelText;

  /// Giriş alanı ipucu metni
  final String? hintText;

  /// Sol baştaki ikon
  final IconData prefixIcon;

  /// Şifre gizleme durumu (true ise karakterler yıldız veya nokta olur)
  final bool obscureText;

  /// Sağ taraftaki aksiyon butonu veya ikonu (Örn: Şifreyi göster/gizle ikonu)
  final Widget? suffixIcon;

  /// Metin kontrolcüsü
  final TextEditingController? controller;

  /// Form doğrulama fonksiyonu
  final String? Function(String?)? validator;

  /// Klavye türü (E-posta, telefon, sayı vb.)
  final TextInputType keyboardType;

  /// Kurucu metod
  const AuthTextField({
    super.key,
    required this.labelText,
    this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, size: 22),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
