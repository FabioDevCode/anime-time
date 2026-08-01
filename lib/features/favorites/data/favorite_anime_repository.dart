import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/favorites/data/models/favorite_anime_draft.dart';
import 'package:drift/drift.dart';

/// Accès applicatif au stockage local des anime favoris.
class FavoriteAnimeRepository {
  const FavoriteAnimeRepository(this._accessor);

  final FavoriteAnimeAccessor _accessor;

  Future<bool> isFavorite(int animeId) => _accessor.contains(animeId);

  Future<void> add(FavoriteAnimeDraft anime) {
    return _accessor.upsert(
      FavoriteAnimeCompanion(
        animeId: Value(anime.animeId),
        titleRomaji: Value(anime.titleRomaji),
        titleEnglish: Value(anime.titleEnglish),
        titleNative: Value(anime.titleNative),
        coverImage: Value(anime.coverImage),
        bannerImage: Value(anime.bannerImage),
        status: Value(anime.status),
        season: Value(anime.season),
        seasonYear: Value(anime.seasonYear),
      ),
    );
  }

  Future<void> remove(int animeId) => _accessor.deleteByAnimeId(animeId);
}
