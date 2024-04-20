import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HistoryUI extends StatelessWidget {
  const HistoryUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text(
        'History UI',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
