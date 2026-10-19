import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/diary/screens/diary_screen.dart';

void main() {
  runApp(const SirdasimApp());
}

/// [SirdasimApp], uygulamanın kök widget'ıdır.
/// Sadece tema ve başlangıç ekranını yapılandırır.
class SirdasimApp extends StatelessWidget {
  const SirdasimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sırdaşım',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DiaryScreen(),
    );
  }
}
