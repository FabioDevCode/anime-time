import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/widgets/floating_nav_bar.dart';
import 'package:anime_time/core/router/app_tab.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: FloatingNavBar(
          currentTab: AppTab.values[navigationShell.currentIndex],
          onTap: (tab) => navigationShell.goBranch(
            tab.index,
            initialLocation: tab.index == navigationShell.currentIndex,
          ),
        ),
      ),
    );
  }
}
