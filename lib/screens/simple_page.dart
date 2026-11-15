import 'package:flutter/material.dart';
import '../state/app_translations.dart';

class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        context.tr(title),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
