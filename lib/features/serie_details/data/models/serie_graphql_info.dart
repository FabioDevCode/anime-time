class SerieGraphqlInfo {
  const SerieGraphqlInfo({
    required this.status,
    required this.genres,
    this.description,
    this.coverImageLarge,
    this.bannerImage,
    this.duration,
    this.season,
    this.seasonYear,
    this.averageScore,
  });

  final String? description;
  final String? coverImageLarge;
  final String? bannerImage;
  final String status;
  final List<String> genres;
  final int? duration;
  final String? season;
  final int? seasonYear;
  final int? averageScore;

  factory SerieGraphqlInfo.fromJson(Map<String, dynamic> json) {
    final coverImage = json['coverImage'] as Map<String, dynamic>?;
    return SerieGraphqlInfo(
      description: json['description'] as String?,
      coverImageLarge: coverImage?['large'] as String?,
      bannerImage: json['bannerImage'] as String?,
      status: json['status'] as String? ?? '',
      genres: (json['genres'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
      duration: json['duration'] as int?,
      season: json['season'] as String?,
      seasonYear: json['seasonYear'] as int?,
      averageScore: json['averageScore'] as int?,
    );
  }
}
