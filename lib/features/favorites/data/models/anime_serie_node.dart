class AnimeSerieNode {
  const AnimeSerieNode({
    required this.id,
    this.format,
    this.titleRomaji,
    this.titleEnglish,
    this.titleNative,
    this.coverImage,
    this.bannerImage,
    this.episodes,
    this.status,
    this.season,
    this.seasonYear,
    required this.relations,
  });

  final int id;
  final String? format;
  final String? titleRomaji;
  final String? titleEnglish;
  final String? titleNative;
  final String? coverImage;
  final String? bannerImage;
  final int? episodes;
  final String? status;
  final String? season;
  final int? seasonYear;
  final List<AnimeSerieRelation> relations;

  factory AnimeSerieNode.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as Map<String, dynamic>?;
    final coverImage = json['coverImage'] as Map<String, dynamic>?;
    final edges = (json['relations']?['edges'] as List<dynamic>?) ?? const [];

    return AnimeSerieNode(
      id: json['id'] as int,
      format: json['format'] as String?,
      titleRomaji: title?['romaji'] as String?,
      titleEnglish: title?['english'] as String?,
      titleNative: title?['native'] as String?,
      coverImage: coverImage?['large'] as String?,
      bannerImage: json['bannerImage'] as String?,
      episodes: json['episodes'] as int?,
      status: json['status'] as String?,
      season: json['season'] as String?,
      seasonYear: json['seasonYear'] as int?,
      relations: edges
          .whereType<Map<String, dynamic>>()
          .map(AnimeSerieRelation.fromJson)
          .toList(),
    );
  }
}

class AnimeSerieRelation {
  const AnimeSerieRelation({
    required this.relationType,
    required this.nodeId,
    this.nodeFormat,
  });

  final String relationType;
  final int nodeId;
  final String? nodeFormat;

  factory AnimeSerieRelation.fromJson(Map<String, dynamic> json) {
    final node = json['node'] as Map<String, dynamic>? ?? {};
    return AnimeSerieRelation(
      relationType: json['relationType'] as String? ?? '',
      nodeId: node['id'] as int,
      nodeFormat: node['format'] as String?,
    );
  }
}
