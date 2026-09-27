import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/core/router/app_tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) context.go(AppTab.discover.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(
          'assets/icon/logo.png',
          width: MediaQuery.sizeOf(context).width * 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
