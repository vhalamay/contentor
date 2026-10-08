import 'package:flutter/material.dart';

void main() {
  runApp(const ContentorApp());
}

class ContentorApp extends StatelessWidget {
  const ContentorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Contentor',
      home: Scaffold(),
    );
  }
}
