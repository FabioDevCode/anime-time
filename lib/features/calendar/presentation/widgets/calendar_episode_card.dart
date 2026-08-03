import 'package:anime_time/features/calendar/data/models/calendar_episode.dart';
import 'package:flutter/material.dart';

class CalendarEpisodeCard extends StatelessWidget {
  const CalendarEpisodeCard({
    super.key,
    required this.episode,
    required this.scheduleLabel,
  });

  final CalendarEpisode episode;
  final String scheduleLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: SizedBox(
                width: 76,
                height: 100,
                child: episode.coverImage.isEmpty
                    ? _CoverPlaceholder(colorScheme: colorScheme)
                    : Image.network(
                        episode.coverImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _CoverPlaceholder(colorScheme: colorScheme),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // if (episode.nativeTitle case final nativeTitle?
                    //     when nativeTitle != episode.title) ...[
                    //   const SizedBox(height: 2),
                    //   Text(
                    //     nativeTitle,
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: textTheme.bodySmall?.copyWith(
                    //       color: colorScheme.onSurfaceVariant,
                    //     ),
                    //   ),
                    // ],
                    const SizedBox(height: 10),
                    Text(
                      'Épisode ${episode.episode}',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      scheduleLabel,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
