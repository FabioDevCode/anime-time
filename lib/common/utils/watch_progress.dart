import 'package:anime_time/core/database/database.dart';

/// Retourne true uniquement si le total d'épisodes est connu et entièrement vu.
bool isSeasonComplete(FavoriteAnimeData season) {
  final episodes = season.episodes;
  if (episodes == null) return false;
  return season.lastEpisodeWatched >= episodes;
}
