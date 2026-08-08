import 'package:flutter/material.dart';
import 'package:anime_time/core/database/database.dart';

class SerieDetailsSeasonCard extends StatelessWidget {
  const SerieDetailsSeasonCard({super.key, required this.season});

  final FavoriteAnimeData season;

  static const _progressColorComplete = Color(0xFF66BB6A);
  static const _progressColorPartial = Color(0xFFFFB74D);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final episodes = season.episodes;
    final watched = season.lastEpisodeWatched;
    final progress = episodes != null && episodes > 0
        ? (watched / episodes).clamp(0.0, 1.0)
        : null;
    final isComplete = episodes != null && watched >= episodes;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                width: 56,
                height: 84,
                child: season.coverImage == null
                    ? ColoredBox(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      )
                    : Image.network(
                        season.coverImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => ColoredBox(
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    'Saison ${season.seasonNumber ?? '?'}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (episodes != null)
                    Text(
                      '$watched / $episodes épisode${episodes == 1 ? '' : 's'}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    Text(
                      '$watched épisode${watched == 1 ? '' : 's'} vu${watched == 1 ? '' : 's'}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  if (progress != null) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        color: isComplete
                            ? _progressColorComplete
                            : _progressColorPartial,
                        minHeight: 5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
