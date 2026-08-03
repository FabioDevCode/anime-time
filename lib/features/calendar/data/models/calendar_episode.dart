/// Représente un épisode à venir, indépendamment du schéma GraphQL AniList.
class CalendarEpisode {
  const CalendarEpisode({
    required this.animeId,
    required this.title,
    required this.nativeTitle,
    required this.coverImage,
    required this.bannerImage,
    required this.episode,
    required this.airingAt,
  });

  final int animeId;
  final String title;
  final String? nativeTitle;
  final String coverImage;
  final String? bannerImage;
  final int episode;
  final DateTime airingAt;
}
