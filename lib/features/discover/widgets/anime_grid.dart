import 'package:flutter/material.dart';
import 'package:anime_time/features/discover/data/models/anime_media.dart';
import 'package:anime_time/features/discover/widgets/anime_cover_card.dart';

class AnimeGrid extends StatelessWidget {
  const AnimeGrid({
    super.key,
    required this.items,
    required this.scrollController,
    this.isLoadingMore = false,
    this.onAnimeTap,
    this.topPadding = 0,
  });

  final List<AnimeMedia> items;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final ValueChanged<AnimeMedia>? onAnimeTap;
  final double topPadding;

  int _columnCount(double width) {
    if (width >= 900) return 6;
    if (width >= 600) return 4;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 16;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _columnCount(constraints.maxWidth);

        return GridView.builder(
          controller: scrollController,
          padding: EdgeInsets.fromLTRB(8, topPadding + 8, 8, bottomPadding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 2 / 3,
          ),
          itemCount: items.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == items.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final anime = items[index];
            return AnimeCoverCard(
              anime: anime,
              onTap: onAnimeTap != null ? () => onAnimeTap!(anime) : null,
            );
          },
        );
      },
    );
  }
}
