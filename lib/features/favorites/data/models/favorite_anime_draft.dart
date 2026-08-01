/// Données AniList nécessaires pour enregistrer un anime en favori.
class FavoriteAnimeDraft {
  const FavoriteAnimeDraft({
    required this.animeId,
    this.titleRomaji,
    this.titleEnglish,
    this.titleNative,
    this.coverImage,
    this.bannerImage,
    this.status,
    this.season,
    this.seasonYear,
  });

  final int animeId;
  final String? titleRomaji;
  final String? titleEnglish;
  final String? titleNative;
  final String? coverImage;
  final String? bannerImage;
  final String? status;
  final String? season;
  final int? seasonYear;
}
