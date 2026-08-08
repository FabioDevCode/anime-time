import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/models/series_media.dart';
import 'package:anime_time/common/utils/anime_status.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_cover_card.dart';
import 'package:anime_time/features/anime_detail_profile/routes/anime_detail_profile_route.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';
import 'package:anime_time/features/profile/providers/profile_providers.dart';
import 'package:anime_time/features/serie_details/routes/serie_details_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/core/theme/app_colors_extension.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileDataProvider);

    return SafeArea(
      bottom: false,
      child: profileData.when(
        data: (data) => _ProfileContent(data: data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const _ProfileLoadError(),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 96),
      children: [
        _StatisticsRow(statistics: data.statistics),
        const SizedBox(height: 12),
        const _SeriesSection(),
        const SizedBox(height: 12),
        _ProfileSection(title: 'Mes favoris', anime: data.favorites),
        const SizedBox(height: 12),
        _ProfileSection(title: 'À venir', anime: data.upcoming),
      ],
    );
  }
}

class _StatisticsRow extends StatelessWidget {
  const _StatisticsRow({required this.statistics});

  final ProfileStatistics statistics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatisticCard(
            value: statistics.totalFavorites,
            label: 'Favoris',
            status: 'FINISHED',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatisticCard(
            value: statistics.releasing,
            label: 'En cours',
            status: 'RELEASING',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatisticCard(
            value: statistics.upcoming,
            label: 'À venir',
            status: 'NOT_YET_RELEASED',
          ),
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    required this.value,
    required this.label,
    required this.status,
  });

  final int value;
  final String label;
  final String status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusBadge = status.badgeData!;

    return Card(
      margin: EdgeInsets.zero,
      color: statusBadge.backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 98,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value.toString(),
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: statusBadge.textColor,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelMedium?.copyWith(
                  color: statusBadge.textColor,
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

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.title, required this.anime});

  final String title;
  final List<AnimeMedia> anime;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: appColors.brandBackground,
              ),
              child: const Text('Voir plus'),
            ),
          ],
        ),
        if (anime.isNotEmpty) ...[
          const SizedBox(height: 4),
          _AnimeCarousel(anime: anime),
        ],
      ],
    );
  }
}

class _AnimeCarousel extends StatelessWidget {
  const _AnimeCarousel({required this.anime});

  final List<AnimeMedia> anime;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final coverWidth = (constraints.maxWidth * 0.2)
            .clamp(96.0, 152.0)
            .toDouble();

        return SizedBox(
          height: coverWidth * 1.5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: anime.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) => SizedBox(
              width: coverWidth,
              child: AnimeCoverCard(
                anime: anime[index],
                onTap: () => context.push(
                  AnimeDetailProfileRoute.location(anime[index].id),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileLoadError extends StatelessWidget {
  const _ProfileLoadError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Impossible de charger le profil',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _SeriesSection extends ConsumerWidget {
  const _SeriesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seriesAsync = ref.watch(favoriteSeriesListProvider);

    return seriesAsync.maybeWhen(
      data: (series) {
        if (series.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'Mes séries',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 4),
            _SeriesCarousel(series: series),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _SeriesCarousel extends StatelessWidget {
  const _SeriesCarousel({required this.series});

  final List<SeriesMedia> series;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final coverWidth = (constraints.maxWidth * 0.2)
            .clamp(96.0, 152.0)
            .toDouble();

        return SizedBox(
          height: coverWidth * 1.5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: series.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = series[index];
              return SizedBox(
                width: coverWidth,
                child: _SeriesCoverCard(
                  series: item,
                  onTap: () =>
                      context.push(SerieDetailsRoute.location(item.seriesId)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _SeriesCoverCard extends StatelessWidget {
  const _SeriesCoverCard({required this.series, required this.onTap});

  final SeriesMedia series;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title =
        series.displayTitleRomaji ??
        series.displayTitleEnglish ??
        series.displayTitleNative;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (series.coverImage != null)
              Image.network(
                series.coverImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    ColoredBox(color: colorScheme.surfaceContainerHighest),
              )
            else
              ColoredBox(color: colorScheme.surfaceContainerHighest),
            if (title != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(6, 16, 6, 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.78),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
