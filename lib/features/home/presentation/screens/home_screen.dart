import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anime Time'), centerTitle: true),
      body: const Center(child: Text('Bienvenue sur Anime Time 🎌')),
    );
  }
}
