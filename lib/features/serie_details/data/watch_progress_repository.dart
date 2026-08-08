import 'package:anime_time/core/database/database.dart';

class WatchProgressRepository {
  const WatchProgressRepository(this._accessor);

  final FavoriteAnimeAccessor _accessor;

  /// Si l'épisode est déjà vu, revient à l'épisode précédent ; sinon avance jusqu'à lui.
  Future<void> toggleEpisode({
    required int animeId,
    required int episodeNumber,
    required int currentLastWatched,
  }) async {
    final newValue = episodeNumber <= currentLastWatched
        ? episodeNumber - 1
        : episodeNumber;
    await _accessor.updateLastEpisodeWatched(animeId, newValue);
  }
}
