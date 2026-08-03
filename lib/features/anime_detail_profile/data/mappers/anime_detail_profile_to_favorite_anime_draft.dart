import 'package:anime_time/features/anime_detail_profile/data/models/anime_detail_profile.dart';
import 'package:anime_time/features/favorites/data/models/favorite_anime_draft.dart';

extension AnimeDetailProfileToFavoriteAnimeDraft on AnimeDetailProfile {
  FavoriteAnimeDraft toFavoriteAnimeDraft() {
    return FavoriteAnimeDraft(
      animeId: id,
      titleRomaji: titleRomaji,
      titleEnglish: titleEnglish,
      titleNative: titleNative,
      coverImage: coverImageLarge,
      bannerImage: bannerImage,
      status: status.isEmpty ? null : status,
      season: season,
      seasonYear: seasonYear,
    );
  }
}
