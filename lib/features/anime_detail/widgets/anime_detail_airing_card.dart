import 'package:flutter/material.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';

class AnimeDetailAiringCard extends StatelessWidget {
  const AnimeDetailAiringCard({super.key, required this.nextEpisode});

  final NextAiringEpisode nextEpisode;

  static const _months = [
    'janvier',
    'février',
    'mars',
    'avril',
    'mai',
    'juin',
    'juillet',
    'août',
    'septembre',
    'octobre',
    'novembre',
    'décembre',
  ];

  @override
  Widget build(BuildContext context) {
    final episodeLabel = nextEpisode.episode == null
        ? 'Prochain épisode'
        : 'Prochain épisode · ${nextEpisode.episode}';

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.schedule_rounded),
        title: Text(episodeLabel),
        subtitle: nextEpisode.airingAt == null
            ? null
            : Text('Diffusion ${_formatDate(nextEpisode.airingAt!)}'),
      ),
    );
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      timestamp * Duration.millisecondsPerSecond,
      isUtc: true,
    ).toLocal();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${_months[date.month - 1]} à $hour:$minute';
  }
}
