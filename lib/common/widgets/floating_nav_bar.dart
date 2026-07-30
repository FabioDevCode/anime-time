import 'package:flutter/material.dart';
import 'package:anime_time/core/router/app_tab.dart';
import 'package:anime_time/core/theme/app_colors_extension.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.currentTab,
    required this.onTap,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onTap;

  static const _items = [
    _NavItem(
      tab: AppTab.discover,
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore_outlined,
      label: 'Découvrir',
    ),
    _NavItem(
      tab: AppTab.soon,
      icon: Icons.hourglass_top_rounded,
      activeIcon: Icons.hourglass_top_rounded,
      label: 'Bientôt',
    ),
    _NavItem(
      tab: AppTab.calendar,
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month_outlined,
      label: 'Calendrier',
    ),
    _NavItem(
      tab: AppTab.profile,
      icon: Icons.person_outline,
      activeIcon: Icons.person_outline,
      label: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _items.map((item) {
                return Expanded(
                  child: _NavBarItem(
                    item: item,
                    isActive: item.tab == currentTab,
                    colorScheme: colorScheme,
                    onTap: () => onTap(item.tab),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.colorScheme,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    // Couleur du texte/icône : blanc si actif (sur fond bleu), sinon comportement inchangé
    final contentColor = isActive
        ? appColors.onBrandBackground
        : colorScheme.onSurface.withValues(alpha: 0.5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? appColors.brandBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isActive ? item.activeIcon : item.icon,
                  key: ValueKey(isActive),
                  color: contentColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: contentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.tab,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final AppTab tab;
  final IconData icon;
  final IconData activeIcon;
  final String label;
}
