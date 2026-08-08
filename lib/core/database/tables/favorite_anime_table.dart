import 'package:drift/drift.dart';

import 'favorite_series_table.dart';

/// Schéma local des anime marqués comme favoris.
class FavoriteAnime extends Table {
  /// Identifiant AniList, fourni par l'API et donc non auto-incrémenté.
  IntColumn get animeId => integer()();

  /// Référence vers la série parente (null si non encore associé).
  IntColumn get seriesId =>
      integer().nullable().references(FavoriteSeries, #seriesId)();

  /// Numéro de saison calculé par l'application, jamais fourni par AniList.
  IntColumn get seasonNumber => integer().nullable()();

  /// Les titres et métadonnées d'AniList peuvent être absents.
  TextColumn get titleRomaji => text().nullable()();
  TextColumn get titleEnglish => text().nullable()();
  TextColumn get titleNative => text().nullable()();

  TextColumn get coverImage => text().nullable()();
  TextColumn get bannerImage => text().nullable()();

  IntColumn get episodes => integer().nullable()();

  /// Dernier épisode actuellement diffusé : nextAiringEpisode.episode - 1.
  IntColumn get airedEpisodes => integer().nullable()();

  IntColumn get lastEpisodeWatched =>
      integer().withDefault(const Constant(0))();

  TextColumn get status => text().nullable()();

  TextColumn get season => text().nullable()();
  IntColumn get seasonYear => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {animeId};
}
