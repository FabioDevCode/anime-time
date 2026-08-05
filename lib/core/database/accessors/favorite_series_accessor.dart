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
}
