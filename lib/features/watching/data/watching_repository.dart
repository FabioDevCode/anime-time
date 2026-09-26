import 'dart:async';

import 'package:anime_time/common/utils/watch_progress.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/watching/data/models/watching_series_item.dart';

class WatchingRepository {
  const WatchingRepository(
    this._favoriteAnimeAccessor,
    this._favoriteSeriesAccessor,
  );

  final FavoriteAnimeAccessor _favoriteAnimeAccessor;
  final FavoriteSeriesAccessor _favoriteSeriesAccessor;

  static const _notYetReleased = 'NOT_YET_RELEASED';

  /// Émet la liste réactive des séries ayant au moins une saison à regarder.
  Stream<List<WatchingSeriesItem>> watchWatchingItems() {
    final controller = StreamController<List<WatchingSeriesItem>>();

    List<FavoriteAnimeData>? latestAnime;
    List<(FavoriteSery, String?)>? latestSeriesRows;

    void tryEmit() {
      if (latestAnime != null && latestSeriesRows != null) {
        controller.add(_toWatchingItems(latestAnime!, latestSeriesRows!));
      }
    }

    final animeSub = _favoriteAnimeAccessor.watchAll().listen((records) {
      latestAnime = records;
      tryEmit();
    }, onError: controller.addError);
    final seriesSub = _favoriteSeriesAccessor.watchAllWithCover().listen((
      rows,
    ) {
      latestSeriesRows = rows;
      tryEmit();
    }, onError: controller.addError);

    controller.onCancel = () {
      animeSub.cancel();
      seriesSub.cancel();
    };

    return controller.stream;
  }

  List<WatchingSeriesItem> _toWatchingItems(
    List<FavoriteAnimeData> records,
    List<(FavoriteSery, String?)> seriesRows,
  ) {
    final seasonsBySeriesId = <int, List<FavoriteAnimeData>>{};
    for (final anime in records) {
      final id = anime.seriesId;
      if (id == null) continue;
      seasonsBySeriesId.putIfAbsent(id, () => []).add(anime);
    }

    for (final seasons in seasonsBySeriesId.values) {
      seasons.sort(
        (a, b) => (a.seasonNumber ?? 0).compareTo(b.seasonNumber ?? 0),
      );
    }

    final items = <WatchingSeriesItem>[];
    for (final row in seriesRows) {
      final series = row.$1;
      final seasons = seasonsBySeriesId[series.seriesId] ?? [];

      final unwatched = [
        for (final season in seasons)
          if (season.status != _notYetReleased &&
              !isSeasonComplete(season) &&
              season.seasonNumber != null)
            season.seasonNumber!,
      ];

      if (unwatched.isEmpty) continue;

      items.add(
        WatchingSeriesItem(
          seriesId: series.seriesId,
          displayTitle:
              series.displayTitleEnglish ??
              series.displayTitleRomaji ??
              series.displayTitleNative,
          coverImage: row.$2,
          unwatchedSeasonNumbers: unwatched,
        ),
      );
    }

    return items;
  }
}
