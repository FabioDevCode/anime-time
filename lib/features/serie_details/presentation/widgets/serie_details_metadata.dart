import 'package:flutter/material.dart';
import 'package:anime_time/features/serie_details/data/models/serie_graphql_info.dart';

class SerieDetailsMetadata extends StatelessWidget {
  const SerieDetailsMetadata({super.key, required this.graphqlInfo});

  final SerieGraphqlInfo graphqlInfo;

  static const _seasonNames = {
    'WINTER': 'Hiver',
    'SPRING': 'Printemps',
    'SUMMER': 'Été',
    'FALL': 'Automne',
  };

  @override
  Widget build(BuildContext context) {
    final labels = <String>[];

    if (graphqlInfo.duration != null) {
      labels.add('${graphqlInfo.duration} min');
    }

    final seasonName = _seasonNames[graphqlInfo.season] ?? graphqlInfo.season;
    if (seasonName != null || graphqlInfo.seasonYear != null) {
      labels.add(
        [seasonName, graphqlInfo.seasonYear?.toString()].nonNulls.join(' '),
      );
    }
    if (graphqlInfo.averageScore != null) {
      labels.add('★ ${graphqlInfo.averageScore} %');
    }

    if (labels.isEmpty) return const SizedBox.shrink();

    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        for (var i = 0; i < labels.length; i++) ...[
          if (i > 0) Text('•', style: textStyle),
          Text(labels[i], style: textStyle),
        ],
      ],
    );
  }
}
