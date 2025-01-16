import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мое расписание'),
        backgroundColor: const Color(0xFFF1BFBE),
      ),
      body: const Center(
        child: Text('Страница расписания мастера'),
      ),
    );
  }
}