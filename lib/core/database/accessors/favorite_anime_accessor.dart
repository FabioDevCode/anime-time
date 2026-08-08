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

  /// Observe uniquement les favoris dont la diffusion est en cours.
  ///
  /// Le calendrier s'appuie sur cette sélection locale comme source de vérité
  /// avant de demander les horaires dynamiques à AniList.
  Stream<List<FavoriteAnimeData>> watchReleasing() {
    return (select(
      favoriteAnime,
    )..where((table) => table.status.equals('RELEASING'))).watch();
  }

  Future<void> upsert(FavoriteAnimeCompanion anime) async {
    // On conflit, lastEpisodeWatched (donnée utilisateur) n'est jamais écrasé.
    // airedEpisodes est préservé si la nouvelle valeur serait null (Cas 3).
    final airedEpisodesForUpdate =
        anime.airedEpisodes.present && anime.airedEpisodes.value == null
        ? const Value<int?>.absent()
        : anime.airedEpisodes;
    await into(favoriteAnime).insert(
      anime,
      onConflict: DoUpdate(
        (_) => anime.copyWith(
          lastEpisodeWatched: const Value.absent(),
          airedEpisodes: airedEpisodesForUpdate,
        ),
      ),
    );
  }

  Future<void> deleteByAnimeId(int animeId) async {
    await (delete(
      favoriteAnime,
    )..where((table) => table.animeId.equals(animeId))).go();
  }

  Stream<List<FavoriteAnimeData>> watchBySeriesId(int seriesId) {
    return (select(favoriteAnime)
          ..where((t) => t.seriesId.equals(seriesId))
          ..orderBy([(t) => OrderingTerm.asc(t.seasonNumber)]))
        .watch();
  }

  Future<void> updateLastEpisodeWatched(int animeId, int value) async {
    await (update(favoriteAnime)..where((t) => t.animeId.equals(animeId)))
        .write(FavoriteAnimeCompanion(lastEpisodeWatched: Value(value)));
  }
}
