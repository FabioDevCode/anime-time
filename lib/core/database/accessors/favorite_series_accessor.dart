part of '../database.dart';

@DriftAccessor(tables: [FavoriteSeries])
class FavoriteSeriesAccessor extends DatabaseAccessor<AppDatabase>
    with _$FavoriteSeriesAccessorMixin {
  FavoriteSeriesAccessor(super.attachedDatabase);

  /// Insère une nouvelle série et retourne son seriesId autoincrement.
  Future<int> insertSeries(FavoriteSeriesCompanion series) {
    return into(favoriteSeries).insert(series);
  }

  Future<void> updateSeries(
    int seriesId,
    FavoriteSeriesCompanion series,
  ) async {
    await (update(
      favoriteSeries,
    )..where((t) => t.seriesId.equals(seriesId))).write(series);
  }

  Stream<FavoriteSery?> watchById(int seriesId) {
    return (select(
      favoriteSeries,
    )..where((t) => t.seriesId.equals(seriesId))).watchSingleOrNull();
  }

  Stream<int> watchCount() {
    return select(favoriteSeries).watch().map((rows) => rows.length);
  }

  /// Retourne toutes les séries avec la coverImage de leur dernière saison.
  Stream<List<(FavoriteSery, String?)>> watchAllWithCover() {
    final query = select(favoriteSeries).join([
      leftOuterJoin(
        attachedDatabase.favoriteAnime,
        attachedDatabase.favoriteAnime.animeId.equalsExp(
          favoriteSeries.latestAnimeId,
        ),
      ),
    ]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => (
              row.readTable(favoriteSeries),
              row.readTableOrNull(attachedDatabase.favoriteAnime)?.coverImage,
            ),
          )
          .toList(),
    );
  }
}
