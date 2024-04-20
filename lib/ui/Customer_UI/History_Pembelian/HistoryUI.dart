import 'package:flutter/material.dart';

class HistoryUI extends StatelessWidget {
  const HistoryUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'History UI',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
