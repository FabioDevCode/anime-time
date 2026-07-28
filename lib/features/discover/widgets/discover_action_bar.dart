import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/features/discover/providers/discover_providers.dart';
import 'package:anime_time/features/discover/providers/discover_view_mode.dart';

/// Hauteur totale de la barre d'actions (boutons + padding vertical).
/// Utilisée par [DiscoverActionBar] et par le [padding] supérieur du GridView
/// pour que les premières affiches ne soient jamais masquées.
const double kDiscoverActionBarHeight = 64.0;

/// Barre d'actions fixe affichée en haut de la page Découvrir.
///
/// Composition :
/// ```
/// [ 🔍 Rechercher (expanded) ]  [ Filtre ]  [ Grid ]
/// ```
class DiscoverActionBar extends ConsumerWidget {
  const DiscoverActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewMode = ref.watch(discoverViewModeProvider);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          height: kDiscoverActionBarHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface.withValues(alpha: 1),
                colorScheme.surface.withValues(alpha: 0.0),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: SearchButton()),
                const SizedBox(width: 8),
                SquareIconButton(
                  icon: Icons.filter_list_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                SquareIconButton(
                  icon: viewMode == DiscoverViewMode.grid
                      ? Icons.format_list_bulleted_outlined
                      : Icons.grid_view_outlined,
                  onTap: () {
                    ref.read(discoverViewModeProvider.notifier).toggle();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bouton étendu imitant une barre de recherche.
/// N'est qu'un bouton — aucun champ de saisie.
class SearchButton extends StatelessWidget {
  const SearchButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Text(
                'Rechercher',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bouton carré à icône unique, cohérent avec le style de [SearchButton].
class SquareIconButton extends StatelessWidget {
  const SquareIconButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox.square(
          dimension: 48,
          child: Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
