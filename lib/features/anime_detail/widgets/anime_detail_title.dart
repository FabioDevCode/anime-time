import 'package:flutter/material.dart';
import 'package:anime_time/common/utils/anime_status.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_status_badge.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';

class AnimeDetailTitle extends StatelessWidget {
  const AnimeDetailTitle({super.key, required this.anime});

  final AnimeDetail anime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final english = anime.titleEnglish;
    final native = anime.titleNative;
    final secondaryTitleStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (english != null)
          Text(
            english,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: secondaryTitleStyle,
          ),
        if (native != null && native != english) ...[
          if (english != null) const SizedBox(height: 4),
          Text(native, style: secondaryTitleStyle),
        ],
        if (anime.status.badgeData case final badge?) ...[
          const SizedBox(height: 10),
          AnimeStatusBadge(data: badge),
        ],
      ],
    );
  }
}
