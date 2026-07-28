import 'package:flutter/material.dart';
import 'package:anime_time/features/discover/data/models/anime_media.dart';
import 'package:anime_time/features/discover/widgets/anime_list_item.dart';

class DiscoverListView extends StatelessWidget {
  const DiscoverListView({
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

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 16;

    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(0, topPadding + 8, 0, bottomPadding),
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 80),
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
          onTap: onAnimeTap != null ? () => onAnimeTap!(anime) : null,
        );
      },
    );
  }
}
