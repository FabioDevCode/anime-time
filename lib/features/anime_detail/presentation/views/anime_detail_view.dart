import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/anime_detail/data/mappers/anime_detail_to_favorite_anime_draft.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';
import 'package:anime_time/features/anime_detail/providers/anime_detail_providers.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_airing_card.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_banner.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_metadata.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_synopsis_card.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_title.dart';
import 'package:anime_time/features/favorites/presentation/widgets/favorite_anime_button.dart';
import 'package:anime_time/features/favorites/providers/favorite_anime_providers.dart';

class AnimeDetailView extends ConsumerWidget {
  const AnimeDetailView({super.key, required this.animeId});

  final int animeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeDetail = ref.watch(animeDetailProvider(animeId));
    // Ces deux providers sont observés dès le premier build : les requêtes
    // GraphQL et Drift démarrent donc en parallèle.
    final favoriteAnime = ref.watch(favoriteAnimeControllerProvider(animeId));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: animeDetail.when(
              data: (anime) => favoriteAnime.when(
                data: (favoriteState) => _AnimeDetailContent(
                  anime: anime,
                  favoriteState: favoriteState,
                  onAdd: () => _addToFavorites(ref, anime),
                  onRemove: () => _removeFromFavorites(ref, anime),
                ),
                loading: () => _AnimeDetailContent(
                  anime: anime,
                  isFavoriteLoading: true,
                  onAdd: () => _addToFavorites(ref, anime),
                  onRemove: () => _removeFromFavorites(ref, anime),
                ),
                error: (error, _) => _AnimeDetailContent(
                  anime: anime,
                  onAdd: () => _addToFavorites(ref, anime),
                  onRemove: () => _removeFromFavorites(ref, anime),
                  onRetryFavorite: () =>
                      ref.invalidate(favoriteAnimeControllerProvider(animeId)),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _DetailError(onRetry: () => _retry(ref)),
            ),
          ),
          const _DetailBackButton(),
        ],
      ),
    );
  }

  void _retry(WidgetRef ref) {
    ref
      ..invalidate(animeDetailProvider(animeId))
      ..invalidate(favoriteAnimeControllerProvider(animeId));
  }

  Future<void> _addToFavorites(WidgetRef ref, AnimeDetail anime) async {
    await ref
        .read(favoriteAnimeControllerProvider(anime.id).notifier)
        .add(anime.toFavoriteAnimeDraft());
  }

  Future<void> _removeFromFavorites(WidgetRef ref, AnimeDetail anime) async {
    await ref.read(favoriteAnimeControllerProvider(anime.id).notifier).remove();
  }
}

class _AnimeDetailContent extends StatelessWidget {
  const _AnimeDetailContent({
    required this.anime,
    required this.onAdd,
    required this.onRemove,
    this.favoriteState,
    this.isFavoriteLoading = false,
    this.onRetryFavorite,
  });

  final AnimeDetail anime;
  final FavoriteAnimeState? favoriteState;
  final bool isFavoriteLoading;
  final Future<void> Function() onAdd;
  final Future<void> Function() onRemove;
  final VoidCallback? onRetryFavorite;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 32;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: AnimeDetailBanner(anime: anime)),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimeDetailTitle(anime: anime),
                    const SizedBox(height: 14),
                    AnimeDetailMetadata(anime: anime),
                    if (anime.genres.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: -12,
                        children: anime.genres.map((genre) {
                          return Chip(
                            label: Text(
                              genre,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: -4,
                            ),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                              side: BorderSide.none,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    if (anime.status == 'RELEASING' &&
                        anime.nextAiringEpisode != null) ...[
                      const SizedBox(height: 8),
                      AnimeDetailAiringCard(
                        nextEpisode: anime.nextAiringEpisode!,
                      ),
                      const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 8),
                    _buildFavoriteAction(),
                    const SizedBox(height: 16),
                    AnimeDetailSynopsisCard(description: anime.description),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteAction() {
    final state = favoriteState;
    if (state != null) {
      return FavoriteAnimeButton(
        isFavorite: state.isFavorite,
        isProcessing: state.isProcessing,
        onAdd: onAdd,
        onRemove: onRemove,
      );
    }

    if (isFavoriteLoading) {
      return const SizedBox(
        height: 52,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onRetryFavorite,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Réessayer les favoris'),
      ),
    );
  }
}

class _DetailBackButton extends StatelessWidget {
  const _DetailBackButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: MediaQuery.paddingOf(context).top + 12,
      left: 16,
      child: IconButton(
        onPressed: context.pop,
        icon: const Icon(Icons.arrow_back, size: 20),
        tooltip: 'Retour',
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainerHigh.withValues(
            alpha: 0.82,
          ),
          foregroundColor: colorScheme.onSurface,
          shape: const CircleBorder(),
          fixedSize: const Size(40, 40), // taille fixe du bouton
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _DetailError extends StatelessWidget {
  const _DetailError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Impossible de charger les détails de cet anime.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
          ],
        ),
      ),
    );
  }
}
