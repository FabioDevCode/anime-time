import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/core/theme/app_colors_extension.dart';
import 'package:anime_time/features/discover/providers/discover_filter.dart';

class DiscoverFiltersScreen extends ConsumerStatefulWidget {
  const DiscoverFiltersScreen({super.key});

  @override
  ConsumerState<DiscoverFiltersScreen> createState() =>
      _DiscoverFiltersScreenState();
}

class _DiscoverFiltersScreenState extends ConsumerState<DiscoverFiltersScreen> {
  late DiscoverFilterCriteria _draft;

  @override
  void initState() {
    super.initState();
    _draft = ref.read(discoverAppliedFilterProvider);
  }

  void _toggleSoon() {
    setState(() {
      _draft = _draft.copyWith(
        filter: _draft.filter == DiscoverFilter.soon
            ? DiscoverFilter.none
            : DiscoverFilter.soon,
      );
    });
  }

  void _reset() {
    setState(() {
      _draft = const DiscoverFilterCriteria();
    });
  }

  void _apply() {
    ref.read(discoverAppliedFilterProvider.notifier).apply(_draft);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Filtres')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'Rechercher',
                  filled: true,
                  fillColor: colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Catégories', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _FilterOptionChip(
                    label: 'Prochainement',
                    icon: Icons.hourglass_top_rounded,
                    isSelected: _draft.filter == DiscoverFilter.soon,
                    onTap: _toggleSoon,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _apply,
                  style: FilledButton.styleFrom(
                    backgroundColor: context.appColors.brandBackground,
                    foregroundColor: context.appColors.onBrandBackground,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Appliquer'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _reset,
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Réinitialiser'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterOptionChip extends StatelessWidget {
  const _FilterOptionChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final defaultLabelColor = Theme.of(context).colorScheme.onSurfaceVariant;
    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      selectedColor: appColors.brandBackground,
      avatar: Icon(
        icon,
        size: 16,
        color: isSelected ? appColors.onBrandBackground : defaultLabelColor,
      ),
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? appColors.onBrandBackground : defaultLabelColor,
      ),
      onSelected: (_) => onTap(),
    );
  }
}
