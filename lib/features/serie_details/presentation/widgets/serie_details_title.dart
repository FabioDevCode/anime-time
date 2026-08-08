import 'package:flutter/material.dart';
import 'package:anime_time/common/utils/anime_status.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_status_badge.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/serie_details/data/models/serie_graphql_info.dart';

class SerieDetailsTitle extends StatelessWidget {
  const SerieDetailsTitle({super.key, required this.series, this.graphqlInfo});

  final FavoriteSery series;
  final SerieGraphqlInfo? graphqlInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final english = series.displayTitleEnglish;
    final native = series.displayTitleNative;
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
        if (graphqlInfo?.status.badgeData case final badge?) ...[
          const SizedBox(height: 10),
          AnimeStatusBadge(data: badge),
        ],
      ],
    );
  }
}
