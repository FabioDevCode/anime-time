import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/anime_detail_profile/data/mappers/anime_detail_profile_to_favorite_anime_draft.dart';
import 'package:anime_time/features/anime_detail_profile/data/models/anime_detail_profile.dart';
import 'package:anime_time/features/anime_detail_profile/providers/anime_detail_profile_providers.dart';
import 'package:anime_time/features/anime_detail_profile/widgets/anime_detail_profile_banner.dart';
import 'package:anime_time/features/anime_detail_profile/widgets/anime_detail_profile_metadata.dart';
import 'package:anime_time/features/anime_detail_profile/widgets/anime_detail_profile_synopsis_card.dart';
import 'package:anime_time/features/anime_detail_profile/widgets/anime_detail_profile_title.dart';
import 'package:anime_time/features/favorites/presentation/widgets/favorite_anime_button.dart';
import 'package:anime_time/features/favorites/providers/favorite_anime_providers.dart';

class AnimeDetailProfileView extends ConsumerWidget {
  const AnimeDetailProfileView({super.key, required this.animeId});

  final int animeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeDetail = ref.watch(animeDetailProfileProvider(animeId));
    final favoriteAnime = ref.watch(favoriteAnimeControllerProvider(animeId));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: animeDetail.when(
              data: (anime) => favoriteAnime.when(
                data: (favoriteState) => _AnimeDetailProfileContent(
                  anime: anime,
                  favoriteState: favoriteState,
                  onAdd: () => _addToFavorites(ref, anime),
                  onRemove: () => _removeFromFavorites(ref, anime),
                ),
                loading: () => _AnimeDetailProfileContent(
                  anime: anime,
                  isFavoriteLoading: true,
                  onAdd: () => _addToFavorites(ref, anime),
                  onRemove: () => _removeFromFavorites(ref, anime),
                ),
                error: (error, _) => _AnimeDetailProfileContent(
                  anime: anime,
                  onAdd: () => _addToFavorites(ref, anime),
                  onRemove: () => _removeFromFavorites(ref, anime),
                  onRetryFavorite: () =>
                      ref.invalidate(favoriteAnimeControllerProvider(animeId)),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  _DetailProfileError(onRetry: () => _retry(ref)),
            ),
          ),
          const _DetailProfileBackButton(),
        ],
      ),
    );
  }

  void _retry(WidgetRef ref) {
    ref
      ..invalidate(animeDetailProfileProvider(animeId))
      ..invalidate(favoriteAnimeControllerProvider(animeId));
  }

  Future<void> _addToFavorites(WidgetRef ref, AnimeDetailProfile anime) async {
    await ref
        .read(favoriteAnimeControllerProvider(anime.id).notifier)
        .add(anime.toFavoriteAnimeDraft());
  }

  Future<void> _removeFromFavorites(
    WidgetRef ref,
    AnimeDetailProfile anime,
  ) async {
    await ref.read(favoriteAnimeControllerProvider(anime.id).notifier).remove();
  }
}

class _AnimeDetailProfileContent extends StatelessWidget {
  const _AnimeDetailProfileContent({
    required this.anime,
    required this.onAdd,
    required this.onRemove,
    this.favoriteState,
    this.isFavoriteLoading = false,
    this.onRetryFavorite,
  });

  final AnimeDetailProfile anime;
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
        SliverToBoxAdapter(child: AnimeDetailProfileBanner(anime: anime)),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimeDetailProfileTitle(anime: anime),
                    const SizedBox(height: 14),
                    AnimeDetailProfileMetadata(anime: anime),
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
                    const SizedBox(height: 8),
                    _buildFavoriteAction(),
                    const SizedBox(height: 16),
                    AnimeDetailProfileSynopsisCard(
                      description: anime.description,
                    ),
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

class _DetailProfileBackButton extends StatelessWidget {
  const _DetailProfileBackButton();

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
          fixedSize: const Size(40, 40),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _DetailProfileError extends StatelessWidget {
  const _DetailProfileError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Impossible de charger cet anime',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
