import 'dart:async';

import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';

/// Construit les données du profil exclusivement à partir de Drift.
class ProfileRepository {
  const ProfileRepository(
    this._favoriteAnimeAccessor,
    this._favoriteSeriesAccessor,
  );

  final FavoriteAnimeAccessor _favoriteAnimeAccessor;
  final FavoriteSeriesAccessor _favoriteSeriesAccessor;

  static const _releasingStatus = 'RELEASING';
  static const _finishedStatus = 'FINISHED';
  static const _upcomingStatus = 'NOT_YET_RELEASED';

  /// Réémet les statistiques et les listes dès que l'une ou l'autre table change.
  Stream<ProfileData> watchProfileData() {
    final controller = StreamController<ProfileData>();

    List<FavoriteAnimeData>? latestAnime;
    int? latestSeriesCount;

    void tryEmit() {
      if (latestAnime != null && latestSeriesCount != null) {
        controller.add(_toProfileData(latestAnime!, latestSeriesCount!));
      }
    }

    final animeSub = _favoriteAnimeAccessor.watchAll().listen((records) {
      latestAnime = records;
      tryEmit();
    }, onError: controller.addError);
    final seriesSub = _favoriteSeriesAccessor.watchCount().listen((count) {
      latestSeriesCount = count;
      tryEmit();
    }, onError: controller.addError);

    controller.onCancel = () {
      animeSub.cancel();
      seriesSub.cancel();
    };

    return controller.stream;
  }

  ProfileData _toProfileData(List<FavoriteAnimeData> records, int seriesCount) {
    var releasing = 0;
    var upcoming = 0;
    final favorites = <AnimeMedia>[];
    final releasingAnime = <AnimeMedia>[];
    final upcomingAnime = <AnimeMedia>[];

    for (final record in records) {
      switch (record.status) {
        case _releasingStatus:
          releasing += 1;
          releasingAnime.add(_toAnimeMedia(record));
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
        totalFavorites: seriesCount,
        releasing: releasing,
        upcoming: upcoming,
      ),
      favorites: List.unmodifiable(favorites),
      releasing: List.unmodifiable(releasingAnime),
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
