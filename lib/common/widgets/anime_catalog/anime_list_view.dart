import 'package:flutter/material.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_list_item.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({
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

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 8;

    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(0, topPadding, 0, bottomPadding),
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 68),
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
        return AnimeListItem(
          anime: anime,
          horizontalPadding: horizontalPadding,
          onTap: onAnimeTap != null ? () => onAnimeTap!(anime) : null,
        );
      },
    );
  }
}
