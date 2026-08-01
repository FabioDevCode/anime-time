import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';

/// Construit les données du profil exclusivement à partir de Drift.
class ProfileRepository {
  const ProfileRepository(this._favoriteAnimeAccessor);

  final FavoriteAnimeAccessor _favoriteAnimeAccessor;

  static const _releasingStatus = 'RELEASING';
  static const _finishedStatus = 'FINISHED';
  static const _upcomingStatus = 'NOT_YET_RELEASED';

  /// Réémet les statistiques et les listes dès que la table locale change.
  Stream<ProfileData> watchProfileData() {
    return _favoriteAnimeAccessor.watchAll().map(_toProfileData);
  }

  ProfileData _toProfileData(List<FavoriteAnimeData> records) {
    var releasing = 0;
    var upcoming = 0;
    final favorites = <AnimeMedia>[];
    final upcomingAnime = <AnimeMedia>[];

    for (final record in records) {
      switch (record.status) {
        case _releasingStatus:
          releasing += 1;
          favorites.add(_toAnimeMedia(record));
        case _finishedStatus:
          favorites.add(_toAnimeMedia(record));
        case _upcomingStatus:
          upcoming += 1;
          upcomingAnime.add(_toAnimeMedia(record));
      }
    }

    return ProfileData(
      statistics: ProfileStatistics(
        totalFavorites: records.length,
        releasing: releasing,
        upcoming: upcoming,
      ),
      favorites: List.unmodifiable(favorites),
      upcoming: List.unmodifiable(upcomingAnime),
    );
  }

  AnimeMedia _toAnimeMedia(FavoriteAnimeData anime) {
    return AnimeMedia(
      id: anime.animeId,
      status: anime.status ?? '',
      coverImageLarge: anime.coverImage,
      titleRomaji: anime.titleRomaji,
      titleEnglish: anime.titleEnglish,
      titleNative: anime.titleNative,
      season: anime.season,
      seasonYear: anime.seasonYear,
    );
  }
}
