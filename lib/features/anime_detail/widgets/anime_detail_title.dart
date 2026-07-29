import 'package:flutter/material.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';
import 'package:anime_time/features/discover/utils/anime_status.dart';
import 'package:anime_time/features/discover/widgets/anime_status_badge.dart';

class AnimeDetailTitle extends StatelessWidget {
  const AnimeDetailTitle({super.key, required this.anime});

  final AnimeDetail anime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final romaji =
        anime.titleRomaji ?? anime.titleNative ?? 'Titre indisponible';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          romaji,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.12,
          ),
        ),
        if (anime.titleNative != null && anime.titleNative != romaji) ...[
          const SizedBox(height: 4),
          Text(
            anime.titleNative!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (anime.status.badgeData case final badge?) ...[
          const SizedBox(height: 10),
          AnimeStatusBadge(data: badge),
        ],
      ],
    );
  }
}
