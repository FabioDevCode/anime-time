import 'package:anime_time/core/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';
import 'package:anime_time/features/anime_detail/providers/anime_detail_providers.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_airing_card.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_banner.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_metadata.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_synopsis_card.dart';
import 'package:anime_time/features/anime_detail/widgets/anime_detail_title.dart';

class AnimeDetailView extends ConsumerWidget {
  const AnimeDetailView({super.key, required this.animeId});

  final int animeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeDetail = ref.watch(animeDetailProvider(animeId));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: animeDetail.when(
              data: (anime) => _AnimeDetailContent(anime: anime),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _DetailError(
                onRetry: () => ref.invalidate(animeDetailProvider(animeId)),
              ),
            ),
          ),
          const _DetailBackButton(),
        ],
      ),
    );
  }
}

class _AnimeDetailContent extends StatelessWidget {
  const _AnimeDetailContent({required this.anime});

  final AnimeDetail anime;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 32;
    final appColors = context.appColors;

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
                        runSpacing: 4,
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
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_rounded),
                        label: const Text('Ajouter aux favoris'),
                        style: FilledButton.styleFrom(
                          backgroundColor: appColors.brandBackground,
                          foregroundColor: appColors.onBrandBackground,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    if (anime.status == 'RELEASING' &&
                        anime.nextAiringEpisode != null) ...[
                      const SizedBox(height: 16),
                      AnimeDetailAiringCard(
                        nextEpisode: anime.nextAiringEpisode!,
                      ),
                    ],
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
