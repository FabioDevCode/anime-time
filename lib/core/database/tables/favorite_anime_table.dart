import 'package:drift/drift.dart';

/// Schéma local des anime marqués comme favoris.
class FavoriteAnime extends Table {
  /// Identifiant AniList, fourni par l'API et donc non auto-incrémenté.
  IntColumn get animeId => integer()();

  /// Les titres et métadonnées d'AniList peuvent être absents.
  TextColumn get titleRomaji => text().nullable()();
  TextColumn get titleEnglish => text().nullable()();
  TextColumn get titleNative => text().nullable()();

  TextColumn get coverImage => text().nullable()();
  TextColumn get bannerImage => text().nullable()();

  TextColumn get status => text().nullable()();

  TextColumn get season => text().nullable()();
  IntColumn get seasonYear => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {animeId};
}
