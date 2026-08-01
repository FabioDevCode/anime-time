part of '../database.dart';

/// Accès Drift aux opérations de persistance des anime favoris.
@DriftAccessor(tables: [FavoriteAnime])
class FavoriteAnimeAccessor extends DatabaseAccessor<AppDatabase>
    with _$FavoriteAnimeAccessorMixin {
  FavoriteAnimeAccessor(super.attachedDatabase);

  Future<bool> contains(int animeId) async {
    final anime = await (select(
      favoriteAnime,
    )..where((table) => table.animeId.equals(animeId))).getSingleOrNull();

    return anime != null;
  }

  /// Observe l'ensemble des favoris afin de mettre à jour les vues locales.
  Stream<List<FavoriteAnimeData>> watchAll() => select(favoriteAnime).watch();

  Future<void> upsert(FavoriteAnimeCompanion anime) async {
    await into(favoriteAnime).insertOnConflictUpdate(anime);
  }

  Future<void> deleteByAnimeId(int animeId) async {
    await (delete(
      favoriteAnime,
    )..where((table) => table.animeId.equals(animeId))).go();
  }
}
