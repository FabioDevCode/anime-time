import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_cover_card.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';
import 'package:anime_time/features/profile/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileDataProvider);

    return SafeArea(
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
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 112;

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 24, 20, bottomPadding),
      children: [
        _StatisticsRow(statistics: data.statistics),
        const SizedBox(height: 28),
        const _LastSyncDivider(),
        const SizedBox(height: 32),
        _ProfileSection(title: 'Mes favoris', anime: data.favorites),
        const SizedBox(height: 32),
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
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatisticCard(value: statistics.releasing, label: 'En cours'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatisticCard(value: statistics.upcoming, label: 'À venir'),
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerHigh,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: SizedBox(
        height: 118,
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
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
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

class _LastSyncDivider extends StatelessWidget {
  const _LastSyncDivider();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Expanded(child: Divider()),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Dernière mise à jour : 27/07/2026',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.title, required this.anime});

  final String title;
  final List<AnimeMedia> anime;

  @override
  Widget build(BuildContext context) {
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
            TextButton(onPressed: () {}, child: const Text('Voir plus')),
          ],
        ),
        if (anime.isNotEmpty) ...[
          const SizedBox(height: 12),
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
        final coverWidth = (constraints.maxWidth * 0.3)
            .clamp(96.0, 152.0)
            .toDouble();

        return SizedBox(
          height: coverWidth * 1.5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: anime.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => SizedBox(
              width: coverWidth,
              child: AnimeCoverCard(anime: anime[index]),
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
