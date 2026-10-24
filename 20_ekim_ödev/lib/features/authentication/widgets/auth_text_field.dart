<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: auth_text_field.dart
// Görev: Giriş ve kayıt ekranlarında kullanılan tekrar kullanılabilir modern girdi alanı.
// Açıklama: İkon desteği, şifre gizleme/gösterme butonu ve özel doğrulama kuralları sunar.
// ==============================================================================

import 'package:flutter/material.dart';

/// [AuthTextField] widget'ı, kimlik doğrulama formları için standartlaştırılmış
/// şık ve Material 3 uyumlu bir [TextFormField] sarmalayıcısıdır.
class AuthTextField extends StatefulWidget {
  /// Giriş alanını kontrol eden TextEditingController
  final TextEditingController controller;

  /// Alanın başlık etiketi (Label)
  final String label;

  /// Alanın ipucu metni (Hint)
  final String hint;

  /// Alanın sol tarafında gösterilecek simge
  final IconData prefixIcon;

  /// Alanın şifre alanı olup olmadığını belirler
  final bool isPassword;

  /// Klavye tipi (e-posta, telefon, sayı vb.)
  final TextInputType keyboardType;

  /// Doğrulama fonksiyonu
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  /// Şifrenin gizli mi yoksa açık mı gösterileceğini takip eden yerel durum.
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: Icon(widget.prefixIcon, size: 22),
          // Şifre alanıysa gizleme/gösterme göz simgesi eklenir
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
        ),
      ),
    );
  }
}
