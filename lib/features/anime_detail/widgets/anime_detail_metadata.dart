import 'package:flutter/material.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';

class AnimeDetailMetadata extends StatelessWidget {
  const AnimeDetailMetadata({super.key, required this.anime});

  final AnimeDetail anime;

  static const _seasonNames = {
    'WINTER': 'Hiver',
    'SPRING': 'Printemps',
    'SUMMER': 'Été',
    'FALL': 'Automne',
  };

  @override
  Widget build(BuildContext context) {
    final labels = <String>[];
    final episodeAndDuration = <String>[];

    if (anime.episodes != null) {
      final suffix = anime.episodes == 1 ? 'épisode' : 'épisodes';
      episodeAndDuration.add('${anime.episodes} $suffix');
    }
    if (anime.duration != null) {
      episodeAndDuration.add('${anime.duration} min');
    }
    if (episodeAndDuration.isNotEmpty) {
      labels.add(episodeAndDuration.join(' • '));
    }

    final seasonName = _seasonNames[anime.season] ?? anime.season;
    if (seasonName != null || anime.seasonYear != null) {
      labels.add([seasonName, anime.seasonYear?.toString()].nonNulls.join(' '));
    }
    if (anime.averageScore != null) labels.add('★ ${anime.averageScore} %');

    if (labels.isEmpty) return const SizedBox.shrink();

    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        for (var index = 0; index < labels.length; index++) ...[
          if (index > 0) Text('•', style: textStyle),
          Text(labels[index], style: textStyle),
        ],
      ],
    );
  }
}
