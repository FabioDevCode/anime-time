import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/serie_details/providers/serie_details_providers.dart';
import 'package:anime_time/features/serie_details/presentation/widgets/serie_details_banner.dart';
import 'package:anime_time/features/serie_details/presentation/widgets/serie_details_metadata.dart';
import 'package:anime_time/features/serie_details/presentation/widgets/serie_details_season_card.dart';
import 'package:anime_time/features/serie_details/presentation/widgets/serie_details_synopsis_card.dart';
import 'package:anime_time/features/serie_details/presentation/widgets/serie_details_title.dart';

class SerieDetailsView extends ConsumerWidget {
  const SerieDetailsView({super.key, required this.seriesId});

  final int seriesId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serieAsync = ref.watch(serieStreamProvider(seriesId));
    final seasonsAsync = ref.watch(seasonsStreamProvider(seriesId));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: serieAsync.when(
              data: (serie) {
                if (serie == null) {
                  return _SerieDetailsError(
                    onRetry: () =>
                        ref.invalidate(serieStreamProvider(seriesId)),
                  );
                }
                return _SerieDetailsContent(
                  serie: serie,
                  seasonsAsync: seasonsAsync,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => _SerieDetailsError(
                onRetry: () => ref.invalidate(serieStreamProvider(seriesId)),
              ),
            ),
          ),
          const _SerieDetailsBackButton(),
        ],
      ),
    );
  }
}

class _SerieDetailsContent extends ConsumerWidget {
  const _SerieDetailsContent({required this.serie, required this.seasonsAsync});

  final FavoriteSery serie;
  final AsyncValue<List<FavoriteAnimeData>> seasonsAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphqlAsync = ref.watch(
      serieDetailsGraphqlProvider(serie.latestAnimeId),
    );
    final graphqlInfo = graphqlAsync.asData?.value;
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 32;
    final seasons = seasonsAsync.asData?.value ?? const [];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SerieDetailsBanner(series: serie, graphqlInfo: graphqlInfo),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SerieDetailsTitle(series: serie, graphqlInfo: graphqlInfo),
                    const SizedBox(height: 14),
                    if (graphqlInfo != null) ...[
                      SerieDetailsMetadata(graphqlInfo: graphqlInfo),
                      if (graphqlInfo.genres.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        _GenresChips(genres: graphqlInfo.genres),
                      ],
                      const SizedBox(height: 16),
                      SerieDetailsSynopsisCard(
                        description: graphqlInfo.description,
                      ),
                    ],
                    if (seasons.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _SeasonsSection(seasons: seasons),
                    ],
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

class _GenresChips extends StatelessWidget {
  const _GenresChips({required this.genres});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: -12,
      children: genres.map((genre) {
        return Chip(
          label: Text(
            genre,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: -4),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide.none,
          ),
        );
      }).toList(),
    );
  }
}

class _SeasonsSection extends StatelessWidget {
  const _SeasonsSection({required this.seasons});

  final List<FavoriteAnimeData> seasons;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saisons',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        for (final season in seasons) ...[
          SerieDetailsSeasonCard(season: season),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _SerieDetailsBackButton extends StatelessWidget {
  const _SerieDetailsBackButton();

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

class _SerieDetailsError extends StatelessWidget {
  const _SerieDetailsError({required this.onRetry});

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
              'Impossible de charger cette série',
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
