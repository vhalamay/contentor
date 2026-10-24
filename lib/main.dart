import 'package:flutter/material.dart';

import 'image_preview_screen.dart';
import 'font_licenses.dart';

void main() {
  registerFontLicenses();
  runApp(const ContentorApp());
}

class ContentorApp extends StatelessWidget {
  const ContentorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contentor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6254C7),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF202126),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF202126),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const ImagePreviewScreen(),
    );
  }
}
