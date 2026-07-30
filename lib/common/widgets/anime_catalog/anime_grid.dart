import 'package:flutter/material.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_cover_card.dart';

class AnimeGrid extends StatelessWidget {
  const AnimeGrid({
    super.key,
    required this.items,
    required this.scrollController,
    this.isLoadingMore = false,
    this.onAnimeTap,
    this.topPadding = 0,
    this.horizontalPadding = 8,
  });

  final List<AnimeMedia> items;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final ValueChanged<AnimeMedia>? onAnimeTap;
  final double topPadding;
  final double horizontalPadding;

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

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding + 8,
                horizontalPadding,
                isLoadingMore ? 0 : bottomPadding,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final anime = items[index];
                  return AnimeCoverCard(
                    anime: anime,
                    onTap: onAnimeTap != null ? () => onAnimeTap!(anime) : null,
                  );
                }, childCount: items.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 2 / 3,
                ),
              ),
            ),
            if (isLoadingMore)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, bottomPadding),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      },
    );
  }
}
