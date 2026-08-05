import 'package:drift/drift.dart';

import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/favorites/services/favorite_series_service.dart';

class FavoriteSynchronizationService {
  const FavoriteSynchronizationService(this._database, this._seriesService);

  final AppDatabase _database;
  final FavoriteSeriesService _seriesService;

  // Identifiant unique de la ligne de paramètres.
  static const _paramsId = 0;

  Future<void> synchronizeIfNeeded() async {
    if (await _isAlreadySyncedToday()) return;
    await _synchronizeAllSeries();
    await _updateLastSync();
  }

  Future<bool> _isAlreadySyncedToday() async {
    final params = await (_database.select(
      _database.animeParams,
    )..where((t) => t.id.equals(_paramsId))).getSingleOrNull();

    final lastSync = params?.lastFavoritesSync;
    if (lastSync == null) return false;

    final today = DateTime.now();
    return lastSync.year == today.year &&
        lastSync.month == today.month &&
        lastSync.day == today.day;
  }

  Future<void> _synchronizeAllSeries() async {
    final allSeries = await _database.select(_database.favoriteSeries).get();
    for (final series in allSeries) {
      await _synchronizeSeries(series);
    }
  }

  Future<void> _synchronizeSeries(FavoriteSery series) async {
    try {
      await _seriesService.refreshSeries(series.seriesId, series.latestAnimeId);
    } catch (_) {
      // Erreur isolée : la synchronisation des autres séries se poursuit.
    }
  }

  Future<void> _updateLastSync() async {
    await _database
        .into(_database.animeParams)
        .insertOnConflictUpdate(
          AnimeParamsCompanion(
            id: const Value(_paramsId),
            lastFavoritesSync: Value(DateTime.now()),
          ),
        );
  }
}
