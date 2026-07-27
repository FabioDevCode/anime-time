class AnimeMedia {
  const AnimeMedia({
    required this.id,
    required this.status,
    this.coverImageLarge,
    this.titleRomaji,
    this.titleEnglish,
    this.titleNative,
  });

  final int id;
  final String status;
  final String? coverImageLarge;
  final String? titleRomaji;
  final String? titleEnglish;
  final String? titleNative;

  factory AnimeMedia.fromJson(Map<String, dynamic> json) {
    return AnimeMedia(
      id: json['id'] as int,
      status: json['status'] as String? ?? '',
      coverImageLarge: json['coverImage']?['large'] as String?,
      titleRomaji: json['title']?['romaji'] as String?,
      titleEnglish: json['title']?['english'] as String?,
      titleNative: json['title']?['native'] as String?,
    );
  }
}
