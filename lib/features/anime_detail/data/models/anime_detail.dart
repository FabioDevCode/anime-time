class AnimeDetail {
  const AnimeDetail({
    required this.id,
    required this.status,
    required this.genres,
    this.idMal,
    this.titleRomaji,
    this.titleNative,
    this.description,
    this.coverImageLarge,
    this.bannerImage,
    this.episodes,
    this.duration,
    this.season,
    this.seasonYear,
    this.averageScore,
    this.nextAiringEpisode,
  });

  final int id;
  final int? idMal;
  final String? titleRomaji;
  final String? titleNative;
  final String? description;
  final String? coverImageLarge;
  final String? bannerImage;
  final int? episodes;
  final int? duration;
  final String status;
  final String? season;
  final int? seasonYear;
  final int? averageScore;
  final List<String> genres;
  final NextAiringEpisode? nextAiringEpisode;

  factory AnimeDetail.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as Map<String, dynamic>?;
    final coverImage = json['coverImage'] as Map<String, dynamic>?;
    final nextAiringEpisode =
        json['nextAiringEpisode'] as Map<String, dynamic>?;

    return AnimeDetail(
      id: json['id'] as int,
      idMal: json['idMal'] as int?,
      titleRomaji: title?['romaji'] as String?,
      titleNative: title?['native'] as String?,
      description: json['description'] as String?,
      coverImageLarge: coverImage?['large'] as String?,
      bannerImage: json['bannerImage'] as String?,
      episodes: json['episodes'] as int?,
      duration: json['duration'] as int?,
      status: json['status'] as String? ?? '',
      season: json['season'] as String?,
      seasonYear: json['seasonYear'] as int?,
      averageScore: json['averageScore'] as int?,
      genres: (json['genres'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
      nextAiringEpisode: nextAiringEpisode == null
          ? null
          : NextAiringEpisode.fromJson(nextAiringEpisode),
    );
  }
}

class NextAiringEpisode {
  const NextAiringEpisode({required this.episode, required this.airingAt});

  final int? episode;
  final int? airingAt;

  factory NextAiringEpisode.fromJson(Map<String, dynamic> json) {
    return NextAiringEpisode(
      episode: json['episode'] as int?,
      airingAt: json['airingAt'] as int?,
    );
  }
}
